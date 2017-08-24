package dst;

import haxe.Constraints.Function;
import haxe.ds.Either;
import dst.Actions.Action;
import dst.types.TagName;
import dst.types.EventName;
import dst.types.StateName;
import dst.types.StateGraphInstanceName;

/**
 * data/scripts/stategraph.lua
 *
 * StateGraphs compose the rules of animation playback and timing for the Prefab
 * EntityScripts they're assigned to. By defining the only set of States which
 * are valid for the entity, and the conditions for transiting between them,
 * developers can ensure entities smoothly act out sequences as designed,
 * no matter how a frenzy of inputs may be occuring in the simulation.
 *
 * As with any Finite State Machine (FSM), the StateGraph guarantees
 * exactly one State is always active. It receives and processes requests
 * to change state.
 * 
 * Used by Prefabs, StateGraphs are the ONLY classes which trigger function
 * callbacks on specific animation frame numbers.
 * 
 * StateGraphs are defined by convention in data/scripts/stategraphs/SG*.lua
 * and are applied like `EntityScript:SetStateGraph("SGtentacle")`.
 *
 *     KLEI DEVELOPER POST ON FORUMS:
 *     "Aye, stategraphs are on my list of things to improve."
 *                                -- Ipsquiggle, June 10, 2013
 * 
 */
