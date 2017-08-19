package dst.compiled;

import haxe.extern.Rest;
import haxe.Constraints.Function;

/**
 * bin/dontstarve_steam.exe
 *
 * Interfaces defined by the binary.
 * Logic compiled to hardware-accelerated machine code.
 * Provided to Lua sandbox via globals at runtime.
 * 
 * Includes some definitions only found by inspecting
 * the scope, never defined or referenced by Lua code.
 */
@:native("_G")
extern class Globals
{
	/**
	 * Build information.
	 */
	static public var APP_BUILD_DATE(default,never): String; // "2144"
	static public var APP_BUILD_TIME(default,never): String; // "11:01:52"
	static public var APP_REGION(default,never): APP_REGION; // "NONE"
	static public var APP_VERSION(default,never): String; // "226323"
	static public var BRANCH(default,never): BRANCH; // "release"
	static public var CONFIGURATION(default,never): CONFIGURATION; // "PRODUCTION"
	static public var PLATFORM(default,never): PLATFORM; // "WIN32_STEAM"

	/**
	 * Klei account username.
	 */
	static public var Account(default,never): String; // "UNKNOWN"

	/**
	 * Whether player may use the developer console.
	 */
	static public var CONSOLE_ENABLED: Bool; // true

	/**
	 * Runtime current working directory.
	 */
	static public var CWD(default,never): String; // "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\data"

	/**
	 * May disable loading of all mods.
	 */
	static public var MODS_ENABLED: Bool; // true
	
	/**
	 * Path to mod directory.
	 * Used like MODS_ROOT + modname + "/modinfo.lua".
	 */
	static public var MODS_ROOT(default,never): String; // "../mods/"

	/**
	 * Only used in two places by gamelogic.lua which cooperates
	 * by printing relevant debug information pertaining to
	 * on-screen/in-memory runtime texture data.
	 */
	static public var PRINT_TEXTURE_INFO: Bool; // false

	/**
	 * One-time preload of global assets (ie. fonts, sounds).
	 */
	static public var RUN_GLOBAL_INIT: Bool; // true

	/**
	 * Global service singleton instances.
	 */
	static public var TheGameService(default,never): GameService;
	static public var TheInputProxy(default,never): InputProxy;
	static public var TheInventory(default,never): InventoryProxy;
	static public var TheItems(default,never): ItemServerProxy;
	static public var TheNet(default,never): NetworkProxy;
	static public var TheRawImgui(default,never): RawImgui;
	static public var TheShard(default,never): ShardProxy;
	static public var TheSim(default,never): Sim;
	static public var TheSystemService(default,never): SystemService;

	/**
	 * Alias for StackTrace(err)
	 */
	static public function _TRACEBACK(err:Dynamic): Dynamic;

	/**
	 * Launch browser.
	 */
	static public function VisitURL(url:String, ?notrack:Bool): Void;

	/**
	 * ∠a - ∠b normalized within 360°.
	 */
	static public function anglediff(a:Float, b:Float): Float;

	/**
	 * Unused.
	 * @returns a new table instance.
	 */
	@:deprecated
	static public function createTable(): Dynamic;

	/**
	 * Like a 32-bit CRC.
	 * @param {String} s - Input sequence.
	 * @return Presumably unique unsigned 32-bit integer.
	 */
	static public function hash(s:String): dst.types.Hash;

	/**
	 * Like a 32-bit CRC.
	 * Name indicates it is more effective for input values
	 * which are smaller in byte size.
	 * @param {String} s - Input sequence.
	 * @return Presumably unique unsigned 32-bit integer.
	 */
	static public function smallhash(): dst.types.Hash;

	/**
	 * Determine whether a file exists.
	 * Perhaps for security cases when
	 * io.open() and similar methods are sandboxed.
	 */
	static public function kleifileexists(filename:String): Bool;

	/**
	 * Load a lua module.
	 * Again perhaps for security cases when
	 * require() and similar methods are sandboxed.
	 */
	static public function kleiloadlua(filename:String): Function;

	/**
	 * 3D Perlin noise generator.
	 */
	static public function perlin(x:Float, y:Float, z:Float): Float;

	/**
	 * Exclusively used to copy Lua variable arguments (...)
	 * into an array data structure.
	 * Non-null variant.
	 */
	static public function toarray(args:Rest<Dynamic>): Array<Dynamic>;

	/**
	 * Exclusively used to copy Lua variable arguments (...)
	 * into an array data structure,
	 * or a nil value.
	 */
	static public function toarrayornil(args:Rest<Dynamic>): Null<Array<Dynamic>>;

	/**
	 * Like a normal Lua assert(), except
	 * @returns a function pointer instead of a string.
	 */
	static public function tracked_assert(v:Bool, ?message:String): Dynamic;

	/**
	 * UTF-8 string utility functions.
	 */
	static public function utf8strlen(): Dynamic;
	static public function utf8strtolower(): Dynamic;
	static public function utf8strtoupper(): Dynamic;
	static public function utf8substr(): Dynamic;

	/**
	 * Real-world elapsed time since program start in seconds
	 * with decimal.
	 * Only used by profiler;
	 * for microsecond resolution/accuracy.
	 */
	static public function walltime(): Float;

	/**
	 * Unused.
	 * @returns an integer that is always different and always higher than the last.
	 *   Probably a count of cleaned up objects.
	 */
	@:deprecated
	static public function gcinfo(): Int;

	/**
	 * Unused.
	 * @returns reference to a userdata object.
	 */
	@:deprecated
	static public function newproxy(): Dynamic;
}

/**
 * Typical release tier designations.
 */
@:enum
abstract BRANCH(String)
{
	var dev = "dev";
	var staging = "staging";
	var release = "release";
}

/**
 * Whether to enable debug code paths;
 * regardless of BRANCH.
 */
@:enum
abstract CONFIGURATION(String)
{
	var PRODUCTION = "PRODUCTION";
}

/**
 * The various build platforms targeted.
 */
@:enum
abstract PLATFORM(String)
{
	var PS4 = "PS4";
	var WIN32_STEAM = "WIN32_STEAM";
	var OSX_STEAM = "OSX_STEAM";
	var LINUX_STEAM = "LINUX_STEAM";
	var ANDROID = "ANDROID";
	var NACL = "NACL"; // Chrome Native Client
}

/**
 * The various release regions targeted.
 */
@:enum
abstract APP_REGION(String)
{
	var NONE = "NONE";
	var SCEJ = "SCEJ";
}