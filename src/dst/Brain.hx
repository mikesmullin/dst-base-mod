package dst;

import haxe.Constraints.Function;
import dst.BehaviourTree.BehaviourNode;

/**
 * data/scripts/brain.lua
 */
@:native("_G")
extern class BrainExterns // Externs
{
	static public var BrainManager: BrainWrangler;
}

@:native("_G.BrainWrangler")
extern class BrainWrangler extends ExplicitLuaClass
{
	public var instances: {};
	public var updaters: {};
	public var tickwaiters: lua.Table<Int,Dynamic>;
	public var hibernaters: {};

	public function OnRemoveEntity(inst: EntityScript): Void;
	public function NameList(list: Dynamic): String;
	public function SendToList(inst: EntityScript, list: Dynamic): Void;
	public function Wake(inst: EntityScript): Void;
	public function Hibernate(inst: EntityScript): Void;
	public function Sleep(inst: EntityScript): Void;
	public function RemoveInstance(inst: EntityScript): Void;
	public function AddInstance(inst: EntityScript): Void;
	public function Update(current_tick: Float): Void;
}

/**
 * Brains are the least used element because they are the most
 * complicated and most entities generally don’t need this level
 * of complexity. Their purpose is for AI and decision-making so
 * only the complicated creatures need them.
 * 
 * Brains use a system called a BehaviourTree to make decisions.
 * Every now and then it goes to the first item in the tree and
 * checks, “can I do this?” and if not, it goes to the next one,
 * and then next one, and it’s children, and their children,
 * until it finds something it can do. Then it does that!
 * 
 * So this means things higher in the list have more priority,
 * which lets you do things like make pigs prefer fighting to eating,
 * but to panic when they are on fire even if they were fighting.
 * 
 * Brains heavily rely on BehaviourTrees and BehaviourNodes.
 * 
 * To see how Brain implementations work, study the LureplantBrain.
 * To see how BehaviourTrees work, study the PigBrain.
 */
@:native("_G.Brain")
extern class Brain extends ExplicitLuaClass
{
	public var inst: EntityScript;
	public var currentbehaviour: BehaviourNode;
	public var behaviourqueue: lua.Table<Int,BehaviourNode>;
	public var events: {};
	public var thinkperiod: Float;
	public var lastthinktime: Float;

	public function ForceUpdate(): Void;
	public function AddEventHandler(event: Dynamic, fn: Function): Void;
	public function GetSleepTime(): Float;
	public function Start(): Void;
	public function OnUpdate(): Void;
	public function Stop(): Void;
	public function PushEvent(event: String, data: lua.Table<Dynamic,Dynamic>): Void;
	
	/**
	 * Serialize this object to console-friendly string.
	 */
	override public function __tostring(): String;
}