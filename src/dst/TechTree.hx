package dst;

/**
 * data/scripts/techtree.lua
 *
 * Used to categorize recipes by tech level.
 * Should be an enum but its a list that can be modified at runtime.
 * Should be a global array of strings but instead its a strange
 * set of local values that have to be require()'d to get a reference.
 *
 * Usage:
 *   import dst.TechTree.TechTreeExterns.*;
 *   var tree = TechTree;
 *   tree.Create("NEWTECH");
 *   log(tree.AVAILABLE_TECH);
 *   log(dst.TechTree.TECH.SCIENCE);
 */
extern class TechTreeExterns // Externs
{
	static public var TechTree(get,never): TechTreeSingleton;
	static inline public function get_TechTree(): TechTreeSingleton
	{
		return require("techtree");
	}
}

private extern class TechTreeSingleton
{
	/**
	 * Authoritative list of technology tier possibilities.
	 * Dynamic, may vary at runtime with mod integrations.
	 * For initial value see TechTree.TECH enum below.
	 */
	public var AVAILABLE_TECH: lua.Table<Int, String>;
	public function Create(techName: String): String;
}

/**
 * Default tech tree when the game begins.
 *
 * Mods may add additional possibilities dynamically
 * at runtime via the TechTreeSingleton.AVAILABLE_TECH table.
 */
@:enum
abstract TECH(String)
{
	var SCIENCE = "SCIENCE"; // ie. science machine
	var MAGIC = "MAGIC"; // ie. hatinator
	var ANCIENT = "ANCIENT"; // ie. ancient altar
	var SHADOW = "SHADOW"; // ie. shadow manipulator
	var CARTOGRAPHY = "CARTOGRAPHY"; // ie. map drawing
	var SCULPTING = "SCULPTING"; // ie. marble sculptures
	var ORPHANAGE = "ORPHANAGE"; // ie. pet den
	var PERDOFFERING = "PERDOFFERING"; // ie. turkey shrine
}