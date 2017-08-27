package dst;

import haxe.Constraints.Function;

/**
 * These are added to the mod sandbox as globals,
 * but not `GLOBAL` or `_G`. Since we need some object
 * to act as our class, can use `env` here.
 */
@:native("env")
extern class ModUtil // Externs
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

	/**
	 * Overrides the class constructor to include a call to the fn provided.
	 * Allows you to do whatever you want to the class before its constructor returns.
	 * Used by mods to override classes defined outside of the mod.
	 */
	public static function AddClassPostConstruct<T:ExplicitLuaClass>(classname: String, fn: T -> Void): Void;

	/**
	 * Identical to AddClassPostConstruct except it
	 * operates on classname from the global _G namespace after requiring pkg.
	 * If it cannot be found, then it forwards pkg to AddClassPostConstruct.
	 */
	public static function AddGlobalClassPostConstruct(pkg: String, classname: String, fn: ExplicitLuaClass -> Void): Void;

	/**
	 * Whether the current server has Player-vs-Player enabled.
	 */
	public static function GetServerPVP(): Bool;

	// TODO: finish
}