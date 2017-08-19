package dst;

import haxe.extern.Rest;
import Utils.DynamicObject;

 /**
  * data/scripts/strict.lua
	*
  * Checks uses of undeclared global variables
  * All global variables must be 'declared' through a regular assignment
  * (even assigning nil will do) in a main chunk before being used
  * anywhere or assigned to inside a function.
  *
	* Based on a commonly used open-source module for Lua.
  */
@:native("_G")
extern class Strict // Externs
{
	/**
	 * Indicates strict mode methods for Lua are
	 * enabled and present (strict.lua chunk is loaded).
	 */
	static public var __STRICT(default, never): Bool; // true

	/**
	 * Defines a variable name as belonging to the global scope.
	 * This whole class is unnecessary as everything is globally-
	 * scoped within Lua, unless the `local` keyword is used.
	 *
	 * Therefore this function is for individuals who prefer to
	 * acknowledge their global variables explicitly.
	 *
	 * Used inconsistently.
	 */
	static public function global(variableNames:Rest<String>): Void;
}

/**
 * MT stands for MetaTable.
 * see also: http://lua-users.org/wiki/MetamethodsTutorial
 */
@:native("_G.mt")
private extern class MT {
	static var __declared: DynamicObject;
	static var __newindex: Dynamic -> Dynamic -> Dynamic -> Void;
	static var __index: Dynamic -> Dynamic -> Dynamic;
}