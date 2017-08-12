package dst;

import Utils.DynamicObject;

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


}