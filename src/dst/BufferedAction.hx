package dst;

import dst.Actions.Action;
import dst.Recipes.Recipe;

/**
 * data/scripts/bufferedaction.lua
 *
 * Action instances make actions that are possible.
 * BufferedAction instances make actions that will happen.
 * BufferedActions are a little bit like Promises but
 * with extra contextual data about the action.
 */
@:native("_G.BufferedAction")
extern class BufferedAction extends ExplicitLuaClass
{
	@:selfCall
	public function new(doer: Dynamic, target: Dynamic, action: Dynamic,
		invobject: Dynamic, pos: Dynamic, recipe: Dynamic, 
		distance: Dynamic, forced: Dynamic, rotation: Dynamic);

	public var doer: EntityScript; // default: doer
	public var target: EntityScript; // default: target
	public var initialtargetowner: EntityScript; // default: target ~= nil and target.components.inventoryitem ~= nil and target.components.inventoryitem.owner or nil
	public var action: Action; // default: action
	public var invobject: EntityScript; // default: invobject
	public var doerownsobject: Bool; // default: doer ~= nil and invobject ~= nil and invobject.replica.inventoryitem ~= nil and invobject.replica.inventoryitem:IsHeldBy(doer)
	public var pos: Dynamic; // default: pos
	public var rotation: Dynamic; // default: rotation
	public var onsuccess: lua.Table<Int,OnSuccessOrOnFailFunction>; // default: {}
	public var onfail: lua.Table<Int,OnSuccessOrOnFailFunction>; // default: {}
	public var recipe: Recipe; // default: recipe
	public var options: Dynamic; // default: {}
	public var distance: Float; // default: distance or action.distance
	public var forced: Bool; // default: forced
	public var autoequipped: Bool; // default: nil --true if invobject should've been auto-equipped
	public var skin: String; // default: nil

	public function Do(): DoTuple;

	public function IsValid(): Bool;

	public function GetActionString(): String;

	public function AddFailAction(fn: OnSuccessOrOnFailFunction): Void;
	public function AddSuccessAction(fn: OnSuccessOrOnFailFunction): Void;
	public function Succeed(): Void;
	public function Fail(): Void;
	
	/**
	 * Serialize this object to console-friendly string.
	 */
	override public function __tostring(): String;
}

private typedef OnSuccessOrOnFailFunction = Void -> Void;

@:multiReturn
private extern class DoTuple {
	var success: Bool;
	var reason: String;
}
