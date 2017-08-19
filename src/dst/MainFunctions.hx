package dst;

import dst.compiled.Entity;

/**
 * data/scripts/mainfunctions.lua
 */
@:native("_G")
extern class MainFunctions
{
	/**
	 * Recommended method to create a new Entity.
	 *
	 * - Creates new Entity instance
	 * - wraps and returns in new EntityScript instance
	 * - increments Lua-side total Entity instance counter `NumEnts`
	 * - indexes Lua-side map of all Entity instances `Ents`
	 *
	 * Used extensively throughout Lua code.
	 */
	static public function CreateEntity(): EntityScript;

	/**
	 * Is set true after TheWorld is init.
	 */
	static public function InGamePlay(): Bool;

	// TODO: finish this
}