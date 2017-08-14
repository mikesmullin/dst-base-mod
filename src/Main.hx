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
import dst.Fonts.*;
import dst.Constants.*;

// import dst.Main;

class Main
{
	public static function main()
	{
		ModContext.injectLocalToGlobalAliases();

		#if debug
			log("debug mode is enabled.");
			// enable Debug Keys feature
			// - CTRL-R:  jumps from in game to the main menu and reloads all your scripts.
			// - Shift-Right: jumps from main menu into the first save slot.
			// - 0: jump to caves.

			CHEATS_ENABLED = true;
			require("debugtools");
			PRINT_SOURCE = true;
		#end

		// need an entity to subscribe an event listener
		var inst = CreateEntity();
		inst.ListenForEvent("entitywake", function(self, data) {
			log("event entitywake");
		}, inst);

		inst.ListenForEvent("onremove", function(self, data) {
			log("event onremove");
		}, inst);



		untyped AddSimPostInit(function() {
			log("AddSimPostInit");

			if (null == TheWorld) return;
			log("and TheWorld");

			inst.ListenForEvent("ms_newplayercharacterspawned", function(self, data) {
				log("event ms_newplayercharacterspawned");

				if (!InGamePlay()) return;
				log("and InGamePlay()");

				// var debuggee = require('vscode_debuggee');
				// debuggee.easyStart();
				// log("debuggee on");

				log("main() starting up...");







				// if data and data.player then
				// 		data.player.AnimState:SetMultColour(0,0,0,1)
				// 		data.player:Hide()
				// 		data.player.components.playercontroller:Enable(false)
				// 		data.player:DoTaskInTime(12*FRAMES, function(inst) 
				// 				data.player:Show()
				// 				data.player:DoTaskInTime(60*FRAMES, function(inst)
				// 						inst.components.colourtweener:StartTween({1,1,1,1}, 14*FRAMES, function(inst)
				// 								data.player.components.playercontroller:Enable(true)
				// 						end)
				// 				end)
				// 		end)
				// end
				// inst.sg:GoToState("spawn_pre")

				// debuggee.disable();
				// log("debuggee off");

			}, TheWorld);
			// inst:ListenForEvent("rez_player", OnRezPlayer)
		});

		untyped AddGamePostInit(function() {
			log("AddGamePostInit");
		});

		untyped AddPlayerPostInit(function() {
			log("AddPlayerPostInit");
		});

		// untyped AddClassPostConstruct(function() {
		// 	log("AddClassPostConstruct");
		// });


		
	}
}