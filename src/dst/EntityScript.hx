package dst;

import haxe.extern.Rest;
import haxe.Constraints.Function;
import dst.compiled.Entity;
import dst.types.GUID;
import dst.Prefabs.Prefab;
import dst.Actions.Action;

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
	private function new(entity: Entity);

	/**
	 * Compiled-side instance.
	 */
	public var entity: Entity;

	/**
	 * EntityScript hasMany Components.
	 */
	public var components: Array<{}>;
	public var StopUpdatingComponents: {};


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
	public function ValidateReplicaComponent(name: String, cmp: Component): Bool;
	public function ReplicateComponent(name: String): Void;
	public function UnreplicateEntity(name: String): Void;
	public function PrereplicateEntity(name: String): Void;
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
	public function SetBrain(brainfn: Dynamic): Void;

	public function SetStateGraph(name: String): Void;
	public function ClearStateGraph(): Void;

	public function AddListener(t: Dynamic, event: Dynamic, inst: Dynamic, fn: Dynamic): Void;

	public function ListenForEvent(event: String, fn: Function, ?emitter: EntityScript): Void;
	public function RemoveEventCallback(event: String, fn: Function, ?emitter: EntityScript): Void;
	public function RemoveAllEventCallbacks(): Void;
	public function PushEvent(event: Dynamic, data: Dynamic): Dynamic;

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
 * Components are ordinary Class types.
 *
 * Its unfortunate that they don't share a type,
 * so we're using this one.
 */
typedef Component = ExplicitLuaClass;

/**
 * Tags are used heavily to describe
 * traits shared by types.
 */
typedef Tag = String;