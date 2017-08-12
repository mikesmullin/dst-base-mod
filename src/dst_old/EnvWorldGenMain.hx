package dst;

import haxe.Constraints.Function;
import haxe.extern.Rest;

@:native("env")
extern class EnvWorldGenMain
{
	// Miscellaneous
	// -- Runtime
	static public var TUNING : Dynamic;
	
	// -- Worldgen
	static public var GROUND : Dynamic;
	static public var LOCKS : Dynamic;
	static public var KEYS : Dynamic;
	static public var LEVELTYPE : Dynamic;
	
	// -- Utility
	static public var modname : String;
	static public var MODROOT : String;
	static public var CHARACTERLIST : Dynamic;
	static public function modimport (moduleName : String) : Void;
	static public function modassert (test: Bool, message : String) : Void;
	
	/**
	 * Will assert if the modder has EnableModDebugPrint turned on,
	 * otherwise just print a warning for normal users.
	 */
	static public function moderror (message : String, level : Int) : Void;
	
	
	// Events

	/**
	 * Appends a handler for your action (or an existing action!) to an
	 * existing stategraph.
	 */
	static public function AddStategraphActionHandler(stateGraphName : String, newActionHandler : Void -> Void) : Void;

	/**
	 * Use this to modify and mangle existing stategraphs, such as digging
	 * into existing states or appending new functionality to existing
	 * handlers.
	 */
	static public function AddStategraphPostInit(stateGraphName : String, initFn : Void -> Void) : Void;

	/**
	 * Lets you modify a brain after it's been initialized. The most useful
	 * part is probably adding or removing nodes from brain.bt, which is the
	 * brain's behaviour tree.
	 *
	 * Note that "brainname" is the name of the lua file in scripts/brains/.
	 */
	static public function AddBrainPostInit(brainName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to modify a component's properties or behavior
	 */
	static public function AddComponentPostInit(componentName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to modify a prefab by adding, removing, or editing its properties
	 * and components.
	 */
	static public function AddPrefabPostInit(prefabName : String, initFn : Void->Void) : Void;

	/**
	 * Use this to run a function after a class's constructor runs. The initFn
	 * should have the same signature as the class's constructor.
	 * Use this to run a function after a class's constructor runs, when that
	 * class is returned directly from the file. The initFn should have the
	 * same signature as the class's constructor.
	 */
	 static public function AddClassPostConstruct(pathToFile : String, postFn : Dynamic -> Void) : Void;

	/**
	 * Use this to run a function after a class's constructor runs, when that
	 * class is placed into the global table. The initFn should have the same
	 * signature as the class's constructor.
	 */
	 static public function AddGlobalClassPostConstruct(pathToFile : String, className : String, initFn : Void->Void) : Void;

	/**
	 * This returns the player charcter once the game has loaded. Use this to
	 * modify and player character on startup, or to play with the game state
	 * and world state.
	 */
	static public function AddSimPostInit(initFn : Void->Void) : Void;
	
	static public function AddGamePostInit(initFn : Void->Void) : Void;
	static public function AddLevelPreInit (levelId : Int, fn : Int->Void) : Void;
	static public function AddLevelPreInitAny (fn : Void->Void) : Void;
	static public function AddTaskSetPreInit (taskSetName : String, fn : String->Void) : Void;
	static public function AddTaskSetPreInitAny (fn : Void->Void) : Void;
	static public function AddTaskPreInit (taskName : String, fn : Function) : Void;
	static public function AddRoomPreInit (roomName : String, fn : Function) : Void;
	
	
	
	// Disorganized

	static public var postinitfns : IPostInitFns;

	static public function AddLocation (arg1 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function AddLevel (arg1 : Dynamic, arg2 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function AddTaskSet (arg1 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function AddTask (arg1 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function AddRoom (arg1 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function AddStartLocation (arg1 : Dynamic, extras : Rest<Dynamic>) : Void;

	@:deprecated
	static public function AddGameMode (gameMode: String, gameModeText : String) : Void;
	static public function GetModConfigData (optionName : String, get_local_config : Dynamic ) : Dynamic;
	static public var ReleaseID : String;
	static public var CurrentRelease : String;
	
}

private interface IPostInitFns implements Dynamic
{
	public var LevelPreInit : Map<Dynamic, Function>;
	public var LevelPreInitAny : Map<Dynamic, Function>;
	public var TaskSetPreInit : Map<Dynamic, Function>;
	public var TaskSetPreInitAny : Map<Dynamic, Function>;
	public var TaskPreInit : Map<Dynamic, Function>;
	public var RoomPreInit : Map<Dynamic, Function>;
	public var GamePostInit : Map<Dynamic, Function>;
	public var SimPostInit : Map<Dynamic, Function>;
}