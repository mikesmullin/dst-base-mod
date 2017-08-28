package utils;

import utils.Console.log;

class Debug
{
	/**
	 * Place on first line of main().
	 *
	 * NOTICE: You can/should also set from inside mods/modsettings.lua:
	 *
	 *   ForceEnableMod("base") // where "base" is the folder location to your mod
	 *   EnableModDebugPrint()
	 */
	static public function setup()
	{
		dst.ModContext.injectLocalToGlobalAliases();

		#if debug
			log("debug build");
			dst.Main.CHEATS_ENABLED = true;
			lua.Lua.require("debugtools");
			dst.DebugPrint.PRINT_SOURCE = true;
			dst.Main.DISABLE_MOD_WARNING = true;
		#end
	}
}