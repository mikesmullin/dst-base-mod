package dst;

import dst.Global.IInst;
import dst.Global.ITransform;
import dst.Types.IAllRecipes;
import haxe.Constraints.Function;
import haxe.extern.Rest;

@:native("GLOBAL")
extern class Global
{
	// Debug and utility helper functions
	static public var CHEATS_ENABLED : Bool; // = false;
	static public function require(file : String) : Dynamic;
	static public function debuglocals(level : Int) : String;
	static public function DumpEntity(entity : Entity) : Void;
	static public function SendRPCToServer(code : Dynamic, extras : Rest<Dynamic>) : Void;

	// Asset Definitions
	static public var AllRecipes : IAllRecipes;
	static public var ThePlayer : IThePlayer;
	static public var TheSim : ITheSim;
	static public var ACTIONS : IActions;
}

@:native("GLOBAL.RPC")
extern class RPC
{
	static public function LeftClick(player : Dynamic, action : Dynamic, x : Float, z : Float, target : Dynamic, isReleased : Bool, controlMods : Dynamic, noForce : Bool, modName : String) : Void;
	public function RightClick(player : Dynamic, action : Dynamic, x : Dynamic, z : Dynamic, target : Dynamic, rotation : Dynamic, isreleased : Dynamic, controlmods : Dynamic, noforce : Dynamic, mod_name : Dynamic) : Void;
	public function ActionButton(player : Dynamic, action : Dynamic, target : Dynamic, isreleased : Dynamic, noforce : Dynamic, mod_name : Dynamic) : Void;
	public function AttackButton(player : Dynamic, target : Dynamic, forceattack : Dynamic, noforce : Dynamic) : Void;
	public function InspectButton(player : Dynamic, target : Dynamic) : Void;
	public function ResurrectButton(player : Dynamic) : Void;
	public function ControllerActionButton(player : Dynamic, action : Dynamic, target : Dynamic, isreleased : Dynamic, noforce : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerActionButtonDeploy(player : Dynamic, invobject : Dynamic, x : Dynamic, z : Dynamic, rotation : Dynamic, isreleased : Dynamic) : Void;
	public function ControllerAltActionButton(player : Dynamic, action : Dynamic, target : Dynamic, isreleased : Dynamic, noforce : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerAltActionButtonPoint(player : Dynamic, action : Dynamic, x : Dynamic, z : Dynamic, isreleased : Dynamic, noforce : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerAttackButton(player : Dynamic, target : Dynamic, isreleased : Dynamic, noforce : Dynamic) : Void;
	public function StopControl(player : Dynamic, control : Dynamic) : Void;
	public function StopAllControls(player : Dynamic) : Void;
	public function DirectWalking(player : Dynamic, x : Dynamic, z : Dynamic) : Void;
	public function DragWalking(player : Dynamic, x : Dynamic, z : Dynamic) : Void;
	public function PredictWalking(player : Dynamic, x : Dynamic, z : Dynamic, isdirectwalking : Dynamic) : Void;
	public function StopWalking(player : Dynamic) : Void;
	public function DoWidgetButtonAction(player : Dynamic, action : Dynamic, target : Dynamic, mod_name : Dynamic) : Void;
	public function ReturnActiveItem(player : Dynamic) : Void;
	public function PutOneOfActiveItemInSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function PutAllOfActiveItemInSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function TakeActiveItemFromHalfOfSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function TakeActiveItemFromAllOfSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function AddOneOfActiveItemToSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function AddAllOfActiveItemToSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function SwapActiveItemWithSlot(player : Dynamic, slot : Dynamic, container : Dynamic) : Void;
	public function UseItemFromInvTile(player : Dynamic, action : Dynamic, item : Dynamic, controlmods : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerUseItemOnItemFromInvTile(player : Dynamic, action : Dynamic, item : Dynamic, active_item : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerUseItemOnSelfFromInvTile(player : Dynamic, action : Dynamic, item : Dynamic, mod_name : Dynamic) : Void;
	public function ControllerUseItemOnSceneFromInvTile(player : Dynamic, action : Dynamic, item : Dynamic, target : Dynamic, mod_name : Dynamic) : Void;
	public function InspectItemFromInvTile(player : Dynamic, item : Dynamic) : Void;
	public function DropItemFromInvTile(player : Dynamic, item : Dynamic, single : Dynamic) : Void;
	public function EquipActiveItem(player : Dynamic) : Void;
	public function EquipActionItem(player : Dynamic, item : Dynamic) : Void;
	public function SwapEquipWithActiveItem(player : Dynamic) : Void;
	public function TakeActiveItemFromEquipSlot(player : Dynamic, eslot : Dynamic) : Void;
	public function MoveInvItemFromAllOfSlot(player : Dynamic, slot : Dynamic, destcontainer : Dynamic) : Void;
	public function MoveInvItemFromHalfOfSlot(player : Dynamic, slot : Dynamic, destcontainer : Dynamic) : Void;
	public function MoveItemFromAllOfSlot(player : Dynamic, slot : Dynamic, srccontainer : Dynamic, destcontainer : Dynamic) : Void;
	public function MoveItemFromHalfOfSlot(player : Dynamic, slot : Dynamic, srccontainer : Dynamic, destcontainer : Dynamic) : Void;
	public function MakeRecipeFromMenu(player : Dynamic, recipe : Dynamic, skin_index : Dynamic) : Void;
	public function MakeRecipeAtPoint(player : Dynamic, recipe : Dynamic, x : Dynamic, z : Dynamic, rot : Dynamic, skin_index : Dynamic) : Void;
	public function BufferBuild(player : Dynamic, recipe : Dynamic) : Void;
	public function WakeUp(player : Dynamic) : Void;
	public function SetWriteableText(player : Dynamic, target : Dynamic, text : Dynamic) : Void;
	public function ToggleController(player : Dynamic, isattached : Dynamic) : Void;
	public function OpenGift(player : Dynamic) : Void;
	public function DoneOpenGift(player : Dynamic, usewardrobe : Dynamic) : Void;
	public function CloseWardrobe(player : Dynamic, base_skin : Dynamic, body_skin : Dynamic, hand_skin : Dynamic, legs_skin : Dynamic, feet_skin : Dynamic) : Void;
}

interface ITheSim
{
	/**
	 * NOTE: Will return top 30 matches only.
	 */
	public function FindEntities(x : Float, y : Float, z : Float, radius : Float, /* filterFn : IInst -> Bool, maxCount : Int, */ ? andTags : Array<String>, ? notTags : Array<String>, ? orTags : Array<String>) : lua.Table<Dynamic, Entity>;
}

interface IThePlayer extends Entity
{
	public var userid : Int;
	public var ismastersim : Bool;
	public var components : IThePlayerComponents;
}

interface IThePlayerComponents
{
	public var locomotor : ILocomotor;
}

interface ILocomotor
{
	public function PushAction(bufferedAction : Dynamic, run : Bool, ? tryInstant : Dynamic) : Void;
}

interface IInst
{
	public var prefab : String;
}

interface Entity extends IInst
{
	public var Transform : ITransform;
}

interface ITransform
{
	public function GetWorldPosition() : Position;
}

@:multiReturn
extern class Position
{
	var x : Int;
	var y : Int;
	var z : Int;
}

interface IActions
{
	public var PICKUP : Dynamic;
	public var PICK : Dynamic;
}

class Tags
{
	static public var INLIMBO = "INLIMBO";
	static public var EDIBLE_MEAT = "edible_MEAT";
}