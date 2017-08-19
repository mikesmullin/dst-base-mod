package dst;

/**
 * data/scripts/prefabs.lua
 */
@:native("_G.Prefab")
extern class Prefab extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String, fn: Dynamic, assets: Array<Asset>,
		deps: {}, force_path_search: Bool);
}

@:native("_G.Asset")
extern class Asset extends ExplicitLuaClass
{
	@:selfCall
	public function new(type: Dynamic, file: Dynamic, param: Dynamic);
}

