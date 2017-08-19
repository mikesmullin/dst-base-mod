package dst.compiled;

import haxe.Constraints.Function;

@:native("_G.Entity")
extern class Entity
{
	/**
	 * Use MainFunctions.CreateEntity(), instead.
	 */
	private function new();

	public var entity: Entity; // self-reference
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




	public function AddAccountManager(): Dynamic;
	public function AddAnimState(): Dynamic;
	public function AddClientSleepable(): Dynamic;
	public function AddDebugRender(): Dynamic;
	public function AddDynamicShadow(): Dynamic;
	public function AddEnvelopeManager(): Dynamic;
	public function AddFollower(): Dynamic;
	public function AddFontManager(): Dynamic;
	public function AddGraphicsOptions(): Dynamic;
	public function AddGroundCreep(): Dynamic;
	public function AddGroundCreepEntity(): Dynamic;
	public function AddImage(): Dynamic;
	public function AddImageWidget(): Dynamic;
	public function AddLabel(): Dynamic;
	public function AddLight(): Dynamic;
	public function AddLightWatcher(): Dynamic;
	public function AddMap(): Dynamic;
	public function AddMapExplorer(): Dynamic;
	public function AddMapGenSim(): Dynamic;
	public function AddMapLayerManager(): Dynamic;
	public function AddMiniMap(): Dynamic;
	public function AddMiniMapEntity(): Dynamic;
	public function AddNetwork(): Dynamic;
	public function AddParticleEmitter(): Dynamic;
	public function AddPathfinder(): Dynamic;
	public function AddPhysics(): Dynamic;
	public function AddPostProcessor(): Dynamic;
	public function AddRoadManager(): Dynamic;
	public function AddShadowManager(): Dynamic;
	public function AddShardClient(): Dynamic;
	public function AddShardNetwork(): Dynamic;
	public function AddSoundEmitter(): Dynamic;
	public function AddStaticShadow(): Dynamic;
	public function AddTag(): Dynamic;
	public function AddTextEditWidget(): Dynamic;
	public function AddTextWidget(): Dynamic;
	public function AddTransform(): Dynamic;
	public function AddTwitchOptions(): Dynamic;
	public function AddUITransform(): Dynamic;
	public function AddVFXEffect(): Dynamic;
	public function AddVideoWidget(): Dynamic;
	public function AddWaveComponent(): Dynamic;
	public function CallPrefabConstructionComplete(): Dynamic;
	public function CanPredictMovement(): Dynamic;
	public function EnableMovementPrediction(): Dynamic;
	public function FlattenMovementPrediction(): Dynamic;
	public function FlushLocalDirtyNetVars(): Dynamic;
	public function FrustumCheck(): Dynamic;
	public function GetDebugString(): Dynamic;
	public function GetGUID(): dst.types.GUID;
	public function GetName(): Dynamic;
	public function GetParent(): Dynamic;
	public function GetPrefabName(): Dynamic;
	public function HasTag(): Dynamic;
	public function Hide(): Dynamic;
	public function IsAwake(): Dynamic;
	public function IsValid(): Dynamic;
	public function IsVisible(): Dynamic;
	public function LocalToWorldSpace(): Dynamic;
	public function LocalToWorldSpaceIncParent(): Dynamic;
	public function MoveToBack(): Dynamic;
	public function MoveToFront(): Dynamic;
	public function RemoveTag(): Dynamic;
	public function Retire(): Dynamic;
	public function SetAABB(): Dynamic;
	public function SetCanSleep(): Dynamic;
	public function SetClickable(): Dynamic;
	public function SetInLimbo(): Dynamic;
	public function SetIsPredictingMovement(): Dynamic;
	public function SetName(): Dynamic;
	public function SetParent(): Dynamic;
	public function SetPrefabName(): Dynamic;
	public function SetPristine(): Dynamic;
	public function SetSelected(): Dynamic;
	public function Show(): Dynamic;
	public function WorldToLocalSpace(): Dynamic;
}