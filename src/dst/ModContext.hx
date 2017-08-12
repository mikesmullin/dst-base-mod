package dst;

import sys.io.File;

class ModContext
{
	public static macro function injectLocalToGlobalAliases()
	{
		// The Haxe Lua boilerplate that shows up at the top of
		// every compiled release includes several calls to 
		// normal Lua methods in the global namespace; it expects
		// them to be there.

		// However, for security, games like DST will sandbox
		// the Lua mod environment in various ways. In this case, the 
		// following methods which are normally global were actually
		// moved to another namespace.

		// Therefore, we're forced to use a sneaky macro to inject
		// the following local-to-global aliases just before the 
		// normal Haxe Lua boilerplate is defined.

		// NOTICE: This ONLY applies within the context of Lua mods.
		// If you are reading code outside of the mod/ directory
		// you will see it isn't subject to this restriction
		// and freely calls the normal globals directly without
		// a GLOBAL prefix. Be aware of that context switch if 
		// your application exists or escapes outside of the mod
		// sandbox context.

		haxe.macro.Context.onAfterGenerate(function() {
			var mainFile = haxe.macro.Compiler.getOutput();
			var compilerOutput = File.getContent(mainFile);
			File.saveContent(mainFile, 
				"local _G = GLOBAL\n\n" +
				"local pcall = _G.pcall\n"+
				"local getmetatable = _G.getmetatable\n"+
				"local getmetatable = _G.getmetatable\n"+
				"local setmetatable = _G.setmetatable\n"+
				"local rawset = _G.rawset\n"+
				"local select = _G.select\n" +
				"local debug = _G.debug\n"+	

				// If you are trying to reference a global from your own
				// script which is not defined here, this is not the place
				// for that. Instead use the import star approach, for example:
				// import haxe.Lua.*;

				compilerOutput);
		});
		
		return macro null;
	}
}