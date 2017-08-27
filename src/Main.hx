package;

import utils.Logger.*;
import dst.EntityScript;
import dst.types.TagName;
import utils.Lua.ipairs;

@:enum
abstract Weapon(TagName) to TagName {
	var icestaff = "icestaff";
}

class Main
{
	public static function main()
	{
		dst.ModContext.injectLocalToGlobalAliases();

		#if debug
			log("debug mode is enabled.");
			// enable Debug Keys feature
			// - CTRL-R:  jumps from in game to the main menu and reloads all your scripts.
			// - Shift-Right: jumps from main menu into the first save slot.
			// - 0: jump to caves.

			dst.Main.CHEATS_ENABLED = true;
			lua.Lua.require("debugtools");
			dst.DebugPrint.PRINT_SOURCE = true;
			dst.Main.DISABLE_MOD_WARNING = true;

			// NOTICE: You can/should also set from inside mods/modsettings.lua:
			// ForceEnableMod("base") // replace "base" with mod name
			// EnableModDebugPrint()
		#end

		// this is overridden because its used but local only so out of scope
		// unless we redefine it
		function ValidateAttackTarget(
			combat:dst.components.CombatReplica,
			target:EntityScript,
			force_attack:Bool,
			x:Float,
			z:Float,
			has_weapon:Bool,
			reach:Float
		):Bool
		{
			if (!combat.CanTarget(target))
			{
				return false;
			}

			// no combat if light/extinguish target
			var targetcombat = target.replica.combat;
			if (null != targetcombat)
			{
				if (combat.IsAlly(target))
				{
					return false;
				}
				else if (!(force_attack ||
					combat.IsRecentTarget(target) ||
					targetcombat.GetTarget() == combat.inst))
				{
					// must use force attack non-hostile creatures
					if (!(target.HasTag("hostile") ||
						(has_weapon && target.HasTag("monster") && !target.HasTag("player"))))
					{
						return false;
					}
					// must use force attack on players' followers
					var follower = target.replica.follower;
					if (null != follower)
					{
						var leader = follower.GetLeader();
						if (null != leader &&
							leader.HasTag("player") &&
							leader.replica.combat.GetTarget() != combat.inst)
						{
							return false;
						}
					}
				}
			}

			// Now we ensure the target is in range
			// light/extinguish targets may not have physics
			var reach:Float = (target.Physics != null) ? reach + target.Physics.GetRadius() : reach;
			return target.GetDistanceSqToPoint(x, 0, z) <= reach * reach;
		}


		dst.ModUtil.AddClassPostConstruct("components/playercontroller", function(self:dst.components.PlayerController)
		{
			// NOTICE: This class is mostly copied logic from the core version
			// with minor modifications. This means any changes to core logic
			// in future DST releases will be lost until this mod is updated
			// or deactivated.
			// var oldGetAttackTarget = self.GetAttackTarget;
			self.GetAttackTarget = function(
				force_attack:Bool,
				force_target:EntityScript,
				isretarget:Bool
			):EntityScript
			{
				dst.DebugPrint.nolineprint("--");
				log("PlayerController:GetAttackTarget()");
				log("  "+ (force_attack ? 'force_attack TRUE' : 'force_attack FALSE'));
				log("  "+ (null != force_target ? 'force_target '+ force_target.prefab : 'force_target NULL'));
				log("  "+ (isretarget ? 'isretarget TRUE' : 'isretarget FALSE'));
				dst.DebugPrint.nolineprint(dst.DebugTools.debugstack());

				log("");
				if (self.inst.HasTag("playerghost") ||
					self.inst.replica.inventory.IsHeavyLifting())
				{
					return null;
				}

				log("");
				var combat = self.inst.replica.combat;
				if (null == combat) return null;

				log("");
				if (null != self.inst.sg)
				{
					if (self.inst.sg.HasStateTag("attack")) {
						return null;
					}
					else if (self.inst.HasTag("attack")) {
						return null;
					}
				}

				var coords = self.inst.Transform.GetWorldPosition();
				var attackrange = combat.GetAttackRangeWithWeapon();
				var rad = self.directwalking ? attackrange : (attackrange + 6);
				var reach = self.inst.Physics.GetRadius() + rad + 0.1;

				// Beaver teeth counts as having a weapon
				var has_weapon = self.inst.HasTag("beaver");
				if (!has_weapon)
				{
						var inventory = self.inst.replica.inventory;
						var tool = null != inventory ? inventory.GetEquippedItem(HANDS) : null;
						if (null != tool)
						{
								var inventoryitem = tool.replica.inventoryitem;
								has_weapon = null != inventoryitem && inventoryitem.IsWeapon();
						}
				}

				log("");
				if (isretarget &&
					combat.CanHitTarget(force_target) &&
					null != force_target.replica.health &&
					!force_target.replica.health.IsDead() &&
					dst.SimUtil.CanEntitySeeTarget(self.inst, force_target) &&
					ValidateAttackTarget(
						combat,
						force_target,
						force_attack,
						coords.x,
						coords.z,
						has_weapon,
						reach)
				) {
					return force_target;
				}

				if (null != force_target)
				{
					log("");
					return ValidateAttackTarget(
						combat,
						force_target,
						force_attack,
						coords.x,
						coords.z,
						has_weapon,
						reach) ? force_target : null;
				}

				// To deal with entity collision boxes we need to pad the radius.
				// Only include combat targets for auto-targetting, not light/extinguish
				// See entityreplica.lua (re: "_combat" tag)
				log("");
				var nearby_ents = dst.compiled.Globals.TheSim.FindEntities(
					coords.x,
					coords.y,
					coords.z,
					rad + 5,
					cast ["_combat"],
					cast ["INLIMBO"]);
				var nearest_dist = lua.Math.huge;
				isretarget = false; // reusing variable for flagging when we've found recent target
				force_target = null; // reusing variable for our nearest target

				log("");
				for (pair in ipairs(nearby_ents))
				{
					var nearbyEntity = pair.value;
					
					log("");
					if (ValidateAttackTarget(
							combat,
							nearbyEntity,
							force_attack,
							coords.x,
							coords.z,
							has_weapon,
							reach
						) &&
						dst.SimUtil.CanEntitySeeTarget(self.inst, nearbyEntity))
					{
						log("");
						var dsq = self.inst.GetDistanceSqToInst(nearbyEntity);
						var dist: Float;
						if (dsq <= 0)
						{
							dist = 0;
						}
						else if (nearbyEntity.Physics != null)
						{
							dist = lua.Math.max(0, lua.Math.sqrt(dsq) - nearbyEntity.Physics.GetRadius());
						}
						else {
							dist = lua.Math.sqrt(dsq);
						}
						if (!isretarget && combat.IsRecentTarget(nearbyEntity))
						{
							if (dist < attackrange + .1)
							{
								log("");
								return nearbyEntity;
							}
							isretarget = true;
						}
						if (dist < nearest_dist)
						{
							nearest_dist = dist;
							force_target = nearbyEntity;
						}
					}
					else if (!isretarget && combat.IsRecentTarget(nearbyEntity))
					{
						isretarget = true;
					}
				}

				log("");
				return force_target;


				// var target:EntityScript = null;
				// log('check 1');
				// log('no specific target ... will find one');
				// // then our prioritization depends on weapon in hand
				// var weapon = combat.GetWeapon();
				// if (null != weapon && weapon.HasTag(icestaff))
				// {
				// 	log('has ice staff');

				// 	log('would prioritize walrus here');
				// 	// target = ???

				// 	// if (null != target.components.freezable &&
				// 	// 	target.components.freezable.IsFrozen())
				// 	// {
				// 	// 	log('target is frozen');
				// 	// 	// no point in re-freezing
				// 	// 	ally = true;
				// 	// }
				// 	// else {
				// 	// 	log('target is not frozen');
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
				log("combat replica IsAlly()");

				var ally = oldIsAlly(target);
				if (ally) {
					return ally;
				}


				var weapon = combat.GetWeapon();
				
				if (null != weapon && weapon.HasTag(icestaff))
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

		dst.ModUtil.AddPlayerPostInit(function(player:EntityScript) {
			log("AddPlayerPostInit");

			// player.components.combat.GetWeapon().components.weapon.damage = 9999;

		});
		
	}
}

class B {}