package;

import lua.Lua.*;
import Utils.*;

class Main
{
	public static function main()
	{
		dst.ModContext.injectLocalToGlobalAliases();

		#if debug
			log("debug mode is enabled.");
			// enable Debug Keys feature
			// - CTRL-R:  jumps from in game to the main menu and reloads all your scripts.
			// - Shift-Right: jumps from main menu into the first save slot.
			// - 0: jump to caves.

			dst.Main.CHEATS_ENABLED = true;
			require("debugtools");
			dst.DebugPrint.PRINT_SOURCE = true;
			dst.Main.DISABLE_MOD_WARNING = true;

			// NOTICE: You can/should also set from inside mods/modsettings.lua:
			// ForceEnableMod("base") // replace "base" with mod name
			// EnableModDebugPrint()
		#end




		// need an entity to subscribe an event listener
		var inst = dst.MainFunctions.CreateEntity();
		inst.ListenForEvent("entitywake", function(self, ?data) {
			log("event entitywake");
		}, inst);

		inst.ListenForEvent("onremove", function(self, ?data) {
			log("event onremove");
		}, inst);







		dst.ModUtil.ModUtilExterns.AddSimPostInit(function() {
			log("AddSimPostInit");

			if (null == dst.Main.TheWorld) return;
			log("and TheWorld");

			if (dst.compiled.Globals.TheNet.GetIsServer()) {
				log("I'm a server.");
			}

			if (dst.compiled.Globals.TheNet.GetIsClient()) {
				log("I'm a client.");
			}

			if (dst.compiled.Globals.TheNet.IsDedicated()) {
				log("I'm a dedicated server.");
			}
			else {
				log("I'm NOT a dedicated server.");
			}

			if (dst.Main.TheWorld.ismastersim) {
				log("I'm a master simulator.");
			}
			else {
				log("I'm NOT a master simulator.");
			}



			// TODO: note list of all possible events somewhere
			// TODO: note in this event's description: only fires when player comes to life (not game resume)
			inst.ListenForEvent("ms_newplayercharacterspawned", function(self, ?data) {
				log("event ms_newplayercharacterspawned");

				if (!dst.MainFunctions.InGamePlay()) return;
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

			}, dst.Main.TheWorld);
			// inst:ListenForEvent("rez_player", OnRezPlayer)
		});

		dst.ModUtil.ModUtilExterns.AddGamePostInit(function() {
			log("AddGamePostInit");


			
		});

		dst.ModUtil.ModUtilExterns.AddPlayerPostInit(function(inst:dst.EntityScript) {
			log("AddPlayerPostInit");

			// TODO: move into api class doc blocks
			//  If the networked entity has :AddTag("CLASSIFIED"), then it won't show up to other clients?

			// var inst = CreateEntity();
			// inst.entity.AddNetwork();
			// log("inst GUID is "+ inst.GUID);
			// inst.entity.AddTag('CLASSIFIED');

			// TODO: split Entity into EntityScript and Entity types since inst.GetGUID() is invalid
			var bleuCheese = null;
			bleuCheese = new dst.compiled.NetVars.NetBool(inst.GUID, "bleucheese", "bleuCheesedirty");
			// if (TheNet.GetIsClient()) {

				// TODO: document requirements: this event will not fire unless inst is like network enabled entity or something
				inst.ListenForEvent("bleuCheeseDirty", function(e:dst.EntityScript, ?data:Dynamic) {
					var serpent = require("serpent");
					log("bleu cheese dirtied to "+ bleuCheese.value());
					log(untyped __lua__('serpent.block')(e));
					log(untyped __lua__('serpent.block')(data));
				});
			// }
			if (dst.compiled.Globals.TheNet.GetIsServer()) {
				bleuCheese.set(false);
			}
			// log("bleuCheese is "+ bleuCheese.value());



			if (dst.compiled.Globals.TheNet.GetIsServer()) {
				inst.DoTaskInTime(5, function() {
					bleuCheese.set(true);
				});
			}

			inst.DoTaskInTime(6, function() {
				log("bleuCheese is "+ bleuCheese.value());
			});

		});


		
	}
}