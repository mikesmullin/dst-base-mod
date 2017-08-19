package dst;

import haxe.Constraints.Function;
import haxe.ds.StringMap;
import Utils.DynamicObject;

/**
 * data/scripts/class.lua
 *
 * Helper to define a strict Lua class data structure.
 *
 * The Lua language does not provide class syntax.
 * Therefore, class data structure is what you make it.
 * As in JavaScript, there are best practices, but the closest
 * you can get to enforcing them is to make it as easy as possible
 * for the developer to make the correct choice.
 *
 * Used here to make stricter object-oriented classes in Lua.
 * 
 * Derivative of common open-source community conventions.
 */
@:native("_G.Class")
extern class ExplicitLuaClass
{
	@:selfCall // NOTICE: you must explicitly copy this compiler metadata to all subclass definitions!
	public function new(base: Dynamic, constructor: Function, props: StringMap<Dynamic>);

	/**
	 * Global list of all classes defined by this module.
	 */
	static public var ClassRegistry: DynamicObject;

	/**
	 * Track the number of class instances in memory.
	 */
	static public var ClassTrackingTable: StringMap<Int>;

	/**
	 * Make immutable all fields of a previously defined class.
	 */
	static public function makereadonly(className: String, fieldName: Dynamic): Void;

	/**
	 * Add a setter method of a given field name to previously defined class.
	 */
	static public function addsetter(className: String, fieldName: Dynamic, fn: Function): Void;

	/**
	 * Remove a setter method of a given field name from previously defined class.
	 */
	static public function removesetter(className: String, fieldName: Dynamic): Void;

	/**
	 * Unregisters previously defined class.
	 * (ie. in preparation for new replacement definition)
	 */
	static public function ReloadedClass(mt: String): Void;

	/**
	 * Minimum time to wait before calls to
	 * HandleClassInstanceTracking() are honored.
	 * The unit is the number of frames/ticks.
	 * Only called from update.lua Update().
	 */
	static public var ClassTrackingInterval: Int; // 100

	/**
	 * Print top 10 classes by most instances first.
	 * Refuses to print more frequently than ClassTrackingInterval.
	 */
	static public function HandleClassInstanceTracking(): Void;

}