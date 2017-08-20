package dst;

import haxe.Constraints.Function;

/**
 * data/scripts/behaviourtree.lua
 */
@:native("_G")
extern class BehaviourTreeExterns // Externs
{
	/**
	 * Waits for given node to finish or cond to return false,
	 * whichever happens first.
	 */
	public function WhileNode(cond: Void->Bool, name: String, node: BehaviourNode): ParallelNode;

	/**
	 * Proceeds to visit given node only if cond returns true.
	 */
	public function IfNode(cond: Void->Bool, name: String, node: BehaviourNode): SequenceNode;
}

/**
 * The four states of a BehaviourNode.
 */
@:native("_G")
@:enum
extern abstract BehaviourNodeState(String) {
	var SUCCESS;
	var FAILED;
	var READY;
	var RUNNING;
}

/**
 * The BehaviourTree has a root node, which acts as the “stem”
 * of the tree. Usually a PriorityNode is used for that.
 *
 * Every Brain has a BehaviourTree.
 */
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

/**
 * Generally, each BehaviourNode in a BehaviourTree boils down to sending
 * instructions to components: components still end up doing all the
 * real “work”. So the ChaseAndAttack behaviour, for example, sends
 * instructions to the Locomotor (for movement) and Combat (for attacking)
 * components, and those components handle the details.
 *
 * BehaviourNodes can have one of four states:
 * - "READY" means the brain will try (visit) that node when it can.
 * - "RUNNING" means the brain waits for the node to finish.
 * - "FAILED" means the brain carries on to the next node.
 * - "SUCCESS" means the brain stops there.
 *
 * A node can have a name and child nodes. It is possible for nodes to sleep
 * and interact with their parents or children. However, all of that is
 * optional, it depends on the kind of node whether it’s used.
 */
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

/**
 * This is a plain behaviour node that can have only one child,
 * nothing more than decoration.
 */
@:native("_G.DecoratorNode")
extern class DecoratorNode extends BehaviourNode
{
	@:selfCall
	public function new(name: String, child: BehaviourNode);
}

/**
 * This node runs “fn” when visited, and only if
 * the function returns true the node has success.
 * Otherwise, it fails.
 */
@:native("_G.ConditionNode")
extern class ConditionNode extends BehaviourNode
{
	@:selfCall
	public function new(fn: Void -> Bool, name: String);

	public var fn: Function;
}

/**
 * Like ConditionNode, but rather than failing,
 * it runs until the function returns true.
 */
@:native("_G.ConditionWaitNode")
extern class ConditionWaitNode extends BehaviourNode
{
	@:selfCall
	public function new(fn: Void -> Bool, name: String);

	public var fn: Function;
}

private typedef VoidFunction = Void->Void;

/**
 * This node is similiar to the ConditionNode,
 * except that after running the function “action”,
 * it will always be successful.
 *
 * Not related to Action or BufferedAction.
 */
@:native("_G.ActionNode")
extern class ActionNode extends BehaviourNode
{
	@:selfCall
	public function new(action: VoidFunction, name: String);

	public var action: VoidFunction;
}

/**
 * This node sleeps for “time” seconds whenever it gets visited,
 * and upon waking, it has success. It’s essentially a delay node.
 */
@:native("_G.WaitNode")
extern class WaitNode extends BehaviourNode
{
	@:selfCall
	public function new(time: Int);

	public var wait_time: Int;
}

/**
 * This node goes each child in order and visits them.
 * Only when the child is not running and not failed
 * will it proceed to visit the next child.
 * Only when all children are not running and not failed
 * will this node be success.
 * If any child is failed, this node is failed, and the
 * remaining children are not visited.
 */
@:native("_G.SequenceNode")
extern class SequenceNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);

	public var idx: Int; // default: 1
}

/**
 * This node is similiar to SequenceNode, but has success as soon as
 * a child node has success. Only if none of the children succeed,
 * this node fails.
 */
@:native("_G.SelectorNode")
extern class SelectorNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);

	public var idx: Int; // default: 1
}

/**
 * This node fails if the child succeeds and vica versa.
 * It’s the classic NOT logic gate.
 */
@:native("_G.NotDecorator")
extern class NotDecorator extends DecoratorNode
{
	@:selfCall
	public function new(child: BehaviourNode);
}

/**
 * This node is almost like the DecoratorNode,
 * except that if the child is running, the node fails.
 */
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

/**
 * This is a sequenceNode that doesn’t immediately succeed,
 * but only if its children succeed “maxreps” times.
 * This effectively means that the same sequence is run several times
 * rather than once.
 */
@:native("_G.LoopNode")
extern class LoopNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, maxreps: Int);

	public var idx: Int; // default: 1
	public var maxreps: Int;
	public var rep: Int; // default: 0
}

/**
 * This picks a random child,
 * and only if that child fails, it picks the next one.
 * Only if all children fail, the RandomNode fails.
 */
@:native("_G.RandomNode")
extern class RandomNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);
}

/**
 * This node has a period that must have passed before it does anything again.
 * When visited and the period has passed, it goes through the children in order.
 * If a child has success or is running, the node takes that state and
 * only resets the remain children.
 *
 * This is usually the root node of every behaviour tree.
 */
@:native("_G.PriorityNode")
extern class PriorityNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, period: Int, noscatter: Bool);

	public var period: Int; // default: 1
	public var lasttime: Float;
}

/**
 * This node visits all children at once in parallel,
 * and succeeds if all stopped running without failing.
 * If any child fails, it will stop checking the other children.
 */
@:native("_G.ParallelNode")
extern class ParallelNode extends BehaviourNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>, name: String);
}

/**
 * This is a ParallelNode that succeeds as long as
 * at least one child stops running without failing.
 */
@:native("_G.ParallelNodeAny")
extern class ParallelNodeAny extends ParallelNode
{
	@:selfCall
	public function new(children: lua.Table<Int,BehaviourNode>);
	
	public var stoponanycomplete: Bool; // default: true
}

/**
 * This node attaches an event listener for “event” to the instance “inst”.
 * If that event fires, the node triggers and wakes the parent priority node.
 * Upon getting visited, then the child gets visited.
 */
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