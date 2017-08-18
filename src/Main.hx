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
			// | TheNet.IsDedicated() |      N        |      N        |     Y     |
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

		untyped AddPlayerPostInit(function(inst:dst.CompiledEngine.Entity) {
			log("AddPlayerPostInit");

			// TODO: move into api class doc blocks
			// only GUID from entity inst that have :AddNetwork() will be able to sync and trigger netvar events
			//  If the networked entity has :AddTag("CLASSIFIED"), then it won't show up to other clients?
			//
			// if listened on dedicated server side, it will trigger server side
			//
			// first arg to cb is entity inst
			// there is no second arg
			//
			//
			// if you set the netvar on client remote only, it will not trigger locally or remotely
			// its not an error to set or set_local and value() on client-only, but it won't trigger and it doesn't notify server or other clients
			//
			//
			// if you set netvar on client hosted, it will trigger locally (since local is both client and server, and there is only one sim)
			//
			// if you set netvar on dedicated, it will trigger server side and if the client has netvar definition on the client as well
			//
			// that thing about netvar entity unserialize error if one side doesn't have it is nuanced:
			//   - if the netvar is set on a networked entity both sides are using same GUID for, then there are no errors but things don't trigger or sync
			// 	- if the netvar is set on a networked entity but different GUID on both sides, you get a crash on the client side
			//       [00:00:23]: Assert failure 'false && "cNetworkConnection::AllocReplica Invalid Prefab"' at ..\source\networklib\NetworkConnection.cpp(121): Trace follows...
			//
			//
			// if you set netvar on client remote to dedicated, no trigger is sent to client or server and the value is only changed on client side
			//
			//
			// if you set netvar on dedicated or on client hosted server, trigger fires and value syncs on server and on client (in the case of client remote, only if netvar is also set with listener)
			// this is the intended use case
			//
			// event callback string name does not have to be all lowercase; can have uppercase
			// but the event names are case-sensitive so it has to match between net_var definition and :ListenForEvent() reference
			//


			// var inst = CreateEntity();
			// inst.entity.AddNetwork();
			// log("inst GUID is "+ inst.GUID);
			// inst.addTag('CLASSIFIED');

			// TODO: split Entity into EntityScript and Entity types since inst.GetGUID() is invalid
			var bleuCheese = null;
			bleuCheese = new dst.CompiledEngine.NetBool(inst.GUID, "bleucheese", "bleuCheesedirty");
			// if (TheNet.GetIsClient()) {

				// TODO: document requirements: this event will not fire unless inst is like network enabled entity or something
				inst.ListenForEvent("bleuCheeseDirty", function(e:dst.CompiledEngine.Entity, data:Dynamic) {
					var serpent = require("serpent");
					log("bleu cheese dirtied to "+ bleuCheese.value());
					log(__lua__('serpent.block')(e));
					log(__lua__('serpent.block')(data));
				});
			// }
			if (TheNet.GetIsServer()) {
				bleuCheese.set(false);
			}
			// log("bleuCheese is "+ bleuCheese.value());



			if (TheNet.GetIsServer()) {
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