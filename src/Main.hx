package;

import utils.Console;
import utils.Console.lit;
import utils.Console.inn;
import dst.EntityScript;
import dst.types.TagName;
import utils.Lua.ipairs;
import lua.Table;

/**
 * List of tags used by this file;
 * strongly typed to avoid typos and facilitate reuse.
 * Temporary location until a global list of all possible tags exists.
 */
@:enum
private abstract UsedTags(TagName) to TagName {
	var _COMBAT = cast "_combat";
	var ATTACK = cast "attack";
	var BEAVER = cast "beaver";
	var FIRESTAFF = cast "firestaff";
	var FIRE = cast "fire";
	var HOSTILE = cast "hostile";
	var ICESTAFF = cast "icestaff";
	var INLIMBO = cast "INLIMBO";
	var MONSTER = cast "monster";
	var PLAYER = cast "player";
	var PLAYERGHOST = cast "playerghost";
}

class Main
{
	public static function main()
	{
		utils.Debug.setup();

		if (!dst.compiled.Globals.TheNet.GetIsClient()) return;

		dst.ModUtil.AddClassPostConstruct("components/playercontroller", function(self:dst.components.PlayerController)
		{
			// NOTICE: This class is mostly copied logic from the core version
			// with minor modifications. This means any changes to core logic
			// in future DST releases will be lost until this mod is updated
			// or deactivated.
			// var oldGetAttackTarget = self.GetAttackTarget;

			/**
			 * @returns the nearest entity player can attack,
			 * or a previously attacked entity until its dead.
			 *
			 * @param force - Without specific intent from player, some targets are ignored.
			 * @param target - The entity to attack.
			 * @param retry - Whether target is among two most recent victims of player's attacks.
			 *   Implies target has been previously validated for attack. Facilitates faster
			 *   repeat hits, primarily by skipping the valid nearby entities search.
			 */
			self.GetAttackTarget = function(force:Bool, target:EntityScript, retry:Bool):EntityScript
			{
				// validation;
				// eliminate most common possibilities first.
				// leave most expensive analysis for last.

				var player:EntityScript = lit("player is %s", self.inst, function(p) return p.prefab, "null");
				
				if (
					lit("player is %s", function() return player.HasTag(PLAYERGHOST), "dead", "alive") ||
					lit("player is %s encumbered", function() return player.replica.inventory.IsHeavyLifting(), "VERY", "NOT") ||
					lit("player has %s combat ability", null == player.replica.combat, "NO", "the") ||
					lit("player attack animation %s playing",
						(lit("player has %s stategraph instance", null != player.sg, "a", "NO") && (
							lit("current state %s ATTACK", function() return player.sg.HasStateTag(ATTACK), "IS", "is not") ||
							lit("entity %s ATTACK tag (rendundant?)", function() return player.HasTag(ATTACK), "HAS", "has no")))
							, "IS", "is not")
				) {
					// abort before proximity search
					return null;
				}
	
				var playerCoords = player.Transform.GetWorldPosition();
				var attackRange:Float = player.replica.combat.GetAttackRangeWithWeapon();
				var walkingRange:Float = self.directwalking ? attackRange : (attackRange + 6);
				var playerReach:Float = player.Physics.GetRadius() + walkingRange + 0.1;
				var playerItemInHand = lit("playerItemInHand is %s",
					inn(player.replica.inventory, (function(inventory) return inventory.GetEquippedItem(HANDS))),
					function(item) return item.prefab, "NULL");
				var playerHasWeapon:Bool = lit("playerHasWeapon is %s", function() {
					if (player.HasTag(BEAVER)) return true; // beaver's gnaw is a weapon
					if (null != playerItemInHand) {
						var inventoryItem = playerItemInHand.replica.inventoryitem;
						if (null != inventoryItem) {
							if (inventoryItem.IsWeapon()) {
								return true;
							}
						}
					}
					return false;
				}, "true", "FALSE");

				// build a table of special interest tags pointing to nearby entities
				var nearestDist:Null<Float> = null;
				var interests:Map<String,EntityScript> = new Map();

				/**
				 * @returns true to proceed attacking, false to cancel attack.
				 */ 
				function ValidAttackTarget(target:EntityScript):Bool
				{
					var valid:Bool = (
						lit("target is %s", null != target, (function(_) return target.prefab), "NULL") &&
						lit("target %s combat ability", null != target.replica.combat, "has", "HAS NO") &&

						(
							// TODO: share an outside var indicating whether the player recognizes the target
							// and use that to short-circuit the iteration and choose that character? might hinder important targets tho
							( // recognized
								lit("retry is %s", retry, "true", "false") || // target is same as last time, or
								lit("target %s same as two times ago", player.replica.combat.IsRecentTarget(target), "is", "IS NOT")
							) || // or

							// target not recognized;
							// treat as new target;
							// one-time per-nearby-target validation
							!( // reasons to reject:
								lit("target %s", null == target.replica.health, "was never alive", "has health meter") ||
								(lit("player %s applying force", !force, "is not", "is") && // no force
									lit("target %s attacking player", function() return target.replica.combat.GetTarget() != player, "is not", "is") &&
									(lit("target %s hostile", function() return !target.HasTag(HOSTILE), "is not", "is") ||
										lit("target %s allied to player", function() return player.replica.combat.IsAlly(target), "is", "is not") ||
										// player should think twice
										(
											lit("player %s weapon", !playerHasWeapon, "has no", "has a") &&
											lit("target %s a monster", function() return target.HasTag(MONSTER), "is", "is not") // (e.g., ewecus, walrus)
										) ||
										lit("target %s another player", function() return target.HasTag(PLAYER), "is", "is not") ||
										(lit("target %s a follower", null != target.replica.follower, "is", "is not") && // target is a follower...
											lit("...and they have %s leader", function() return null != target.replica.follower.GetLeader(), "a", "NO") && // and their leader...
											lit("...their leader %s a player", function() return target.replica.follower.GetLeader().HasTag(PLAYER), "is", "is not") && // is another player...
											lit("...and that leader %s attacking our player", function() return target.replica.follower.GetLeader().replica.combat.GetTarget() != player, "is not", "is")) // and that player is not attacking our player
									)
								)
							)
						) && // if its still considered valid up to this point,
						// continue with more validation

						// per-attack validation;
						// happens every Update frame (keep checks low-latency)
						// happens to all targets incl. previously validated targets
						!( // reasons to reject:
							lit("target %s be targeted", function() return !player.replica.combat.CanTarget(target), "CANNOT", "can") ||
							(false && lit("target %s be hit", function() return !player.replica.combat.CanHitTarget(target), "CANNOT", "can")) || // (e.g., fire, freeze)
							lit("target %s died", function() return target.replica.health.IsDead(), "has", "has not") ||
							lit("player %s see target (expensive?)", function() return !dst.SimUtil.CanEntitySeeTarget(player, target), "CANNOT", "can") ||

							// custom; awww yeah boi!

							(lit("player %s item in hand", null != playerItemInHand, "has", "has no") && (
							// don't double-freeze folks, its a waste
								(lit("player %s ice staff", playerItemInHand.prefab == "icestaff", "has", "has no") &&

									// client-side check for being frozen
									lit("target %s AnimState", null != target.AnimState, "has", "has no") && (
										(lit("target animation %s \"frozen\"", target.AnimState.IsCurrentAnimation("frozen"), "is", "is not") ||
										lit("target animation %s \"frozen_loop_pst\"", target.AnimState.IsCurrentAnimation("frozen_loop_pst"), "is", "is not")))
								) ||

								// don't double-flame folks, its a waste
								(playerItemInHand.prefab == "firestaff" &&
									lit("target %s fire tag", target.HasTag(FIRE), "has", "does not have"))
							))

						)
					);

					if (!valid) return false;

					// target is outside reach
					var targetDistToPlayer = (target.GetDistanceSqToPoint(playerCoords.x, 0, playerCoords.z));
					var playerReachPlusTargetRadius = lua.Math.pow(playerReach +
						((null == target.Physics) ? 0 :	target.Physics.GetRadius()), 2);
						
					valid = valid && !lit("target %s outside reach; "+
						"targetDistToPlayer "+ targetDistToPlayer +" > "+
						"playerReachPlusTargetRadius "+ playerReachPlusTargetRadius,
						targetDistToPlayer > playerReachPlusTargetRadius, "is", "is not");

					if (!valid) return false;

					if (null == nearestDist || nearestDist > targetDistToPlayer) {
						nearestDist = targetDistToPlayer;
						interests.set("nearest", target);
					}

					/**
					 * Remember nearest entity per interest
					 */
					function nepi(s:String)
					{
						if (
							!interests.exists(s) ||
							targetDistToPlayer < interests.get(s)
								.GetDistanceSqToPoint(playerCoords.x, 0, playerCoords.z))
						{
							interests.set(s, target);
						}
					}
					nepi(target.prefab); // by prefab name
					
					// special case for things about to attack us
					if (target.HasTag(ATTACK) && target.replica.combat.GetTarget() == player) nepi("attack");

					return true;
				}
				
				// if target provided
				// do light re-validation
				Console.log("testing target that was passed in...");
				if (ValidAttackTarget(target))
				{
					return target; // ok to reuse
				}
				
				// otherwise, ignore it
				target = null;
				retry = false;

				// and find a new target
				Console.log("searching for nearby entity to target...");
				var nearbyEntities = lit("found %s nearby entities", function() { return
					dst.compiled.Globals.TheSim.FindEntities(
						playerCoords.x,
						playerCoords.y,
						playerCoords.z,
						walkingRange + 5,
						cast [_COMBAT],
						cast [INLIMBO]);
				}, function(t) return Std.string(utils.Lua.count(t)), "0");


				// NOTICE: only one pass necessary!
				for (pair in ipairs(nearbyEntities))
				{
					var entity = pair.value;
					if (entity == player) continue;
					
					lit("  ===> iterating nearby entity %s", entity, null == entity ? "?" : entity.prefab, "BUT GOT NULL");
					if (ValidAttackTarget(entity))
					{
						
					}
				}

				/**
				 * Set target to first matching key from interests.
				 * @returns if a match was found.
				 */
				function nearby(a:Array<String>):Bool
				{
					for (k in a)
					{
						var v = interests[k];
						if (null != v)
						{
							target = v;
							return true;
						}
					}
					return false;
				}

				/**
				 * @returns true if one of the listed prefab names
				 * is currently the item in the player's hand.
				 */
				function weap(prefabNames:Array<String>):Bool
				{
					if (null == playerItemInHand) return false;
					for (name in prefabNames)
					{
						if (name == playerItemInHand.prefab)
						{
							return true;
						}
					}
					return false;
				}

				// now decide which special interest to attack
				if (!(
					(weap(["icestaff"]) && nearby(["walrus", "canary", "robin_winter", "robin", "crow"])) ||
					(weap(["blowdart_pipe"]) && nearby(["icehound", "hound", "firehound"])) ||
					(weap(["boomerang"]) && nearby(["deerclops", "bearger", "walrus", "canary", "robin_winter", "robin", "crow"])) ||
					nearby(["attack"])
				))
				{
					target = interests["nearest"];
				}

				// if (null != target) Console.log(target.GetDebugString());
				lit("the best target was %s", target, function(t) return t.prefab +" at "+ nearestDist, "null");
				return target;

			};
		});
		
	}
}