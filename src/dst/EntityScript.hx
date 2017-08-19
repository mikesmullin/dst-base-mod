package dst;

import haxe.Constraints.Function;
import dst.compiled.Entity;

@:native("_G.EntityScript")
extern class EntityScript
{
	/**
	 * Don't invoke this directly;
	 * Use MainFunctions.CreateEntity() instead.
	 */
	private function new(entity: Entity);

	/**
	 * Compiled-side instance.
	 */
	public var entity: Entity;

	/**
	 * EntityScript hasMany Components.
	 */
	public var components: Array<{}>;


	public var lower_components_shadow: Array<{}>;
	public var GUID: dst.types.GUID; // default provided by compiled engine
	public var spawntime: Int; // elapsed tick time (not wall time)
	public var persists: Bool; // default: true
	public var inlimbo: Bool; // default: false
	public var name: Null<String>; // default: nil

	public var data: {}; // default: nil
	public var listeners: Array<{}>; // default: nil
	public var updatecomponents: Array<{}>; // default: nil
	public var actioncomponents: Array<{}>; // default: {}
	public var inherentactions: Array<{}>; // default: nil
	public var inherentsceneaction: {}; // default: nil
	public var inherentscenealtaction: {}; // default: nil
	public var event_listeners: Array<{}>; // default: nil
	public var event_listening: {}; // default: nil
	public var worldstatewatching: {}; // default: nil
	public var pendingtasks: Array<{}>; // default: nil
	public var children: Array<{}>; // default: nil

	public var actionreplica: {}; // default: nil
	public var replica: {}; // default: Replica(self)

	// compiled functions
	// public function ListenForEvent(name: String, cb: Entity->Dynamic->Void, ?target: Dynamic): Void;
	public function ListenForEvent(name: String, cb: Function, ?target: Dynamic): Void;
}