package;

import lua.Lua.*;
import Utils.*;
// TODO: simplify to dst.* ?
import dst.CompiledEngine.*;
import dst.Config.*;
import dst.DebugPrint.*;
import dst.ExplicitLuaClass.*;
import dst.Main.*;
import dst.MainFunctions.*;
import dst.ModContext;
import dst.Strict.*;
import dst.Vector3;
import dst.Vector3.Point;

// import dst.Main;

class Main
{
	public static function main()
	{
		ModContext.injectLocalToGlobalAliases();

	  require('vscode_debuggee').easyStart();

		log("main() starting up...");

		#if debug
			log("debug mode is enabled.");
			// enable Debug Keys feature
			// - CTRL-R:  jumps from in game to the main menu and reloads all your scripts.
			// - Shift-Right: jumps from main menu into the first save slot.
			// - 0: jump to caves.

			// Global.CHEATS_ENABLED = true;
			// Global.require("debugtools");
		#end

		// TODO: another way to do this is seen in main.lua defined in strict.lua
		//				ie. global("SERVER_TERMINATION_TIMER")
		// untyped __lua__("rawset(GLOBAL, \"PickMeatFirstGlobals\", PickMeatFirstGlobals)");

		// var isMaster : Bool = false;
		// var playerController : PlayerController;

	}
}