package dst;

import haxe.Constraints.Function;

@:native("_G")
extern class ModUtilExterns // Externs
{
	/**
	 * After TheSim has finished building the world.
	 * Happens before GamePostInit.
	 */
	public static function AddSimPostInit(fn: Function): Void;

	/**
	 * After InGamePlay() is true.
	 * Happens before PlayerPostInit.
	 */
	public static function AddGamePostInit(fn: Function): Void;

	/**
	 * After ThePlayer is created.
	 * Happens every time a player object is created
	 * including if loading a save game.
	 *
	 * NOTICE: ListenForEvent("ms_newplayercharacterspawned") only fires
	 *   if character spawns (ie. from death, or new game)
	 */
	public static function AddPlayerPostInit(fn: Function): Void;

	public static function AddGlobalClassPostConstruct(pkg: String, classname: String, fn: Function): Void;
	public static function AddClassPostConstruct(classname: String, fn: Function): Void;

	// TODO: finish
}