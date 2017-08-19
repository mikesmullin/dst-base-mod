package dst;

import Utils.DynamicObject;
import dst.compiled.Entity;

/**
 * data/scripts/main.lua
 *
 * The first Lua script loaded by the compiled engine;
 * responsible for:
 * - bootstrapping
 * - importing custom Lua dependencies in the global scope
 * - importing official game logic
 * - importing enabled third-party mods
 * - establishing the title screen state
 */
@:native("_G")
extern class Main
{
	/**
	 * Defined per Lua file/chunk, never accessed again by code.
	 * May be read from debug tooling as a kind of trace statement.
	 */
	static public var MAIN(default, never): Int; // 1

	static public var ENCODE_SAVES: Bool; // BRANCH ~= "dev" true
	static public var CHEATS_ENABLED: Bool; // BRANCH == "dev" false
	static public var SOUNDDEBUG_ENABLED: Bool; // false
	static public var WORLDSTATEDEBUG_ENABLED: Bool; // false
	static public var DEBUG_MENU_ENABLED: Bool; // BRANCH == "dev" false
	static public var METRICS_ENABLED: Bool; // PLATFORM ~= "ps4" true
	static public var TESTING_NETWORK: Int; // 1
	static public var AUTOSPAWN_MASTER_SLAVE: Bool; // false
	static public var DEBUGRENDER_ENABLED: Bool; // true
	static public var SHOWLOG_ENABLED: Bool; // true

	// Networking related configuration
	static public var DEFAULT_JOIN_IP: String; // "127.0.0.1"
	static public var DISABLE_MOD_WARNING: Bool; // false
	static public var DEFAULT_SERVER_SAVE_FILE: String; // "/server_save"

	static public var RELOADING: Bool; // false

	static public var ExecutingLongUpdate: Bool; // false

	/**
	 * HTTP address to the game server.
	 */
	static public var GAME_SERVER: String; // "http://dontstarve-release.appspot.com"

	/**
	 * Used for A/B testing and preview features.
	 * Gets serialized into and out of save games.
	 */
	static public var GameplayOptions: DynamicObject;

	static public var RequiredFilesForReload: DynamicObject;

	static public var VERBOSITY_LEVEL: VERBOSITY;

	static public var TheMixer: {};

	static public var Prefabs: Array<Dynamic>;
	static public var Ents: Map<dst.types.GUID, dst.compiled.Entity>;
	static public var AwakeEnts: Array<Dynamic>;
	static public var UpdatingEnts: Array<Dynamic>;
	static public var NewUpdatingEnts: Array<Dynamic>;
	static public var StopUpdatingEnts: Array<Dynamic>;
	static public var StopUpdatingComponents: Array<Dynamic>;
	static public var WallUpdatingEnts: Array<Dynamic>;
	static public var NewWallUpdatingEnts: Array<Dynamic>;
	static public var num_updating_ents: Int;
	static public var NumEnts: Int;

	/**
	 * "This is here so mods dont crash
	 * because one of our prefab scripts missed the local
	 * and a number of mods were erroneously abusing it"
	 *   -- Klei team
	 */
	static private var prefabs: Dynamic; // nil

	static public var TheGlobalInstance: {}; // nil
	static public var TheCamera: {}; // nil
	static public var ShadowManager: {}; // nil
	static public var RoadManager: {}; // nil
	static public var EnvelopeManager: {}; // nil
	static public var PostProcessor: {}; // nil

	static public var FontManager: {}; // nil
	static public var MapLayerManager: {}; // nil
	static public var Roads: {}; // nil
	static public var TheFrontEnd: {}; // nil
	static public var TheWorld: World; // nil
	static public var TheFocalPoint: {}; // nil
	static public var ThePlayer: {}; // nil
	static public var AllPlayers: Array<Entity>; // {}
	static public var SERVER_TERMINATION_TIMER: Int; // -1

	/**
	 * Whether in-game or somewhere else (e.g., Title screen)
	 *
	 * Use Main.InGamePlay() instead.
	 */
	 @:deprecated
	static private var inGamePlay: Bool; // false by default
}

@:native("_G.VERBOSITY")
extern class VERBOSITY {
	public var ERROR: Int; // 0
	public var WARNING: Int; // 1
	public var INFO: Int; // 2
	public var DEBUG: Int; // 3
}