package dst;

import dst.types.Tag;
import dst.Prefabs.Prefab;
import dst.Prefabs.Asset;

/**
 * data/scripts/world.lua
 */
@:native("_G")
extern class WorldExterns { // Externs
	static public function MakeWorld(name: String,
		customPrefabs: Array<Prefab>,
		customAssets: Array<Asset>,
		common_postinit: Dynamic,
		master_postinit: Dynamic,
		tags: Array<Tag>
		): World;
}

/**
 * Don't reference this directly.
 * Use Main.TheWorld instead.
 */
extern class World extends EntityScript
{
	public var ismastersim: Bool;

	public var ismastershard: Bool;
	
	// TODO: finish
}