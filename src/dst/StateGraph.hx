package dst;

import haxe.Constraints.Function;
import dst.Actions.Action;
import dst.types.Tag;

/**
 * data/scripts/stategraph.lua
 */
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

@:native("_G.ActionHandler")
extern class ActionHandler extends ExplicitLuaClass
{
	@:selfCall
	public function new(action: Action, state: State, condition: Dynamic);

	public var action: Action;
	public var deststate: EntityScript -> State;
	public var condition: Dynamic;
}

@:native("_G.EventHandler")
extern class EventHandler extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String, fn: Function);

	public var defline: String;
	public var name: String;
	public var fn: Function;
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
		name: String,
		?onenter: Function,
		?onexit: Function,
		?onupdate: Function,
		?ontimeout: Function
	});

	public var defline: String;
	public var name: String;
	public var onenter: Function;
	public var onexit: Function;
	public var onupdate: Function;
	public var ontimeout: Function;

	public var tags: lua.Table<Int,Tag>;
	public var events: lua.Table<Int,EventHandler>;
	public var timeline: lua.Table<Int,TimeEvent>;

	public function HandleEvent(sg: StateGraph, name: String,
		data: Dynamic): Bool;
}

@:native("_G.StateGraph")
extern class StateGraph extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String, states: lua.Table<Int,State>,
		events:lua.Table<Int,EventHandler>, defaultstate: State,
		actionhandlers: lua.Table<Int,ActionHandler>);

	public var defline: String;
	public var name: String;
	public var defaultstate: State;

	public var actionhandlers: lua.Table<Int,ActionHandler>;
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
	public var currentstate: State; // default: nil
	public var timeinstate: Int; // default: 0
	public var lastupdatetime: Int; // default: 0
	public var timelineindex: Null<Int>; // default: nil
	public var prevstate: State; // default: nil
	public var bufferedevents: lua.Table<Int,EventHandler>; // default: {}
	public var inst: EntityScript; // default: inst
	public var statemem: lua.Table<Int,Dynamic>; // default: {}
	public var mem: lua.Table<Int,Dynamic>; // default: {}
	public var statestarttime: Int; // default: 0	
	public var tags: lua.Table<Int,Tag>;

	public function GetTimeInState(): Float;
	public function PlayRandomAnim(anims: Dynamic, loop: Dynamic): Void;
	public function PushEvent(event: string, data: Dynamic): Void;
	public function IsListeningForEvent(event: string): Bool;
	public function PreviewAction(bufferedAction: BufferedAction): Bool;
	public function StartAction(bufferedAction: BufferedAction): Bool;
	public function HandleEvents(): Void;
	public function ClearBufferedEvents(): Void;
	public function InNewState(): Bool;
	public function HasState(name: String): Bool;
	public function GoToState(name: String, params: Dynamic): Bool;
	public function AddStateTag(tag: Tag): Void;
	public function RemoveStateTag(tag: Tag): Void;
	public function HasStateTag(tag: Tag): Bool;
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