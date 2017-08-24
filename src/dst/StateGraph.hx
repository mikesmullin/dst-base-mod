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
 */
@:native("_G")
extern class StateGraphExterns // Externs
{
	public var SGManager: SGManagerClass;
}

/**
 * StateGraphs are mainly used for controlling animation and timing.
 *
 * We can look at “SGeyeplant”, the stategraph for the Eye Plants
 * that spawn with the Lure Plant, as an example. Its first state
 * is “spawn” which gets played right when the Eye Plant is created.
 * Notice that its “onenter” function plays some animations and
 * plays a sound. It also listens for an “animover” event which
 * gets triggered when the current animation finishes playing,
 * which moves it to the “idle” state. All the idle state does
 * is play the idle animation. Normally that kind of behaviour,
 * “do this thing and when it’s done do that thing” is kind of a
 * drudgery to code up, but the stategraph makes it straightforward
 * to handle. We just tell it to go to the “spawn” state and when
 * it’s done it will automatically end up idling.
 *
 * Another interesting example is the “attack” state in SGtentacle.
 * The tentacles play sounds and deal damage during the “whipping”
 * part of their animation, which occur at certain frames. So this
 * state sets up a timeline which will do certain things at frames
 * 2, 7, 15, etc. Again, we can set this all up in the stategraph,
 * and then the combat component just says “go to your attack state!”
 * and the timing gets taken care of over here.
 */
@:native("_G.StateGraph")
extern class StateGraph extends ExplicitLuaClass
{
	/**
	 * @param name - Must match a Lua script in the data/scripts/stategraphs/ directory. (e.g. "SGbee")
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

/**
 * 
 */
@:native("_G.ActionHandler")
extern class ActionHandler extends ExplicitLuaClass
{
	@:selfCall
	public function new(action: Action, state: Either<StateName,DestinationStateCallback>, condition: ConditionCallback);

	public var action: Action;
	public var deststate: DestinationStateCallback;
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

	public var defline: String;
	public var name: StateName;
	public var onenter: Function;
	public var onexit: Function;
	public var onupdate: Function;
	public var ontimeout: Function;

	public var tags: lua.Table<Int,TagName>;
	public var events: lua.Table<Int,EventHandler>;
	public var timeline: lua.Table<Int,TimeEvent>;

	public function HandleEvent(sg: StateGraph, name: StateName,
		data: Dynamic): Bool;
}