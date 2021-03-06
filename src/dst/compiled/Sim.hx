package dst.compiled;

import dst.types.TagName;

@:native("_G.Sim")
extern class Sim
{
	public function AdjustFontAdvance(): Dynamic;
	public function CanWriteConfigurationDirectory(): Dynamic;
	public function CheckPersistentStringExists(): Dynamic;
	public function CleanAllMods(): Dynamic;
	public function ClearAllDSP(): Dynamic;
	public function ClearDSP(): Dynamic;
	public function ClearFileSystemAliases(): Dynamic;
	public function ClearInput(): Dynamic;

	/**
	 * Creates an Entity instance on the compiled side.
	 * Do not call this directly; 
	 * instead use MainFunctions.CreateEntity().
	 */
	public function CreateEntity(): Entity;
	
	public function DebugPause(): Dynamic;
	public function DebugPushJsonMessage(): Dynamic;
	public function DebugStringScreen(): Dynamic;
	public function DumpMemInfo(): Dynamic;
	public function DumpMemoryStats(): Dynamic;
	public function ErasePersistentString(): Dynamic;

	/**
	 * Will only return top 30.
	 */
	public function FindEntities(x: Float, y: Float, z: Float,
		radius: Float, /* filterFn: IInst -> Bool, maxCount: Int, */
		?andTags: lua.Table<Int, TagName>,
		?notTags: lua.Table<Int, TagName>,
		?orTags: lua.Table<Int, TagName>): lua.Table<Int, EntityScript>;

	public function FindFirstEntityWithTag(name: TagName): EntityScript;

	public function ForceAbort(): Dynamic;
	public function GenerateNewWorld(): Dynamic;
	public function GetAnalogControl(): Dynamic;
	public function GetBuildDate(): Dynamic;
	public function GetClientModsDownloading(): Dynamic;
	public function GetClipboardData(): Dynamic;
	public function GetDebugPhysicsRenderEnabled(): Dynamic;
	public function GetDebugRenderEnabled(): Dynamic;
	public function GetDigitalControl(): Dynamic;
	public function GetEntitiesAtScreenPoint(): Dynamic;
	public function GetEntityAtScreenPoint(): Dynamic;
	public function GetFPS(): Dynamic;
	public function GetFileModificationTime(): Dynamic;
	public function GetGameID(): Dynamic;
	public function GetGroundViewDirection(): Dynamic;
	public function GetLightAtPoint(): Dynamic;
	public function GetMOTDImage(): Dynamic;
	public function GetModDirectoryNames(): Dynamic;
	public function GetMouseButtonState(): Dynamic;
	public function GetNumLaunches(): Dynamic;
	public function GetNumberOfEntities(): Dynamic;
	public function GetPersistentString(): Dynamic;
	public function GetPersistentStringInClusterSlot(): Dynamic;
	public function GetPosition(): Dynamic;
	public function GetRealTime(): Dynamic;
	public function GetScreenPos(): Dynamic;
	public function GetScreenSize(): Dynamic;
	public function GetServerModsDownloading(): Dynamic;
	public function GetSetting(): Dynamic;
	public function GetSoundVolume(): Dynamic;
	public function GetStashedPlayInstance(): Dynamic;
	public function GetSteamAppID(): Dynamic;
	public function GetSteamBetaBranchName(): Dynamic;
	public function GetSteamIDNumber(): Dynamic;
	public function GetSteamUserID(): Dynamic;
	public function GetStep(): Dynamic;
	public function GetTick(): Dynamic;
	public function GetTickTime(): Dynamic;
	public function GetTimeScale(): Dynamic;
	public function GetUserHasLicenseForApp(): Dynamic;
	public function GetUsersName(): Dynamic;
	public function GetWindowSize(): Dynamic;
	public function GetWorkshopVersion(): Dynamic;
	public function HasWindowFocus(): Dynamic;
	public function HideAnimOnEntitiesWithTag(): Dynamic;
	public function Hook(): Dynamic;
	public function IsBorrowed(): Dynamic;
	public function IsDLCEnabled(): Dynamic;
	public function IsDLCInstalled(): Dynamic;
	public function IsDebugPaused(): Dynamic;
	public function IsKeyDown(): Dynamic;
	public function IsLoggedOn(): Dynamic;
	public function IsNetbookMode(): Dynamic;
	public function IsPlaying(): Dynamic;
	public function LoadFont(): Dynamic;
	public function LoadPrefabs(): Dynamic;
	public function LoadUserFile(): Dynamic;
	public function LockModDir(): Dynamic;
	public function LogBulkMetric(): Dynamic;
	public function LuaPrint(): Dynamic;
	public function LuaPrintRemote(): Dynamic;
	public function MemTrackerPop(): Dynamic;
	public function MemTrackerPush(): Dynamic;
	public function OnAssetPathResolve(): Dynamic;
	public function PreloadFile(): Dynamic;
	public function PrintTextureInfo(): Dynamic;
	public function Profile(): Dynamic;
	public function ProfilerPop(): Dynamic;
	public function ProfilerPush(): Dynamic;
	public function ProjectScreenPos(): Dynamic;
	public function QueryServer(): Dynamic;
	public function QueryStats(): Dynamic;
	public function QueueDownloadTempMod(): Dynamic;
	public function Quit(): Dynamic;
	public function RegisterPrefab(): Dynamic;
	public function RemapSoundEvent(): Dynamic;
	public function RenderOneFrame(): Dynamic;
	public function ReportAction(): Dynamic;
	public function RequestPlayerID(): Dynamic;
	public function Reset(): Dynamic;
	public function SendGameStat(): Dynamic;
	public function SendHardwareStats(): Dynamic;
	public function SendJSMessage(): Dynamic;
	public function SendProfileStats(): Dynamic;
	public function SendUITrigger(): Dynamic;
	public function SetActiveAreaCenterpoint(): Dynamic;
	public function SetAmbientColour(): Dynamic;
	public function SetCameraDir(): Dynamic;
	public function SetCameraFOV(): Dynamic;
	public function SetCameraPos(): Dynamic;
	public function SetCameraUp(): Dynamic;
	public function SetDLCEnabled(): Dynamic;
	public function SetDebugCameraRotation(): Dynamic;
	public function SetDebugCameraTarget(): Dynamic;
	public function SetDebugPhysicsRenderEnabled(): Dynamic;
	public function SetDebugRenderEnabled(): Dynamic;
	public function SetErosionTexture(): Dynamic;
	public function SetHighPassFilter(): Dynamic;
	public function SetInstanceParameters(): Dynamic;
	public function SetListener(): Dynamic;
	public function SetLowPassFilter(): Dynamic;
	public function SetMemInfoTrackingInterval(): Dynamic;
	public function SetMemoryTracking(): Dynamic;
	public function SetNetbookMode(): Dynamic;
	public function SetPersistentString(): Dynamic;
	public function SetPersistentStringInClusterSlot(): Dynamic;
	public function SetRenderPassDefaultEffect(): Dynamic;
	public function SetReverbPreset(): Dynamic;
	public function SetSetting(): Dynamic;
	public function SetSoundVolume(): Dynamic;
	public function SetTimeScale(): Dynamic;
	public function SetUIRoot(): Dynamic;
	public function SetVisualAmbientColour(): Dynamic;
	public function SetupFontFallbacks(): Dynamic;
	public function ShouldPlayIntroMovie(): Dynamic;
	public function ShouldWarnModsLoaded(): Dynamic;
	public function ShowAnimOnEntitiesWithTag(): Dynamic;

	/**
	 * Don't use this directly.
	 * Use MainFunctions.SpawnPrefab() instead.
	 */
	private function SpawnPrefab(name: String, skin: String, skin_id: String, creator: String): Dynamic;

	public function StartDownloadTempMods(): Dynamic;
	public function StartWorkshopQuery(): Dynamic;
	public function StashPlayInstance(): Dynamic;
	public function Step(): Dynamic;
	public function StopAllSounds(): Dynamic;
	public function SubscribeToMod(): Dynamic;
	public function ToggleDataProfiler(): Dynamic;
	public function ToggleDebugCamera(): Dynamic;
	public function ToggleDebugPause(): Dynamic;
	public function ToggleDebugTexture(): Dynamic;
	public function ToggleFrameProfiler(): Dynamic;
	public function TogglePerfGraph(): Dynamic;
	public function TryLockModDir(): Dynamic;
	public function TurnOffReverb(): Dynamic;
	public function UnloadAllPrefabs(): Dynamic;
	public function UnloadFont(): Dynamic;
	public function UnloadPrefabs(): Dynamic;
	public function UnlockModDir(): Dynamic;
	public function UnregisterAllPrefabs(): Dynamic;
	public function UnregisterPrefabs(): Dynamic;
	public function UpdateDebugTexture(): Dynamic;
	public function UpdateDeviceCaps(): Dynamic;
	public function UpdateWorkshopMod(): Dynamic;
	public function UserChooseDirectory(): Dynamic;
	public function ValidateHeap(): Dynamic;
	public function VerifyModVersions(): Dynamic;
	public function WorldPointInPoly(): Dynamic;
}