@:native("_G.StateGraph")
extern class StateGraph extends ExplicitLuaClass
{
	/**
	 * These hold the list of ActionHandlers, EventHandlers, and States.
	 * Don't initialize this class directly;
	 * use `EntityScript.SetStateGraph()` instead.
	 */
	@:selfCall
	public function new(name: StateGraphInstanceName, states: lua.Table<Int,State>,
		events:lua.Table<Int,EventHandler>, defaultstate: StateName,
		actionhandlers: lua.Table<Action,ActionHandler>);

	public var defline: String;

	public var name: StateGraphInstanceName;
	public var defaultstate: StateName;

	public var actionhandlers: lua.Table<Action,ActionHandler>;
	public var events: lua.Table<Int,EventHandler>;
	public var states: lua.Table<Int,State>;

	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

/**
 * This class is the one that gets assigned to EntityScript.sg.
 * It provides many methods for interacting with StateGraph data,
 * which located one level deeper under EntityScript.sg.sg
 * a.k.a. StateGraphInstance.sg.
 * 
 * Don't initialize this class directly;
 * use `EntityScript.SetStateGraph()` instead.
 */
@:native("_G.StateGraphInstance")
extern class StateGraphInstance extends ExplicitLuaClass
{
	@:selfCall
	public function new(stategraph: StateGraph, inst: EntityScript);

	public var sg: StateGraph;
	public var currentstate: StateName; // default: nil
	public var timeinstate: Int; // default: 0
	public var lastupdatetime: Int; // default: 0
	public var timelineindex: Null<Int>; // default: nil
	public var prevstate: StateName; // default: nil
	public var bufferedevents: lua.Table<Int,EventHandler>; // default: {}
	public var inst: EntityScript; // default: inst
	public var statemem: lua.Table<Int,Dynamic>; // default: {}
	public var mem: lua.Table<Int,Dynamic>; // default: {}
	public var statestarttime: Int; // default: 0	
	public var tags: lua.Table<Int,TagName>;

	public function GetTimeInState(): Float;
	public function PlayRandomAnim(anims: Dynamic, loop: Dynamic): Void;
	public function PushEvent(event: EventName, data: lua.Table<Dynamic,Dynamic>): Void;
	public function IsListeningForEvent(event: EventName): Bool;
	public function PreviewAction(bufferedAction: BufferedAction): Bool;
	public function StartAction(bufferedAction: BufferedAction): Bool;
	public function HandleEvents(): Void;
	public function ClearBufferedEvents(): Void;
	public function InNewState(): Bool;
	public function HasState(name: StateName): Bool;
	public function GoToState(name: StateName, params: Dynamic): Bool;
	public function AddStateTag(tag: TagName): Void;
	public function RemoveStateTag(tag: TagName): Void;
	public function HasStateTag(tag: TagName): Bool;
	public function SetTimeout(time: Float): Void;
	public function UpdateState(dt: Float): Void;
	public function Start(): Void;
	public function Stop(): Void;
	public function Update(): Void;

	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

/**
 * ActionHandlers are defined and attached to an EntityScript.
 * When an Action is received, the EntityScript is looking for a
 * destination State it should possibly transition to in response.
 *
 * The ActionHandler has no logic attached to it, except for an
 * optional `condition` function, which can be used to disable
 * the ActionHandler entirely.
 *
 * An Action is dispatched by calling
 * `EntityScript.PushBufferedAction(BufferedAction)` which in turn
 * calls `StateGraph.StartAction(BufferedAction)` which then
 * transitions the EntityScript StateGraphInstance to the
 * destination State defined by the ActionHandler.
 *
 * From there its up to the functions defined by the State
 * implementation to carry out the specific work necessary for the
 * entity to perform the action, and to eventually call
 * `EntityScript.PerformBufferedAction()` which calls
 * `BufferedAction:Do()` which calls `Action.fn(EntityScript)`
 * which does the remaining/generic work related to the Action.
 *
 * There is technically also a case where if no destination State
 * is defined by the ActionHandler then `PerformBufferedAction()`
 * is invoked immediately, but this is rarely used.
 *
 * In the end, the entity appears to react to the action. (e.g.,
 * the pigman begins chewing animation for a few seconds upon receiving
 * an edible item with ACTION.EAT, then stops as the effects of digestion
 * are applied to the pigman's own health, hunger, sanity stats.)
 */
@:native("_G.ActionHandler")
extern class ActionHandler extends ExplicitLuaClass
{
	@:selfCall
	public function new(action: Action, state: Either<StateName,DestinationStateCallback>, ?condition: ConditionCallback);

	public var action: Action;

	/**
	 * The State which, when activated, will perform the action.
	 * Meaning the State will call one of EntityScript:GetBufferedAction()
	 * or EntityScript:PerformBufferedAction(), which will eventually
	 * call BufferedAction:Do().
	 *
	 * Technically optional, but seems always provided.
	 */
	public var deststate: DestinationStateCallback;

	/**
	 * Conditionally disable the ActionHandler, meaning
	 * - destination State will not be activated,
	 * - BufferedAction:Do() will not be called.
	 * 
	 * Optional. Not used.
	 */
	public var condition: ConditionCallback;
}

typedef EventHandlerFunction = EntityScript -> Void;

/**
 * 
 */
@:native("_G.EventHandler")
extern class EventHandler extends ExplicitLuaClass
{
	/**
	 * EventHandlers are passed to new StateGraphs.
	 * They implement specific logic which components demand.
	 *
	 * @param name - Name of the event for use with PushEvent. (e.g., "locomote")
	 * @param fn - Callback function when event is triggered.
	 */
	@:selfCall
	public function new(name: EventName, fn: EventHandlerFunction);

	public var defline: String;
	public var name: EventName;
	public var fn: EventHandlerFunction;
}

@:native("_G.TimeEvent")
extern class TimeEvent extends ExplicitLuaClass
{
	@:selfCall
	public function new(time: Int, fn: Function);

	public var defline: String;
	public var time: Int;
	public var fn: Function;
}

/**
 * Instances of State are used by the StateGraph to define exactly what
 * being in that state means to its EntityScript.
 * 
 * State implementations allow you to define "onenter" and "onexit" functions,
 * TimeEvents which hold functions that execute as specific frame numbers are
 * reached during animation playback, ActionHandlers and EventHandlers which
 * execute always or only if the State is active, Tags which are applied to the
 * EntityScript only while the State is active, an "onupdate" function for
 * physics operations only while the State is active, and an "ontimeout" function
 * optionally triggered by StateGraphInstance.SetTimeout() if you want guarantee
 * something happens if the State has been active for a certain period of time.
 *
 * These functions are typically used to trigger sounds, begin playing animation,
 * and changing various properties belonging to the attached EntityScript (e.g.,
 * playing a whip sound at the apex of the tentacle attack animation, dealing out
 * health reductions, or applying the effects of consuming food at the end of a
 * chewing animation, etc.)
 *
 * These functions operate in complementary fashion to an EntityScript's Brain,
 * BehaviorTree, BehaviourNode, and Components; these depend on each other.
 *
 * The order of operations typically go something like this:
 * - onenter:EntityScript->Void function is invoked first,
 *     modifying EntityScript until it reflects the idea represented by this state,
 *     and triggering some inst.AnimState:PlayAnimation() playback. (e.g., "atk_loop")
 * - timeline:Array<TimeEvent> functions are invoked next,
 *     synchronizing temporal changes to the precise frame of animation.
 *     (e.g., playing a sound and decreasing target hp on whip contact frame)
 * - events:Array<EventHandler> functions listen for events like "animover" which
 *     represent the end of the animation, and typically decide how to cleanup
 *     and transition to another state (e.g., "idle", "attack_post")
 *
 * States are meant to be chained together, ultimately ending on the "idle" state.
 * Its common to see "*_pre", "*_loop", and "*_post" states which control how
 * animation playback compensates for lag/work time (e.g., picking grass animation
 * has a quick pre followed by what could be an indefinitely long looping animation
 * and you do see this take a very long time on high ping servers, followed by a quick
 * end animation).
 * 
 * While an entity can never be in more than one state at a time, States can
 * and ARE frequently interrupted without warning. (e.g., a pigman eating
 * now receives an ACTION.ATTACK, is on fire, and taking damage!) Therefore
 * all State classes must worry about how to effectively reset the
 * the EntityScript no matter which state it is transitioning from.
 *
 * RESEARCHER'S NOTE:
 * The inability to anticipate and validate every possible combination is likely
 * the biggest limitation of the engine's design; as the game is designed to
 * support a myriad of possibilities to explore, and indeed finding odd and unusual
 * combinations provides players with great joy. However, its also a common theme
 * throughout the bug fixes in release notes. This probably has an exponential
 * drag effect on the speed and confidence of introducing new content into the
 * game world. We think Haxe exhaustiveness checks and similar features can
 * probably help here.
 */
@:native("_G.State")
extern class State extends ExplicitLuaClass
{
	@:selfCall
	public function new(args: {
		name: StateName,
		?onenter: Function,
		?onexit: Function,
		?onupdate: Function,
		?ontimeout: Function
	});

	/**
	 * Probably generated for debugging.
	 */
	public var defline: String;

	/**
	 * A name that appears in debug strings.
	 */
	public var name: StateName;

	/**
	 * A list of tags to be applied to the EntityScript
	 * only while this State is active.
	 */
	public var tags: lua.Table<Int,TagName>;

	/**
	 * Triggered upon State inactive to active.
	 * Optional.
	 */
	public var onenter: Function;

	/**
	 * Triggered upon State active to inactive.
	 * Optional.
	 */
	public var onexit: Function;

	/**
	 * Triggered by main update.lua loop,
	 * only while this State is active.
	 * Optional.
	 */
	public var onupdate: Function;

	/**
	 * Triggered by StateGraphInstance:SetTimeout()
	 * Optional.
	 */
	public var ontimeout: Function;

	/**
	 * A list of EventHandlers
	 * only registered while this State is active.
	 * Optional.
	 */
	public var events: lua.Table<Int,EventHandler>;

	/**
	 * A list of TimeEvent handlers
	 * only registered while this State is active.
	 * Optional.
	 */
	public var timeline: lua.Table<Int,TimeEvent>;

	public function HandleEvent(sg: StateGraph, name: StateName,
		data: Dynamic): Bool;
}





@:native("_G")
extern class StateGraphExterns // Externs
{
	public var SGManager: SGManagerClass;
}

private extern class StateGraphWrangler2 extends ExplicitLuaClass
{
	public var instances: {};
	public var updaters: {};
	public var tickwaiters: {};
	public var hibernaters: {};
	public var haveEvents: {};

	public function SendToList(inst: EntityScript, list: Dynamic): Void;
}

private extern class SGManagerClass extends StateGraphWrangler2
{
	/**
	 * A way to listen for state changes from outside a StateGraph.
	 * Not used.
	 */
	public function OnEnterNewState(inst: EntityScript): Void;
}

@:native("_G.StateGraphWrangler")
extern class StateGraphWrangler extends StateGraphWrangler2
{
	@:selfCall
	public function new();

	public function OnSetTimeout(inst: EntityScript): Void;
	public function OnPushEvent(inst: EntityScript): Bool;
	public function Hibernate(inst: EntityScript): Void;
	public function Wake(inst: EntityScript): Void;
	public function Sleep(inst: EntityScript, time_to_wait: Int): Void;
	public function OnRemoveEntity(inst: EntityScript): Void;
	public function RemoveInstance(inst: EntityScript): Void;
	public function AddInstance(inst: EntityScript): Void;
	public function Update(current_tick: Int): Void;
}

typedef DestinationStateCallback = EntityScript -> BufferedAction -> StateName;
typedef ConditionCallback = EntityScript -> Bool;