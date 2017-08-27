package dst.components;

import dst.types.ReplicaComponent;

/**
 * data/scripts/components/combat_replica.lua
 */
extern class CombatReplica extends ReplicaComponent
{
	public function GetWeapon(): EntityScript;

	/**
	 * Only the getter is valid on the client side.
	 */
	public function MinAttackPeriod(): Float;

	dynamic public function IsAlly(guy:EntityScript): Bool;

	public function GetAttackRangeWithWeapon(): Float;

	public function CanHitTarget(target:EntityScript): Bool;

	public function IsRecentTarget(target:EntityScript): Bool;

	public function CanTarget(target:EntityScript): Bool;

	public function GetTarget(): EntityScript;
}