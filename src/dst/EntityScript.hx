package dst;

import haxe.extern.Rest;
import haxe.Constraints.Function;
import dst.compiled.Entity;
import dst.types.GUID;
import dst.Prefabs.Prefab;
import dst.Actions.Action;
import dst.types.Component;
import dst.types.Tag;
import dst.compiled.NetVars.NetByteArray;
import dst.compiled.NetVars.NetByte;
import dst.compiled.NetVars.NetSmallByteArray;
import dst.compiled.Light;

/**
 * data/scripts/entityscript.lua
 *
 * Represents all Entities.
 */
@:native("_G.EntityScript")
extern class EntityScript extends ExplicitLuaClass
{
	/**
	 * Don't invoke this directly;
	 * Use MainFunctions.CreateEntity() instead.
	 */
	@:selfCall
	private function new(entity: Entity);

	/**
	 * Compiled-side instance.
	 */
	public var entity: Entity;

	/**
	 * EntityScript hasMany Components.
	 */
	public var components: lua.Table<Int,Component>;
	public var StopUpdatingComponents: lua.Table<Component,Component>;
	public var lower_components_shadow: lua.Table<String,Bool>;
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

	/**
	 * Component Replicas
	 *
	 * Adding components to entities is straight-forward,
	 * for example:
	 *
	 * ```
	 * 	var e = CreateEntity();
	 * 	e.AddComponent("named");
	 * 	assert(e.components.named == require("components/named"));
	 * ```
	 *
	 * By default all components are designed to operate locally.
	 * For example, if the following line were evaluated only by
	 * the client, it would not change the value for the same
	 * component on the same entity on any other simulator on the
	 * network:
	 *
	 * ```
	 * 	e.components.named.SetName("SecretBilly");
	 * ```
	 *
	 * For every component that requires network synchronization,
	 * a components/*_replica.lua is created. The name is also
	 * registered via EntityReplica.AddReplicableComponent().
	 *
	 * While the original component and replica component may
	 * share the same interface, the replica's conventional role
	 * is to sync its data so all machines in the network receive
	 * the same values, using NetVars and RPC.

	 * For example, if the server evaluates the following code,
	 * all clients with a copy of the same entity will receive
	 * the same changes to their component values, as well:
	 *
	 * ```
	 * 	// component names listed in REPLICATABLE_COMPONENTS list
	 * 	// automatically have their replica components added to 
	 * 	// the entity during the AddComponent() step above.
	 * 	assert(e.replica.named == require("components/named_replica"));
	 * 	e.replica.named.SetName("EverybodyKnowsBilly");
	 * ```
	 *
	 * The named component is a real example, so read its source
	 * for more detailed examples.
	 */
	public var replica: Replica; // default: Replica(self)

	/**
	 * Action replicas map directly to NetVar instances.
	 */
	public var actionreplica: { // default: nil
		actioncomponents: NetByteArray,
		inherentactions: NetByteArray,
		inherentsceneaction: NetByte,
		inherentscenealtaction: NetByte,

		modactioncomponents: lua.Table<String, NetSmallByteArray>
	};

	/**
	 * Call `inst.entity.AddLight()` before invoking this property.
	 */
	public var Light: Light;

	public function GetSaveRecord(): SaveRecordTuple;

	public function Hide(): Void;
	public function Show(): Void;
	public function IsInLimbo(): Bool;
	public function Remove(): Dynamic;
	public function RemoveFromScene(): Void;
	public function ReturnToScene(): Void;

	public function AddInherentAction(act: Action): Void;
	public function RemoveInherentAction(act: Action): Void;

	public function GetTimeAlive(): Int;

	public function StartUpdatingComponent(cmp: Component): Void;
	public function StopUpdatingComponent(cmp: Component): Void;
	public function StopUpdatingComponent_Deferred(cmp: Component): Void;
	public function StartWallUpdatingComponent(cmp: Component): Void;
	public function StopWallUpdatingComponent(cmp: Component): Void;
	public function GetComponentName(cmp: Component): Void;

	public function AddTag(tag: Tag): Void;
	public function RemoveTag(tag: Tag): Void;
	public function HasTag(tag: Tag): Bool;

	// require("entityreplica")
	public function ValidateReplicaComponent(name: REPLICATABLE_COMPONENTS, cmp: Component): Bool;
	public function ReplicateComponent(name: REPLICATABLE_COMPONENTS): Void;
	public function UnreplicateEntity(name: REPLICATABLE_COMPONENTS): Void;
	public function PrereplicateEntity(name: REPLICATABLE_COMPONENTS): Void;
	public function ReplicateEntity(): Void;

	// require("componentactions")
	public function RegisterComponentActions(name: String): Void;
	public function UnregisterComponentActions(name: String): Void;
	public function CollectActions(actiontype: Dynamic, args: Rest<Dynamic>): Void;
	public function IsActionValid(action: Action, right: Bool): Bool;
	
	public function AddComponent(name: String): Void;
	public function RemoveComponent(name: String): Void;
	public function GetBasicDisplayName(): String;
	public function GetDisplayName(): String;
	public function GetIsWet(): Bool;
	public function GetSkinBuild(): String;
	public function GetSkinName(): String;
	public function SetPrefabName(name: String): Void;
	public function SetPrefabNameOverride(name: String): Void;

	public function SetDeployExtraSpacing(spacing: String): Void;
	public function SetTerraformExtraSpacing(spacing: String): Void;

	public function SpawnChild(name: String): Prefab;
	public function RemoveChild(child: Prefab): Void;
	public function AddChild(child: Prefab): Void;

	public function GetBrainString(): String;
	public function GetDebugString(): String;

	public function StartThread(fn: Dynamic): Void;

	public function RestartBrain(): Void;
	public function StopBrain(): Void;
	public function SetBrain(brainCls: Brain): Void;

	public function SetStateGraph(name: String): Void;
	public function ClearStateGraph(): Void;

	public function AddListener(t: Dynamic, event: Dynamic, inst: Dynamic, fn: Dynamic): Void;

	/**
	 * This function is used to listen for a set event and fire a function when it’s pushed.
	 * Optionally, a different entity can be set as a third parameter.
	 * Then that entity has to push the event, rather than the entity used to call
	 * ListenForEvent in the first place (notice that you could add the listener from the
	 * source entity straight away, but then removing the first entity won’t remove the
	 * event listener).
	 */
	public function ListenForEvent(event: String, fn: EventCallback, ?emitter: EntityScript): Void;


	/**
	 * This function removes an event listener. It requires both the event name and the function,
	 * and can also accept a different entity as the third parameter, if used in the original
	 * ListenForEvent.
	 */
	public function RemoveEventCallback(event: String, fn: EventCallback, ?emitter: EntityScript): Void;

	public function RemoveAllEventCallbacks(): Void;

	/**
	 * This function is used to push an event.
	 * Optionally, a table with arbitrary information can be added.
	 */
	public function PushEvent(event: String, data: lua.Table<Dynamic,Dynamic>): Void;

	public function WatchWorldState(_var: Dynamic, fn: Dynamic): Dynamic;
	public function StopWatchingWorldState(_var: Dynamic, fn: Dynamic): Dynamic;
	public function StopAllWatchingWorldStates(): Dynamic;

	public function GetPosition(): Dynamic;
	public function GetRotation(): Dynamic;
	public function GetAngleToPoint(x: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function GetPositionAdjacentTo(target: Dynamic, distance: Dynamic): Dynamic;
	public function ForceFacePoint(x: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function FacePoint(x: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function GetDistanceSqToInst(inst: Dynamic): Dynamic;
	public function IsNear(otherinst: Dynamic, dist: Dynamic): Dynamic;
	public function GetDistanceSqToPoint(x: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function IsNearPlayer(range: Dynamic, isalive: Dynamic): Dynamic;
	public function GetNearestPlayer(isalive: Dynamic): Dynamic;
	public function GetDistanceSqToClosestPlayer(isalive: Dynamic): Dynamic;
	public function FaceAwayFromPoint(dest: Dynamic, force: Dynamic): Dynamic;
	public function GetCurrentTileType(): Dynamic;
	public function PutBackOnGround(): Dynamic;
	public function GetPersistData(): Dynamic;
	public function LoadPostPass(newents: Dynamic, savedata: Dynamic): Dynamic;
	public function SetPersistData(data: Dynamic, newents: Dynamic): Dynamic;
	public function GetAdjective(): Dynamic;
	public function LongUpdate(dt: Dynamic): Dynamic;

	public function IsAsleep(): Dynamic;
	public function IsValid(): Dynamic;
	public function IsOnValidGround(): Dynamic;

	public function DoPeriodicTask(time: Dynamic, fn: Dynamic, initialdelay: Dynamic, args: Rest<Dynamic>): Dynamic;
	public function DoTaskInTime(time: Dynamic, fn: Dynamic, args: Rest<Dynamic>): Dynamic;
	public function CancelAllPendingTasks(): Dynamic;
	public function KillTasks(): Void;
	public function GetTaskInfo(time: Dynamic): Dynamic;
	public function TimeRemainingInTask(taskinfo: Dynamic): Dynamic;
	public function ResumeTask(time: Dynamic, fn: Dynamic, args: Rest<Dynamic>): Dynamic;

	public function ClearBufferedAction(): Dynamic;
	public function InterruptBufferedAction(): Dynamic;
	public function PreviewBufferedAction(bufferedaction: Dynamic): Dynamic;
	public function PerformPreviewBufferedAction(): Dynamic;
	public function PushBufferedAction(bufferedaction: Dynamic): Dynamic;
	public function PerformBufferedAction(): Dynamic;
	public function GetBufferedAction(): Dynamic;
	public function SetInherentSceneAction(action: Dynamic): Dynamic;
	public function SetInherentSceneAltAction(action: Dynamic): Dynamic;
	public function CanDoAction(action: Dynamic): Dynamic;
	public function OnUsedAsItem(action: Dynamic): Dynamic;
	public function CanInteractWith(inst: Dynamic): Dynamic;

	public function OnBuilt(builder: Dynamic): Dynamic;

	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

@:multiReturn
private extern class SaveRecordTuple {
	var record: {
		prefab: Prefab,
		id: GUID,
		?age: Int,
		?x: Float,
		?y: Float,
		?z: Float,
		?skinname: String,
		?skin_id: String,
		?alt_skin_ids: Array<String>,
		?data: Dynamic
	};
	var references: Dynamic;
}

/**
 * Replica components container with overridden accessor.
 */
private extern class Replica extends ExplicitLuaClass
{
	@:selfCall
	public function new (inst: EntityScript);

	public var inst: EntityScript;

	/**
	 * This holds all the override values.
	 */
	public var _: {};
}

/**
 * This is the default list.
 * Mods can add to it dynamically at runtime
 * by calling EntityReplica.AddReplicableComponent().
 */
@:enum
abstract REPLICATABLE_COMPONENTS(String)
{
	var builder = "builder";
	var combat = "combat";
	var container = "container";
	var equippable = "equippable";
	var fishingrod = "fishingrod";
	var follower = "follower";
	var health = "health";
	var hunger = "hunger";
	var inventory = "inventory";
	var inventoryitem = "inventoryitem";
	var moisture = "moisture";
	var named = "named";
	var rider = "rider";
	var sanity = "sanity";
	var sheltered = "sheltered";
	var stackable = "stackable";
	var writeable = "writeable";
}

typedef EventCallback = EntityScript -> ?lua.Table<Dynamic,Dynamic> -> Void;

/**
 * Usage:
 *   using dst.EntityScript.EventHelper;
 */
class EventHelper
{
	/**
	 * Makes it easy to listen for an event just once.
	 */
	static public function ListenForEventOnce(inst: EntityScript, event: String, fn: EventCallback, ?emitter: EntityScript): Void
	{
		function once(inst2: EntityScript, ?data: lua.Table<Dynamic,Dynamic>): Void {
			inst.RemoveEventCallback(event, once, emitter);
			return fn(inst2, data);
		}
			
		inst.ListenForEvent(event, once, emitter);
	}
}