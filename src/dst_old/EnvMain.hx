package dst;
import haxe.Constraints.Function;
import haxe.extern.Rest;

@:native("env")
extern class EnvMain
{
	/**
	 * @param	id
	 *  ID for your custom action!
	 *  Example: "MYACTION"
	 * @param	str
	 *  string for your custom action!
	 *  Example: "Perform My Action"
	 * @param	fn
	 *  fn for your custom action!
	 *  Example: function(act) --[[your action code]] end
	 */
	static public function AddAction(id : String, str : String, fn : Function) : Void;
	
	static public function AddComponentAction(actiontype : Dynamic, component : Dynamic, fn : Function) : Void;
	static public function AddMinimapAtlas(atlaspath : Dynamic) : Void;
	static public function AddStategraphActionHandler(stategraph : Dynamic, handler : Function) : Void;
	static public function AddStategraphState(stategraph : Dynamic, state : Dynamic) : Void;
	static public function AddStategraphEvent(stategraph : Dynamic, event : Dynamic) : Void;
	static public function AddStategraphPostInit(stategraph : Dynamic, fn : Function) : Void;
	static public function AddComponentPostInit(component : Dynamic, fn : Function) : Void;
	static public function AddPrefabPostInitAny(fn : Function) : Void;
	static public function AddPlayerPostInit(fn : Function) : Void;
	static public function AddPrefabPostInit(prefab : Dynamic, fn : Function) : Void;
	static public function AddBrainPostInit(brain : Dynamic, fn : Function) : Void;
	static public function AddIngredientValues(names : Dynamic, tags : Dynamic, cancook : Dynamic, candry : Dynamic) : Void;
	static public function AddCookerRecipe(cooker : Dynamic, recipe : Dynamic) : Void;
	static public function AddModCharacter(name : String, gender : Dynamic) : Void;
	static public function RemoveDefaultCharacter (name : String) : Void;
	static public function AddRecipe(arg1 : Dynamic, extras : Rest<Dynamic>) : Void;
	static public function Recipe(extras : Rest<Dynamic>) : Void;

	static public function LoadPOFile(path : String, lang : String) : Void;
	static public function RemapSoundEvent(name : String, new_name : String) : Void;
	static public function AddReplicableComponent(name : String) : Void;
	static public function AddModRPCHandler( namespace : String, name : String, fn : Function) : Void;
	static public function GetModRPCHandler( namespace : String, name : String ) : Void;
	static public function SendModRPCToServer( id_table : Dynamic, extras : Rest<Dynamic> ) : Void;
	static public function GetModRPC( namespace : String, name : String ) : Void;
	static public function SetModHUDFocus(focusid : Int, hasfocus : Bool) : Void;
	static public function AddUserCommand(command_name : String, data : Dynamic) : Void;
	static public function AddVoteCommand(command_name : String, init_options_fn : Function, process_result_fn : Function, vote_timeout : Int ) : Void;
	static public function ExcludeClothingSymbolForModCharacter(name : String, symbol : Dynamic) : Void;
	
	static public var Prefab : Dynamic;
	static public var Asset : Dynamic;
	static public var Ingredient : Dynamic;
	@:deprecated
	static public var MOD_RPC : Dynamic; // legacy, mods should use GetModRPC below

	static public var postinitfns : IPostInitFns;
	static public var postinitdata : IPostInitData;

	static public var cookerrecipes : Map<Dynamic, Dynamic>;
}

private interface IPostInitData implements Dynamic
{
	public var MinimapAtlases : Map<Dynamic, Dynamic>;
	public var StategraphActionHandler : Map<Dynamic, Dynamic>;
	public var StategraphState : Map<Dynamic, Dynamic>;
	public var StategraphEvent : Map<Dynamic, Dynamic>;
}

private interface IPostInitFns implements Dynamic
{
	public var StategraphPostInit : Map<Dynamic, Function>;
	public var ComponentPostInit : Map<Dynamic, Function>;
	public var PrefabPostInitAny : Map<Dynamic, Function>;
	public var PrefabPostInit : Map<Dynamic, Function>;
}