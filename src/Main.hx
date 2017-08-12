package;

import lua.Lua.*;
import Utils.*;
import dst.CompiledEngine.*;
import dst.CompiledEngine.AccountManager;
import dst.CompiledEngine.NetBool;

// import dst.Main;

class Main
{
	public static function main()
	{
		dst.ModContext.injectLocalToGlobalAliases();

		AccountManager.AddGameKeyToAccount();
		function isCoolDirty() {}
		var b = new NetBool("abcd-efgh-ijkl-mnop", "base_mod.isCool", "isCoolDirty");
		b.set(true);
		b.set_local(false);
		trace(b.value());
		
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