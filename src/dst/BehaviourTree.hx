package dst;

import haxe.Constraints.Function;
import dst.Actions.Action;

/**
 * data/scripts/behaviourtree.lua
 */
@:native("_G")
@:enum
extern abstract BehaviourNodeState(String) {
	var SUCCESS;
	var FAILED;
	var READY;
	var RUNNING;
}

@:native("_G.BT")
extern class BehaviourTree extends ExplicitLuaClass
{
	@:selfCall
	public function new(inst: EntityScript, root: Dynamic);

	public function ForceUpdate(): Void;
	public function Update(): Void;
	public function Reset(): Void;
	public function Stop(): Void;
	public function GetSleepTime(): Int;
	
	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

@:native("_G.BehaviourNode")
extern class BehaviourNode extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String, children: lua.Table<Int,BehaviourNode>);

	public var name: String; // default: ""
	public var children: lua.Table<Int,BehaviourNode>;
	public var status: BehaviourNodeState; // default: READY
	public var lastresult: BehaviourNodeState; // default: READY
	public var parent: BehaviourNode; // default: nil

	public function DoToParents(fn: Function): Dynamic;
	public function GetTreeString(indent: String): String;
	public function DBString(): String;
	public function Sleep(t: Int): Void;
	public function GetSleepTime(): Int;
	public function GetTreeSleepTime(): Int;
	public function GetString(): String;

	public function Visit(): Void;
	public function SaveStatus(): Void;
	public function Step(): Void;
	public function Reset(): Void;
	public function Stop(): Void;
}

@:native("_G.DecoratorNode")
extern class DecoratorNode extends BehaviourNode
{
	@:selfCall
	public function new(name: String, child: BehaviourNode);
}

@:native("_G.ConditionNode")
extern class ConditionNode extends BehaviourNode
{
	@:selfCall
	public function new(fn: Function, name: String);

	public var fn: Function;
}

@:native("_G.ConditionWaitNode")
extern class ConditionWaitNode extends BehaviourNode
{
	@:selfCall
	public function new(fn: Function, name: String);

	public var fn: Function;
}

@:native("_G.ActionNode")
extern class ActionNode extends BehaviourNode
{
	@:selfCall
	public function new(action: Action, name: String);

	public var action: Action;
}

@:native("_G.WaitNode")
extern class WaitNode extends BehaviourNode
{
	@:selfCall
	public function new(time: Int);

	public var wait_time: Int;
}

@:native("_G.SequenceNode")
extern class SequenceNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);

	public var idx: Int; // default: 1
}

@:native("_G.SelectorNode")
extern class SelectorNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);

	public var idx: Int; // default: 1
}

@:native("_G.NotDecorator")
extern class NotDecorator extends DecoratorNode
{
	@:selfCall
	public function new(child: BehaviourNode);
}

@:native("_G.FailIfRunningDecorator")
extern class FailIfRunningDecorator extends DecoratorNode
{
	@:selfCall
	public function new(child: BehaviourNode);
}

@:native("_G.FailIfSuccessDecorator")
extern class FailIfSuccessDecorator extends DecoratorNode
{
	@:selfCall
	public function new(child: BehaviourNode);
}

@:native("_G.LoopNode")
extern class LoopNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, maxreps: Int);

	public var idx: Int; // default: 1
	public var maxreps: Int;
	public var rep: Int; // default: 0
}

@:native("_G.RandomNode")
extern class RandomNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);
}

@:native("_G.PriorityNode")
extern class PriorityNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, period: Int, noscatter: Bool);

	public var period: Int; // default: 1
	public var lasttime: Float;
}

@:native("_G.ParallelNode")
extern class ParallelNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, name: String);
}

@:native("_G.ParallelNodeAny")
extern class ParallelNodeAny extends ParallelNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);
	
	public var stoponanycomplete: Bool; // default: true
}

@:native("_G.EventNode")
extern class EventNode extends BehaviourNode
{
	@:selfCall
	public function new(inst: EntityScript, event: String, child: BehaviourNode, priority: Int);

	public var inst: EntityScript;
	public var event: String;
	public var priority: Int;

	public var eventfn: EntityScript -> Dynamic -> Void; // inst, data

	public function OnEvent(data: Dynamic): Void;
}

@:native("_G.WhileNode")
extern class WhileNode extends BehaviourNode
{
	@:selfCall
	public function new(name: String, node: BehaviourNode);
}

@:native("_G.IfNode")
extern class IfNode extends BehaviourNode
{
	@:selfCall
	public function new(name: String, node: BehaviourNode);
}

@:native("_G.LatchNode")
extern class LatchNode extends BehaviourNode
{
	@:selfCall
	public function new(inst: EntityScript, latchduration: Float, child: BehaviourNode);

	public var inst: EntityScript;
	public var latchduration: Float;
	public var currentlatchduration: Float; // default: 0
	public var lastlatchtime: Float;
}