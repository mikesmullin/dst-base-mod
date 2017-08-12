package dst;

@:native("_G")
extern class Main
{
	static public var MAIN: Int; // 1
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
}