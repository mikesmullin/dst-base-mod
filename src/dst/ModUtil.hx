package dst;

import haxe.Constraints.Function;

/**
 * These are added to the mod sandbox as globals,
 * but not `GLOBAL` or `_G`. Since we need some object
 * to act as our class, can use `env` here.
 */
@:native("env")
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