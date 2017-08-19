package dst;

/**
 * data/scripts/prefabs.lua
 */
@:native("_G")
extern class Prefab extends ExplicitLuaClass
{
	public function new(name: String, fn: Dynamic, assets: Array<Asset>,
		deps: {}, force_path_search: Bool);
}

@:native("_G")
extern class Asset extends ExplicitLuaClass
{
	public function new(type: Dynamic, file: Dynamic, param: Dynamic);
}

