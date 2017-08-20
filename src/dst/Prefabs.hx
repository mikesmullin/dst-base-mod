package dst;

private typedef PrefabFunction = Void -> EntityScript;

/**
 * data/scripts/prefabs.lua
 *
 * Prefab defines an entity in the game.
 * This is where all the components are set up and configured.
 * A Prefab also contains some local functions
 * which are used as callbacks for the components.
 */
@:native("_G.Prefab")
extern class Prefab extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String,
		fn: PrefabFunction,
		assets: lua.Table<Int,Asset>,
		deps: lua.Table<Int,Prefab>,
		force_path_search: Bool);
	
	public var name: String;
	public var desc: String;
	public var fn: PrefabFunction;
	public var assets: lua.Table<Int,Asset>;
	public var deps: lua.Table<Int,Prefab>;
	public var force_path_search: Bool;
}

/**
 * Represents an art file on the disk.
 */
@:native("_G.Asset")
extern class Asset extends ExplicitLuaClass
{
	@:selfCall
	public function new(type: String, file: String, param: Dynamic);

	public var type: String;
	public var file: String;
	public var param: Dynamic;
}

