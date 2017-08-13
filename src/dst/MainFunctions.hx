package dst;

import dst.CompiledEngine.Entity;

/**
 * data/scripts/mainfunctions.lua
 */
@:native("_G")
extern class MainFunctions
{
	/**
	 * Used exclusively; all Entity objects are made by this method.
	 */
	static public function CreateEntity(): Entity;

	/**
	 * Is set true after TheWorld is init.
	 */
	static public function InGamePlay(): Bool;
}