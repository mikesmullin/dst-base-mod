package dst;

/**
 * data/scripts/mainfunctions.lua
 */
@:native("_G")
extern class MainFunctions // Externs
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

	/**
	 * Spawn a new Prefab instance into the simulation.
	 */
	static public function SpawnPrefab(name: String, skin: String, skin_id: String, creator: String): EntityScript;

	static public function GetTickTime(): Float;
	static public function GetTime(): Float;
	static public function GetTick(): Float;
	static public function GetTimeReal(): Float;

	// TODO: finish this
}