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
			DISABLE_MOD_WARNING = true;

			// NOTICE: You can/should also set from inside mods/modsettings.lua:
			// ForceEnableMod("base") // replace "base" with mod name
			// EnableModDebugPrint()
		#end

		// need an entity to subscribe an event listener
		var inst = CreateEntity();
		inst.ListenForEvent("entitywake", function(self, data) {
			log("event entitywake");
		}, inst);

		inst.ListenForEvent("onremove", function(self, data) {
			log("event onremove");
		}, inst);





		require("serpent");
		// TODO: split Entity into EntityScript and Entity types since inst.GetGUID() is invalid
		var bleuCheese = new dst.CompiledEngine.NetBool(inst.GUID, "bleucheese", "bleucheesedirty");
		inst.ListenForEvent("bleucheesedirty", function(e:dst.CompiledEngine.Entity) {
			log("bleu cheese dirtied to "+ bleuCheese.value());
			log(untyped serpent.dump(e));
			log(untyped serpent.dump(data));
		});
		bleuCheese.set(false);
		log("bleuCheese is now "+ bleuCheese.value());

		untyped AddSimPostInit(function() {
			log("AddSimPostInit");

			if (null == TheWorld) return;
			log("and TheWorld");

			// Commonly used client/server logic guards
			//
			// Mods should use these always to be clear about which side you want code to run on;
			// by default it runs on both sides, and this can be very wasteful!
			//
			// client hosted: DST > Play > Host Game > Generate/Resume World
			// client remote: DST > Play > Browse Games > Join
			// dedicated: Steam > Tools > Dont Starve Together Dedicated Server
			//
			// |                      | client hosted | client remote | dedicated |
			// --------------------------------------------------------------------
			// | TheWorld.ismastersim |      Y        |      N        |     Y     |
			// | TheNet.GetIsServer() |      Y        |      N        |     Y     |
			// | TheNet.isDedicated() |      N        |      N        |     Y     |
			// | TheNet.GetIsClient() |      N        |      Y        |     N     |
			// 
			// TheWorld.ismastersim == TheNet:GetIsServer() -- this is running on a computer hosting the game
			// not TheWorld.ismastersim == TheNet:GetIsClient() -- this is running on a computer joining a game
			// 
			// TheNet:IsDedicated() -- for dedicated servers
			//
			// NOTICE that client hosted means client and server share a single simulator;
			//        evaluating one instance of the logic for both client and server

			if (untyped TheNet.GetIsServer()) {
				log("I'm a server.");
			}

			if (untyped TheNet.GetIsClient()) {
				log("I'm a client.");
			}

			if (untyped TheNet.IsDedicated()) {
				log("I'm a dedicated server.");
			}
			else {
				log("I'm NOT a dedicated server.");
			}

			if (untyped TheWorld.ismastersim) {
				log("I'm a master simulator.");
			}
			else {
				log("I'm NOT a master simulator.");
			}




			// TODO: note list of all possible events somewhere
			// TODO: note in this event's description: only fires when player comes to life (not game resume)
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
			bleuCheese.set(true);
			log("bleuCheese is now "+ bleuCheese.value());
		});


		
	}
}