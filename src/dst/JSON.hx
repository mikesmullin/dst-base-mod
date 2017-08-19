package dst;

/**
 * data/scripts/json.lua
 */
@:native("_G.json")
extern class JSON
{
	static private var json_settings: String; // ""

	static public function decode(): Dynamic;
	static public function encode(): Dynamic;
	
	// static private var _M: {}; // table
	// static private var _NAME: String; // "json"
	// static private var _PACKAGE: String; // ""
	// @:native("null")
	// static private function _null(): Dynamic; // prefixed for Haxe compat
	// static private function object(): Dynamic;
}