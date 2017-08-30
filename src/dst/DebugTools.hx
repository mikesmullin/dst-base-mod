package dst;

 /**
  * data/scripts/debugtools.lua
  */
@:native("_G")
extern class DebugTools // Externs
{
	/**
	 * Serialize a lua.Table to string for logging.
	 */
	static public function dumptable<K,V>(obj:Dynamic, ?indent:String, ?recurse_levels: Int, ?visit_table: Bool): Void;

	/**
	 * Return Lua runtime stack trace of callee for logging.
	 */
	static public function debugstack(?start: Int, ?top: Int, ?bottom: Int): String;
}