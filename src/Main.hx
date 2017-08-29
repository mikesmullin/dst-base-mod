package;

import utils.Console;
import utils.Console.lit;
import utils.Console.inn;
import dst.EntityScript;
import dst.types.TagName;
import utils.Lua.ipairs;

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
				// debug traces
				Console.println("--");
				Console.log("PlayerController:GetAttackTarget()");

				// Console.log("  "+ (force ? 'force TRUE' : 'force FALSE'));
				// Console.trace("  "+ (null != target ? 'target '+ target.prefab : 'target NULL'));
				// if (null != target) Console.println(target.GetDebugString());
				// Console.trace("  "+ (retry ? 'retry TRUE' : 'retry FALSE'));

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

				/**
				 * @returns true to proceed attacking, false to cancel attack.
				 */ 
				function ValidAttackTarget(target:EntityScript):Bool
				{
					return (
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
							// target is outside reach
							// TODO: deduplicate this calculation by doing it on validation only or returning the value by sharing outside dist var
					    lit("player distance to target %s outside reach "+
							
							"distance between target and player "+
							(target.GetDistanceSqToPoint(playerCoords.x, 0, playerCoords.z)) + " > " + 
							"area radius player can reach within "+
							lua.Math.pow(playerReach + ((null == target.Physics) ? 0 :
									target.Physics.GetRadius()), 2)
							
							, function() return target.GetDistanceSqToPoint(playerCoords.x, 0, playerCoords.z) >
								lua.Math.pow(playerReach + ((null == target.Physics) ? 0 :
									target.Physics.GetRadius()), 2), "is", "is not")
						)
					);
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


				// in one pass:
				// return immediately if any high priority scenarios
				// otherwise, return the nearest valid entity
				var nearestDist = lua.Math.huge;
				for (pair in ipairs(nearbyEntities))
				{
					var entity = pair.value;
					if (entity == player) continue;
					
					lit("  ===> iterating nearby entity %s", entity, null == entity ? "?" : entity.prefab, "BUT GOT NULL");
					if (ValidAttackTarget(entity))
					{

						var dsq = lit("distance squared to entity is %s", player.GetDistanceSqToInst(entity), function(p) return ""+p, "falsy wtf?");
						var dist:Float;
						if (dsq <= 0)
						{
							dist = 0;
						}
						else if (null != entity.Physics)
						{
							dist = lua.Math.max(0, lua.Math.sqrt(dsq) - entity.Physics.GetRadius());
						}
						else {
							dist = lua.Math.sqrt(dsq);
						}

						if (dist < nearestDist)
						{
							nearestDist = dist;
							target = entity;
						}
					}

					// TODO: that other code was saying that if one of the targets within range ive hit before
					// and its valid. then attack it again regardless of whether its closer
				}

				// if (null != target) Console.log(target.GetDebugString());
				lit("the nearest valid target was %s", target, function(t) return t.prefab +" at "+ nearestDist, "null");
				return target;


				// var target:EntityScript = null;
				// Console.log('check 1');
				// Console.log('no specific target ... will find one');
				// // then our prioritization depends on weapon in hand
				// var weapon = combat.GetWeapon();
				// if (null != weapon && weapon.HasTag(icestaff))
				// {
				// 	Console.log('has ice staff');

				// 	Console.log('would prioritize walrus here');
				// 	// target = ???

				// 	// if (null != target.components.freezable &&
				// 	// 	target.components.freezable.IsFrozen())
				// 	// {
				// 	// 	Console.log('target is frozen');
				// 	// 	// no point in re-freezing
				// 	// 	ally = true;
				// 	// }
				// 	// else {
				// 	// 	Console.log('target is not frozen');
				// 	// 	ally = false;
				// 	// }
				// 	// }
				// }
				
				// return target;
			};
		});

		dst.ModUtil.AddClassPostConstruct("components/combat_replica", function(combat:dst.components.CombatReplica)
		{
			var oldIsAlly = combat.IsAlly;
			combat.IsAlly = function(target:EntityScript): Bool
			{
				Console.log("combat replica IsAlly()");

				var ally = oldIsAlly(target);
				if (ally) {
					return ally;
				}

				var weapon = combat.GetWeapon();
				
				if (null != weapon && weapon.HasTag(ICESTAFF))
				{
					if (null != target.components.freezable &&
						target.components.freezable.IsFrozen())
					{
						// no point in re-freezing
						ally = true;
					}
					else {
						ally = false;
					}
				}

				return ally;
			};
		});
		
	}
}