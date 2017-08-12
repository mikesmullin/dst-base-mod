package dst;

import haxe.Constraints.Function;
import haxe.io.Bytes;

typedef GUID = String;
typedef Hash = Int;

@:enum
abstract BRANCH(String)
{
	var dev = "dev";
	var staging = "staging";
	var release = "release";
}

@:enum
abstract PLATFORM(String)
{
	var PS4 = "PS4";
	var WIN32_STEAM = "WIN32_STEAM";
	var OSX_STEAM = "OSX_STEAM";
	var LINUX_STEAM = "LINUX_STEAM";
	var ANDROID = "ANDROID";
	var NACL = "NACL";
}

@:enum
abstract APP_REGION(String)
{
	var NONE = "NONE";
	var SCEJ = "SCEJ";
}

@:enum
abstract CONFIGURATION(String)
{
	var PRODUCTION = "PRODUCTION";
}

@:native("_G")
extern class CompiledEngine
{
	/**
	 * Build information.
	 */
	static public var APP_BUILD_DATE(default,never): String; // "2144"
	static public var APP_BUILD_TIME(default,never): String; // "11:01:52"
	static public var APP_REGION(default,never): APP_REGION; // "NONE"
	static public var APP_VERSION(default,never): String; // "226323"
	static public var BRANCH(default,never): BRANCH; // "release"
	static public var CONFIGURATION(default,never): CONFIGURATION; // "PRODUCTION"
	static public var PLATFORM(default,never): PLATFORM; // "WIN32_STEAM"

	/**
	 * Klei account username.
	 */
	static public var Account(default,never): String; // "UNKNOWN"

	/**
	 * Whether player may use the developer console.
	 */
	static public var CONSOLE_ENABLED: Bool; // true

	/**
	 * Runtime current working directory.
	 */
	static public var CWD(default,never): String; // "C:\Program Files (x86)\Steam\steamapps\common\Don't Starve Together Beta\data"

	/**
	 * May disable loading of all mods.
	 */
	static public var MODS_ENABLED: Bool; // true
	
	/**
	 * Path to mod directory.
	 * Used like MODS_ROOT + modname + "/modinfo.lua".
	 */
	static public var MODS_ROOT(default,never): String; // "../mods/"

	/**
	 * Only used in two places by gamelogic.lua which cooperates
	 * by printing relevant debug information pertaining to
	 * on-screen/in-memory runtime texture data.
	 */
	static public var PRINT_TEXTURE_INFO: Bool; // false

	/**
	 * One-time preload of global assets (ie. fonts, sounds).
	 */
	static public var RUN_GLOBAL_INIT: Bool; // true

	/**
	 * Global service singleton instances.
	 */
	static public var TheGameService(default,never): GameService;
	static public var TheInputProxy(default,never): InputProxy;
	static public var TheInventory(default,never): InventoryProxy;
	static public var TheItems(default,never): ItemServerProxy;
	static public var TheNet(default,never): NetworkProxy;
	static public var TheRawImgui(default,never): RawImgui;
	static public var TheShard(default,never): ShardProxy;
	static public var TheSim(default,never): Sim;
	static public var TheSystemService(default,never): SystemService;

	/**
	 * Alias for StackTrace(err)
	 */
	static public function _TRACEBACK(err:Dynamic): Dynamic;

	/**
	 * Launch browser.
	 */
	static public function VisitURL(url:String, ?notrack:Bool): Void;

	/**
	 * ∠a - ∠b normalized within 360°.
	 */
	static public function anglediff(a:Float, b:Float): Float;

	/**
	 * Unused.
	 * @returns a new table instance.
	 */
	@:deprecated
	static public function createTable(): Dynamic;

	/**
	 * Like a 32-bit CRC.
	 * @param {String} s - Input sequence.
	 * @return Presumably unique unsigned 32-bit integer.
	 */
	static public function hash(s:String): Hash;

	/**
	 * Like a 32-bit CRC.
	 * Name indicates it is more effective for input values
	 * which are smaller in byte size.
	 * @param {String} s - Input sequence.
	 * @return Presumably unique unsigned 32-bit integer.
	 */
	static public function smallhash(): Hash;

	/**
	 * Determine whether a file exists.
	 * Perhaps for security cases when
	 * io.open() and similar methods are sandboxed.
	 */
	static public function kleifileexists(filename:String): Bool;

	/**
	 * Load a lua module.
	 * Again perhaps for security cases when
	 * require() and similar methods are sandboxed.
	 */
	static public function kleiloadlua(filename:String): Function;

	/**
	 * 3D Perlin noise generator.
	 */
	static public function perlin(x:Float, y:Float, z:Float): Float;

	/**
	 * Exclusively used to copy Lua variable arguments (...)
	 * into an array data structure.
	 * Non-null variant.
	 */
	static public function toarray(args:Dynamic): Array<Dynamic>;

	/**
	 * Exclusively used to copy Lua variable arguments (...)
	 * into an array data structure,
	 * or a nil value.
	 */
	static public function toarrayornil(args:Dynamic): Null<Array<Dynamic>>;

	/**
	 * Like a normal Lua assert(), except
	 * @returns a function pointer instead of a string.
	 */
	static public function tracked_assert(v:Bool, ?message:String): Dynamic;

	/**
	 * UTF-8 string utility functions.
	 */
	static public function utf8strlen(): Dynamic;
	static public function utf8strtolower(): Dynamic;
	static public function utf8strtoupper(): Dynamic;
	static public function utf8substr(): Dynamic;

	/**
	 * Real-world elapsed time since program start in seconds
	 * with decimal.
	 * Only used by profiler;
	 * for microsecond resolution/accuracy.
	 */
	static public function walltime(): Float;

	/**
	 * Unused.
	 * @returns an integer that is always different and always higher than the last.
	 *   Probably a count of cleaned up objects.
	 */
	@:deprecated
	static public function gcinfo(): Int;

	/**
	 * Unused.
	 * @returns reference to a userdata object.
	 */
	@:deprecated
	static public function newproxy(): Dynamic;
}

@:native("_G.AccountManager")
extern class AccountManager
{
	public function AddGameKeyToAccount(): Dynamic;
	public function CancelLogin(): Dynamic;
	public function CommunicationSucceeded(): Dynamic;
	public function CreateAccount(): Dynamic;
	public function GetSteamLoginURL(): Dynamic;
	public function GetToken(): Dynamic;
	public function GetUsername(): Dynamic;
	public function GetViewAccountURL(): Dynamic;
	public function HasAuthToken(): Dynamic;
	public function HasSteamTicket(): Dynamic;
	public function IsBanned(): Dynamic;
	public function IsWaitingForResponse(): Dynamic;
	public function Login(): Dynamic;
	public function Logout(): Dynamic;
	public function MustUpgradeClient(): Dynamic;
	public function MustValidateEmail(): Dynamic;
	public function RecoverPassword(): Dynamic;
	public function TokenPurpose(): Dynamic;
	public function ValidateToken(): Dynamic;
}

@:native("_G.AnimState")
extern class AnimState
{
	public function AddOverrideBuild(): Dynamic;
	public function AnimDone(): Dynamic;
	public function AssignItemSkins(): Dynamic;
	public function BuildHasSymbol(): Dynamic;
	public function ClearAllOverrideSymbols(): Dynamic;
	public function ClearBloomEffectHandle(): Dynamic;
	public function ClearOverrideBuild(): Dynamic;
	public function ClearOverrideSymbol(): Dynamic;
	public function ClearSymbolExchanges(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetAddColour(): Dynamic;
	public function GetCurrentAnimationLength(): Dynamic;
	public function GetCurrentAnimationTime(): Dynamic;
	public function GetCurrentFacing(): Dynamic;
	public function GetMultColor(): Dynamic;
	public function GetSymbolPosition(): Dynamic;
	public function Hide(): Dynamic;
	public function HideSymbol(): Dynamic;
	public function IsCurrentAnimation(): Dynamic;
	public function OverrideItemSkinSymbol(): Dynamic;
	public function OverrideMultColor(): Dynamic;
	public function OverrideShade(): Dynamic;
	public function OverrideSymbol(): Dynamic;
	public function Pause(): Dynamic;
	public function PlayAnimation(): Dynamic;
	public function PushAnimation(): Dynamic;
	public function Resume(): Dynamic;
	public function SetAddColour(): Dynamic;
	public function SetBank(): Dynamic;
	public function SetBloomEffectHandle(): Dynamic;
	public function SetBuild(): Dynamic;
	public function SetClientSideBuildOverrideFlag(): Dynamic;
	public function SetClientsideBuildOverride(): Dynamic; // sic
	public function SetDeltaTimeMultipler(): Dynamic;
	public function SetDepthBias(): Dynamic;
	public function SetDepthTestEnabled(): Dynamic;
	public function SetErosionParams(): Dynamic;
	public function SetFinalOffset(): Dynamic;
	public function SetHaunted(): Dynamic;
	public function SetHighlightColour(): Dynamic;
	public function SetLayer(): Dynamic;
	public function SetLightOverride(): Dynamic;
	public function SetManualBB(): Dynamic;
	public function SetMultColour(): Dynamic;
	public function SetMultiSymbolExchange(): Dynamic;
	public function SetOrientation(): Dynamic;
	public function SetPercent(): Dynamic;
	public function SetRayTestOnBB(): Dynamic;
	public function SetScale(): Dynamic;
	public function SetSkin(): Dynamic;
	public function SetSortOrder(): Dynamic;
	public function SetSortWorldOffset(): Dynamic;
	public function SetSymbolExchange(): Dynamic;
	public function SetTime(): Dynamic;
	public function Show(): Dynamic;
	public function ShowSymbol(): Dynamic;
}

@:native("_G.ClientSleepable")
extern class ClientSleepable
{
}

@:native("_G.DebugRender")
extern class DebugRender
{
	public function Box(): Dynamic;
	public function Circle(): Dynamic;
	public function Flush(): Dynamic;
	public function Line(): Dynamic;
	public function Poly(): Dynamic;
	public function SetRenderLoop(): Dynamic;
	public function SetZ(): Dynamic;
	public function String(): Dynamic;
	public function Triangle(): Dynamic;
}

@:native("_G.DynamicShadow")
extern class DynamicShadow
{
	public function Enable(): Dynamic;
	public function SetSize(): Dynamic;
}

@:native("_G.Entity")
extern class Entity
{
	/**
	 * Use MainFunctions.CreateEntity(), instead.
	 */
	private function new();

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
	public function GetGUID(): GUID;
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

@:native("_G.Ents")
extern class Ents
{
}

@:native("_G.EnvelopeManager")
extern class EnvelopeManager
{
	public function AddColourEnvelope(): Dynamic;
	public function AddFloatEnvelope(): Dynamic;
	public function AddVector2Envelope(): Dynamic;
}

@:native("_G.Follower")
extern class Follower
{
	public function FollowSymbol(): Dynamic;
	public function SetOffset(): Dynamic;
}

@:native("_G.FontManager")
extern class FontManager
{
	public function RegisterFont(): Dynamic;
}

@:native("_G.GameService")
extern class GameService
{
	public function AwardAchievement(): Dynamic;
	public function RegisterAchievement(): Dynamic;
}

@:native("_G.GraphicsOptions")
extern class GraphicsOptions
{
	public function DisableLightMapComponent(): Dynamic;
	public function DisableStencil(): Dynamic;
	public function EnableLightMapComponent(): Dynamic;
	public function EnableStencil(): Dynamic;
	public function GetCurrentDisplayModeID(): Dynamic;
	public function GetDisplayMode(): Dynamic;
	public function GetDisplayName(): Dynamic;
	public function GetFullscreenDisplayID(): Dynamic;
	public function GetFullscreenDisplayRefreshRate(): Dynamic;
	public function GetNumDisplayModes(): Dynamic;
	public function GetNumDisplays(): Dynamic;
	public function GetNumRefreshRates(): Dynamic;
	public function GetRefreshRate(): Dynamic;
	public function IsBloomEnabled(): Dynamic;
	public function IsDistortionEnabled(): Dynamic;
	public function IsFullScreen(): Dynamic;
	public function IsFullScreenEnabled(): Dynamic;
	public function IsSmallTexturesMode(): Dynamic;
	public function SetBloomEnabled(): Dynamic;
	public function SetDisplayMode(): Dynamic;
	public function SetDistortionEnabled(): Dynamic;
	public function SetFullScreen(): Dynamic;
	public function SetSmallTexturesMode(): Dynamic;
	public function ToggleFullScreen(): Dynamic;
}

@:native("_G.GroundCreep")
extern class GroundCreep
{
	public function AddRenderLayer(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetAsString(): Dynamic;
	public function GetTriggeredCreepSpawners(): Dynamic;
	public function OnCreep(): Dynamic;
	public function SetFromString(): Dynamic;
	public function SetMaxRadius(): Dynamic;
	public function SetUpdateInterval(): Dynamic;
	public function TriggerCreepSpawners(): Dynamic;
}

@:native("_G.GroundCreepEntity")
extern class GroundCreepEntity
{
	public function SetRadius(): Dynamic;
}

@:native("_G.Image")
extern class Image
{
	public function Enable(): Dynamic;
	public function GetSize(): Dynamic;
	public function SetAlphaRange(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetEffect(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetTexture(): Dynamic;
	public function SetTextureHandle(): Dynamic;
	public function SetTint(): Dynamic;
	public function SetUIOffset(): Dynamic;
	public function SetWorldOffset(): Dynamic;
}

@:native("_G.ImageWidget")
extern class ImageWidget
{
	public function EnableEffectParams(): Dynamic;
	public function GetSize(): Dynamic;
	public function SetAlphaRange(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetEffect(): Dynamic;
	public function SetEffectParams(): Dynamic;
	public function SetHAnchor(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetTexture(): Dynamic;
	public function SetTextureHandle(): Dynamic;
	public function SetTint(): Dynamic;
	public function SetUVScale(): Dynamic;
	public function SetVAnchor(): Dynamic;
}

@:native("_G.InputProxy")
extern class InputProxy
{
	public function AddVibration(): Dynamic;
	public function ApplyControlMapping(): Dynamic;
	public function CancelMapping(): Dynamic;
	public function EnableInputDevice(): Dynamic;
	public function EnableVibration(): Dynamic;
	public function FlushInput(): Dynamic;
	public function GetInputDeviceCount(): Dynamic;
	public function GetInputDeviceName(): Dynamic;
	public function GetInputDeviceType(): Dynamic;
	public function GetLastActiveControllerIndex(): Dynamic;
	public function GetLocalizedControl(): Dynamic;
	public function GetOSCursorPos(): Dynamic;
	public function HasMappingChanged(): Dynamic;
	public function IsAnyControllerActive(): Dynamic;
	public function IsAnyControllerConnected(): Dynamic;
	public function IsAnyInputDeviceConnected(): Dynamic;
	public function IsInputDeviceConnected(): Dynamic;
	public function IsInputDeviceEnabled(): Dynamic;
	public function LoadControls(): Dynamic;
	public function LoadCurrentControlMapping(): Dynamic;
	public function LoadDefaultControlMapping(): Dynamic;
	public function MapControl(): Dynamic;
	public function RemoveVibration(): Dynamic;
	public function SaveControls(): Dynamic;
	public function SetCursorVisible(): Dynamic;
	public function SetOSCursorPos(): Dynamic;
	public function StartMappingControls(): Dynamic;
	public function StopMappingControls(): Dynamic;
	public function StopVibration(): Dynamic;
	public function UnMapControl(): Dynamic;
}

@:native("_G.InventoryProxy")
extern class InventoryProxy
{
	public function CheckClientOwnership(): Dynamic;
	public function CheckOwnership(): Dynamic;
	public function CheckOwnershipGetLatest(): Dynamic;
	public function GetClientGiftCount(): Dynamic;
	public function GetFullInventory(): Dynamic;
	public function GetUnopenedEntitlementItems(): Dynamic;
	public function GetUnopenedItems(): Dynamic;
	public function HasDownloadedInventory(): Dynamic;
	public function IsDownloadingInventory(): Dynamic;
	public function SetItemOpened(): Dynamic;
}

@:native("_G.ItemServerProxy")
extern class ItemServerProxy
{
	public function GetRecipes(): Dynamic;
	public function RedeemCode(): Dynamic;
	public function SwapItems(): Dynamic;
}

@:native("_G.Label")
extern class Label
{
	public function Enable(): Dynamic;
	public function SetColour(): Dynamic;
	public function SetFont(): Dynamic;
	public function SetFontSize(): Dynamic;
	public function SetText(): Dynamic;
	public function SetUIOffset(): Dynamic;
	public function SetWorldOffset(): Dynamic;
}

@:native("_G.Light")
extern class Light
{
	public function Enable(): Dynamic;
	public function EnableClientModulation(): Dynamic;
	public function GetCalculatedRadius(): Dynamic;
	public function GetColour(): Dynamic;
	public function GetDisableOnSceneRemoval(): Dynamic;
	public function GetFalloff(): Dynamic;
	public function GetIntensity(): Dynamic;
	public function GetRadius(): Dynamic;
	public function IsEnabled(): Dynamic;
	public function SetColour(): Dynamic;
	public function SetDisableOnSceneRemoval(): Dynamic;
	public function SetFalloff(): Dynamic;
	public function SetIntensity(): Dynamic;
	public function SetRadius(): Dynamic;
}

@:native("_G.LightWatcher")
extern class LightWatcher
{
	public function GetLightAngle(): Dynamic;
	public function GetLightValue(): Dynamic;
	public function GetTimeInDark(): Dynamic;
	public function GetTimeInLight(): Dynamic;
	public function IsInLight(): Dynamic;
	public function SetDarkThresh(): Dynamic;
	public function SetLightThresh(): Dynamic;
}

@:native("_G.Map")
extern class Map
{
	public function AddRenderLayer(): Dynamic;
	public function Fill(): Dynamic;
	public function Finalize(): Dynamic;
	public function GetEntitiesOnTileAtPoint(): Dynamic;
	public function GetIslandAtPoint(): Dynamic;
	public function GetNavStringEncode(): Dynamic;
	public function GetNumVisitedTiles(): Dynamic;
	public function GetNumWalkableTiles(): Dynamic;
	public function GetRandomPointsForSite(): Dynamic;
	public function GetSize(): Dynamic;
	public function GetStringEncode(): Dynamic;
	public function GetTile(): Dynamic;
	public function GetTileAtPoint(): Dynamic;
	public function GetTileCenterPoint(): Dynamic;
	public function GetTileCoordsAtPoint(): Dynamic;
	public function GetTileXYAtPoint(): Dynamic;
	public function RebuildLayer(): Dynamic;
	public function Replace(): Dynamic;
	public function ResetVisited(): Dynamic;
	public function SetFromString(): Dynamic;
	public function SetImpassableType(): Dynamic;
	public function SetNavFromString(): Dynamic;
	public function SetNavSize(): Dynamic;
	public function SetOverlayColor0(): Dynamic;
	public function SetOverlayColor1(): Dynamic;
	public function SetOverlayColor2(): Dynamic;
	public function SetOverlayLerp(): Dynamic;
	public function SetOverlayTexture(): Dynamic;
	public function SetPhysicsWallDistance(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetTile(): Dynamic;
	public function SetUndergroundRenderLayer(): Dynamic;
	public function TileVisited(): Dynamic;
	public function VisitTile(): Dynamic;
}

@:native("_G.MapExplorer")
extern class MapExplorer
{
	public function ActivateLocalMiniMap(): Dynamic;
	public function EnableUpdate(): Dynamic;
	public function LearnRecordedMap(): Dynamic;
	public function RecordMap(): Dynamic;
	public function RevealArea(): Dynamic;
}

@:native("_G.MapGenSim")
extern class MapGenSim
{
	public function CreateBox(): Dynamic;
	public function CreateCircle(): Dynamic;
	public function CreateConstraint(): Dynamic;
	public function CreateWorld(): Dynamic;
	public function DestroyWorld(): Dynamic;
	public function GetMinimumRadius(): Dynamic;
	public function GetNodePosition(): Dynamic;
	public function UpdateSim(): Dynamic;
}

@:native("_G.MapLayerManager")
extern class MapLayerManager
{
	public function CreateRenderLayer(): Dynamic;
	public function ReleaseRenderLayer(): Dynamic;
}

@:native("_G.MiniMap")
extern class MiniMap
{
	public function AddAtlas(): Dynamic;
	public function AddRenderLayer(): Dynamic;
	public function ClearRevealedAreas(): Dynamic;
	public function ContinuouslyClearRevealedAreas(): Dynamic;
	public function DrawForgottenFogOfWar(): Dynamic;
	public function EnableFogOfWar(): Dynamic;
	public function GetTextureHandle(): Dynamic;
	public function GetZoom(): Dynamic;
	public function IsVisible(): Dynamic;
	public function MapPosToWorldPos(): Dynamic;
	public function Offset(): Dynamic;
	public function RebuildLayer(): Dynamic;
	public function ResetOffset(): Dynamic;
	public function SetEffects(): Dynamic;
	public function ShowArea(): Dynamic;
	public function ToggleVisibility(): Dynamic;
	public function WorldPosToMapPos(): Dynamic;
	public function Zoom(): Dynamic;
}

@:native("_G.MiniMapEntity")
extern class MiniMapEntity
{
	public function CopyIcon(): Dynamic;
	public function SetCanUseCache(): Dynamic;
	public function SetDrawOverFogOfWar(): Dynamic;
	public function SetEnabled(): Dynamic;
	public function SetIcon(): Dynamic;
	public function SetIsFogRevealer(): Dynamic;
	public function SetIsProxy(): Dynamic;
	public function SetPriority(): Dynamic;
	public function SetRestriction(): Dynamic;
}

@:native("_G.Network")
extern class Network
{
	public function AddUserFlag(): Dynamic;
	public function GetClientName(): Dynamic;
	public function GetPlayerAge(): Dynamic;
	public function GetPlayerColour(): Dynamic;
	public function GetUserFlags(): Dynamic;
	public function GetUserID(): Dynamic;
	public function IsServerAdmin(): Dynamic;
	public function RemoveUserFlag(): Dynamic;
	public function SetClassifiedTarget(): Dynamic;
	public function SetPlayerAge(): Dynamic;
	public function SetPlayerEquip(): Dynamic;
	public function SetPlayerSkin(): Dynamic;
}

@:native("_G.NetworkProxy")
extern class NetworkProxy
{
	public function AddToWhiteList(): Dynamic;
	public function Announce(): Dynamic;
	public function AnnounceDeath(): Dynamic;
	public function AnnounceResurrect(): Dynamic;
	public function AnnounceVoteResult(): Dynamic;
	public function AutoJoinLanServer(): Dynamic;
	public function Ban(): Dynamic;
	public function BanForTime(): Dynamic;
	public function BeginServerModSetup(): Dynamic;
	public function BeginSession(): Dynamic;
	public function CallRPC(): Dynamic;
	public function CleanupSessionCache(): Dynamic;
	public function DeleteCluster(): Dynamic;
	public function DeleteSession(): Dynamic;
	public function DeleteUserSession(): Dynamic;
	public function DeserializeAllLocalUserSessions(): Dynamic;
	public function DeserializeUserSession(): Dynamic;
	public function DeserializeUserSessionInClusterSlot(): Dynamic;
	public function DiceRoll(): Dynamic;
	public function Disconnect(): Dynamic;
	public function DoneLoadingMap(): Dynamic;
	public function DownloadServerDetails(): Dynamic;
	public function DownloadServerMods(): Dynamic;
	public function EncodeUserPath(): Dynamic;
	public function GenerateClusterToken(): Dynamic;
	public function GetAllowIncomingConnections(): Dynamic;
	public function GetAutosaverEnabled(): Dynamic;
	public function GetAveragePing(): Dynamic;
	public function GetBlacklist(): Dynamic;
	public function GetChildProcessError(): Dynamic;
	public function GetChildProcessStatus(): Dynamic;
	public function GetClientMetricsForUser(): Dynamic;
	public function GetClientTable(): Dynamic;
	public function GetClientTableForUser(): Dynamic;
	public function GetCountryCode(): Dynamic;
	public function GetCurrentSnapshot(): Dynamic;
	public function GetDefaultClanAdmins(): Dynamic;
	public function GetDefaultClanID(): Dynamic;
	public function GetDefaultClanOnly(): Dynamic;
	public function GetDefaultEncodeUserPath(): Dynamic;
	public function GetDefaultEventSetting(): Dynamic;
	public function GetDefaultFriendsOnlyServer(): Dynamic;
	public function GetDefaultGameMode(): Dynamic;
	public function GetDefaultLANOnlyServer(): Dynamic;
	public function GetDefaultMaxPlayers(): Dynamic;
	public function GetDefaultPvpSetting(): Dynamic;
	public function GetDefaultServerDescription(): Dynamic;
	public function GetDefaultServerIntention(): Dynamic;
	public function GetDefaultServerName(): Dynamic;
	public function GetDefaultServerPassword(): Dynamic;
	public function GetDefaultVoteEnabled(): Dynamic;
	public function GetIsClient(): Dynamic;
	public function GetIsHosting(): Dynamic;
	public function GetIsMasterSimulation(): Dynamic;
	public function GetIsServer(): Dynamic;
	public function GetIsServerAdmin(): Dynamic;
	public function GetLanguageCode(): Dynamic;
	public function GetLocalUserName(): Dynamic;
	public function GetNetworkStatistics(): Dynamic;
	public function GetPVPEnabled(): Dynamic;
	public function GetPing(): Dynamic;
	public function GetPlayerCount(): Dynamic;
	public function GetPlayerSaveLocationInClusterSlot(): Dynamic;
	public function GetServerClanID(): Dynamic;
	public function GetServerClanOnly(): Dynamic;
	public function GetServerDescription(): Dynamic;
	public function GetServerEvent(): Dynamic;
	public function GetServerFriendsOnly(): Dynamic;
	public function GetServerGameMode(): Dynamic;
	public function GetServerHasPassword(): Dynamic;
	public function GetServerHasPresentAdmin(): Dynamic;
	public function GetServerIntention(): Dynamic;
	public function GetServerIsClientHosted(): Dynamic;
	public function GetServerIsDedicated(): Dynamic;
	public function GetServerLANOnly(): Dynamic;
	public function GetServerListing(): Dynamic;
	public function GetServerListingFromActualIndex(): Dynamic;
	public function GetServerListingReadDirty(): Dynamic;
	public function GetServerListings(): Dynamic;
	public function GetServerMaxPlayers(): Dynamic;
	public function GetServerModNames(): Dynamic;
	public function GetServerModsDescription(): Dynamic;
	public function GetServerModsEnabled(): Dynamic;
	public function GetServerName(): Dynamic;
	public function GetServerPVP(): Dynamic;
	public function GetSessionIdentifier(): Dynamic;
	public function GetUserID(): Dynamic;
	public function GetUserSessionFile(): Dynamic;
	public function GetUserSessionFileInClusterSlot(): Dynamic;
	public function GetWorldSessionFile(): Dynamic;
	public function GetWorldSessionFileInClusterSlot(): Dynamic;
	public function HasPendingConnection(): Dynamic;
	public function IncrementSnapshot(): Dynamic;
	public function IsClanIDValid(): Dynamic;
	public function IsDedicated(): Dynamic;
	public function IsDedicatedOfflineCluster(): Dynamic;
	public function IsNetIDPlatformValid(): Dynamic;
	public function IsNetOverlayEnabled(): Dynamic;
	public function IsOnlineMode(): Dynamic;
	public function IsSearchingServers(): Dynamic;
	public function IsVoiceActive(): Dynamic;
	public function IsWhiteListed(): Dynamic;
	public function JoinServerResponse(): Dynamic;
	public function Kick(): Dynamic;
	public function ListSnapshots(): Dynamic;
	public function ListSnapshotsInClusterSlot(): Dynamic;
	public function LoadPermissionLists(): Dynamic;
	public function NotifyAuthenticationFailure(): Dynamic;
	public function NotifyLoadingState(): Dynamic;
	public function OnPlayerHistoryUpdated(): Dynamic;
	public function PrintNetwork(): Dynamic;
	public function RemoveFromWhiteList(): Dynamic;
	public function ReportListing(): Dynamic;
	public function RequestServerAndStartClient(): Dynamic;
	public function Say(): Dynamic;
	public function SearchLANServers(): Dynamic;
	public function SearchServers(): Dynamic;
	public function SendModRPCToServer(): Dynamic;
	public function SendRPCToServer(): Dynamic;
	public function SendRemoteExecute(): Dynamic;
	public function SendResumeRequestToServer(): Dynamic;
	public function SendSlashCmdToServer(): Dynamic;
	public function SendSpawnRequestToServer(): Dynamic;
	public function SendWorldResetRequestToServer(): Dynamic;
	public function SendWorldRollbackRequestToServer(): Dynamic;
	public function SendWorldSaveRequestToMaster(): Dynamic;
	public function SerializeUserSession(): Dynamic;
	public function SerializeWorldSession(): Dynamic;
	public function ServerModCollectionSetup(): Dynamic;
	public function ServerModSetup(): Dynamic;
	public function ServerModsDownloadCompleted(): Dynamic;
	public function SetAllowIncomingConnections(): Dynamic;
	public function SetBlacklist(): Dynamic;
	public function SetCheckVersionOnQuery(): Dynamic;
	public function SetClientCacheSessionIdentifier(): Dynamic;
	public function SetCurrentSnapshot(): Dynamic;
	public function SetDefaultClanInfo(): Dynamic;
	public function SetDefaultEventSetting(): Dynamic;
	public function SetDefaultFriendsOnlyServer(): Dynamic;
	public function SetDefaultGameMode(): Dynamic;
	public function SetDefaultLANOnlyServer(): Dynamic;
	public function SetDefaultMaxPlayers(): Dynamic;
	public function SetDefaultPvpSetting(): Dynamic;
	public function SetDefaultServerDescription(): Dynamic;
	public function SetDefaultServerIntention(): Dynamic;
	public function SetDefaultServerName(): Dynamic;
	public function SetDefaultServerPassword(): Dynamic;
	public function SetGameData(): Dynamic;
	public function SetIsClientInWorld(): Dynamic;
	public function SetIsWorldResetting(): Dynamic;
	public function SetIsWorldSaving(): Dynamic;
	public function SetPlayerMuted(): Dynamic;
	public function SetSeason(): Dynamic;
	public function SetServerTags(): Dynamic;
	public function SetWorldGenData(): Dynamic;
	public function StartClient(): Dynamic;
	public function StartServer(): Dynamic;
	public function StartVote(): Dynamic;
	public function StopSearchingServers(): Dynamic;
	public function StopVote(): Dynamic;
	public function SystemMessage(): Dynamic;
	public function Talker(): Dynamic;
	public function TruncateSnapshots(): Dynamic;
	public function TruncateSnapshotsInClusterSlot(): Dynamic;
	public function TryDefaultEncodeUserPath(): Dynamic;
	public function ViewNetFriends(): Dynamic;
	public function ViewNetProfile(): Dynamic;
	public function Vote(): Dynamic;
}

@:native("_G.ParticleEmitter")
extern class ParticleEmitter
{
	public function AddParticle(): Dynamic;
	public function AddParticleUV(): Dynamic;
	public function AddRotatingParticle(): Dynamic;
	public function AddRotatingParticleUV(): Dynamic;
	public function ClearAllParticles(): Dynamic;
	public function EnableBloomPass(): Dynamic;
	public function EnableDepthTest(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetNumLiveParticles(): Dynamic;
	public function SetAcceleration(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetColourEnvelope(): Dynamic;
	public function SetDragCoefficient(): Dynamic;
	public function SetLayer(): Dynamic;
	public function SetMaxLifetime(): Dynamic;
	public function SetMaxNumParticles(): Dynamic;
	public function SetRadius(): Dynamic;
	public function SetRenderResources(): Dynamic;
	public function SetRotationStatus(): Dynamic;
	public function SetScaleEnvelope(): Dynamic;
	public function SetSortOrder(): Dynamic;
	public function SetSpawnVectors(): Dynamic;
	public function SetUVFrameSize(): Dynamic;
}

@:native("_G.PathFinder")
extern class PathFinder
{
	public function AddWall(): Dynamic;
	public function GetPathTileIndexFromPoint(): Dynamic;
	public function GetSearchResult(): Dynamic;
	public function GetSearchStatus(): Dynamic;
	public function HasWall(): Dynamic;
	public function IsClear(): Dynamic;
	public function KillSearch(): Dynamic;
	public function RemoveWall(): Dynamic;
	public function SubmitSearch(): Dynamic;
}

@:native("_G.Physics")
extern class Physics
{
	public function CheckGridOffset(): Dynamic;
	public function ClearCollisionMask(): Dynamic;
	public function ClearMotorVelOverride(): Dynamic;
	public function CollidesWith(): Dynamic;
	public function GeoProbe(): Dynamic;
	public function GetCollisionGroup(): Dynamic;
	public function GetCollisionMask(): Dynamic;
	public function GetHeight(): Dynamic;
	public function GetMass(): Dynamic;
	public function GetMotorSpeed(): Dynamic;
	public function GetMotorVel(): Dynamic;
	public function GetRadius(): Dynamic;
	public function GetVelocity(): Dynamic;
	public function IsActive(): Dynamic;
	public function IsPassable(): Dynamic;
	public function SetActive(): Dynamic;
	public function SetCapsule(): Dynamic;
	public function SetCollides(): Dynamic;
	public function SetCollisionCallback(): Dynamic;
	public function SetCollisionGroup(): Dynamic;
	public function SetCollisionMask(): Dynamic;
	public function SetCylinder(): Dynamic;
	public function SetDamping(): Dynamic;
	public function SetDontRemoveOnSleep(): Dynamic;
	public function SetFriction(): Dynamic;
	public function SetMass(): Dynamic;
	public function SetMotorVel(): Dynamic;
	public function SetMotorVelOverride(): Dynamic;
	public function SetRestitution(): Dynamic;
	public function SetSphere(): Dynamic;
	public function SetVel(): Dynamic;
	public function Stop(): Dynamic;
	public function Teleport(): Dynamic;
}

@:native("_G.PostProcessor")
extern class PostProcessor
{
	public function SetColourCubeData(): Dynamic;
	public function SetColourCubeLerp(): Dynamic;
	public function SetColourModifier(): Dynamic;
	public function SetDistortionFactor(): Dynamic;
	public function SetDistortionRadii(): Dynamic;
	public function SetEffectTime(): Dynamic;
}

@:native("_G.RawImgui")
extern class RawImgui
{
	public function IsImguiEnabled(): Dynamic;
}

@:native("_G.RoadManager")
extern class RoadManager {
	public function AddControlPoint(): Dynamic;
	public function AddSmoothedControlPoint(): Dynamic;
	public function BeginRoad(): Dynamic;
	public function GenerateQuadTree(): Dynamic;
	public function GenerateVB(): Dynamic;
	public function IsOnRoad(): Dynamic;
	public function SetStripEffect(): Dynamic;
	public function SetStripTextures(): Dynamic;
	public function SetStripUVAnimStep(): Dynamic;
	public function SetStripWrapMode(): Dynamic;
}

@:native("_G.ShadowManager")
extern class ShadowManager {
	public function GenerateStaticShadows(): Dynamic;
	public function SetTexture(): Dynamic;
}

@:native("_G.ShardClient")
extern class ShardClient {

}

@:native("_G.ShardNetwork")
extern class ShardNetwork {

}

@:native("_G.ShardProxy")
extern class ShardProxy {
	public function GetDefaultShardEnabled(): Dynamic;
	public function GetShardId(): Dynamic;
	public function GetSlavePlayerCounts(): Dynamic;
	public function IsMaster(): Dynamic;
	public function IsMigrating(): Dynamic;
	public function IsPlayer(): Dynamic;
	public function IsSlave(): Dynamic;
	public function SetSlaveLoading(): Dynamic;
	public function StartMigration(): Dynamic;
}

@:native("_G.Sim")
extern class Sim {
	public function AdjustFontAdvance(): Dynamic;
	public function CanWriteConfigurationDirectory(): Dynamic;
	public function CheckPersistentStringExists(): Dynamic;
	public function CleanAllMods(): Dynamic;
	public function ClearAllDSP(): Dynamic;
	public function ClearDSP(): Dynamic;
	public function ClearFileSystemAliases(): Dynamic;
	public function ClearInput(): Dynamic;
	public function CreateEntity(): Dynamic;
	public function DebugPause(): Dynamic;
	public function DebugPushJsonMessage(): Dynamic;
	public function DebugStringScreen(): Dynamic;
	public function DumpMemInfo(): Dynamic;
	public function DumpMemoryStats(): Dynamic;
	public function ErasePersistentString(): Dynamic;
	public function FindEntities(): Dynamic;
	public function FindFirstEntityWithTag(): Dynamic;
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
	public function SpawnPrefab(): Dynamic;
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

@:native("_G.SoundEmitter")
extern class SoundEmitter {
	public function GetEntity(): Dynamic;
	public function KillAllSounds(): Dynamic;
	public function KillSound(): Dynamic;
	public function OverrideVolumeMultiplier(): Dynamic;
	public function PlaySound(): Dynamic;
	public function PlaySoundWithParams(): Dynamic;
	public function PlayingSound(): Dynamic;
	public function SetMute(): Dynamic;
	public function SetParameter(): Dynamic;
	public function SetVolume(): Dynamic;
}

@:native("_G.StaticShadow")
extern class StaticShadow {
	public function SetSize(): Dynamic;
}

@:native("_G.SystemService")
extern class SystemService {
	public function AdjustDisplaySafeArea(): Dynamic;
	public function ClearLastOperation(): Dynamic;
	public function DidBugReportSucceed(): Dynamic;
	public function EnableAutosave(): Dynamic;
	public function EnableStorage(): Dynamic;
	public function FileBugReport(): Dynamic;
	public function GetBugReportUserCode(): Dynamic;
	public function GetLastOperation(): Dynamic;
	public function GotoStorePageROG(): Dynamic;
	public function HasFocus(): Dynamic;
	public function IsAutosaveEnabled(): Dynamic;
	public function IsBugReportRunning(): Dynamic;
	public function IsDisplaySafeAreaAdjusted(): Dynamic;
	public function IsStorageAvailable(): Dynamic;
	public function IsStorageEnabled(): Dynamic;
	public function OverwriteStorage(): Dynamic;
	public function PrepareStorage(): Dynamic;
	public function RetryOperation(): Dynamic;
	public function SetStalling(): Dynamic;
	public function StartDedicatedServers(): Dynamic;
	public function StopDedicatedServers(): Dynamic;
}

@:native("_G.TextEditWidget")
extern class TextEditWidget {
	public function EnableScrollEditWindow(): Dynamic;
	public function GetString(): Dynamic;
	public function OnKeyDown(): Dynamic;
	public function OnKeyUp(): Dynamic;
	public function OnTextInput(): Dynamic;
	public function SetForceUpperCase(): Dynamic;
	public function SetPassword(): Dynamic;
	public function SetString(): Dynamic;
}

@:native("_G.TextWidget")
extern class TextWidget {
	public function EnableWhitespaceWrap(): Dynamic;
	public function EnableWordWrap(): Dynamic;
	public function GetRegionSize(): Dynamic;
	public function GetString(): Dynamic;
	public function HasOverflow(): Dynamic;
	public function SetColour(): Dynamic;
	public function SetEditCursorColour(): Dynamic;
	public function SetFont(): Dynamic;
	public function SetHAnchor(): Dynamic;
	public function SetHorizontalSqueeze(): Dynamic;
	public function SetRegionSize(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetString(): Dynamic;
	public function SetVAnchor(): Dynamic;
	public function ShowEditCursor(): Dynamic;
}

@:native("_G.Transform")
extern class Transform {
	public function GetFacing(): Dynamic;
	public function GetLocalPosition(): Dynamic;
	public function GetPredictionPosition(): Dynamic;
	public function GetRotation(): Dynamic;
	public function GetScale(): Dynamic;
	public function GetWorldPosition(): Dynamic;
	public function SetEightFaced(): Dynamic;
	public function SetFourFaced(): Dynamic;
	public function SetFromProxy(): Dynamic;
	public function SetNoFaced(): Dynamic;
	public function SetPosition(): Dynamic;
	public function SetRotation(): Dynamic;
	public function SetScale(): Dynamic;
	public function SetSixFaced(): Dynamic;
	public function SetTwoFaced(): Dynamic;
	public function UpdateTransform(): Dynamic;
}

@:native("_G.TwitchOptions")
extern class TwitchOptions {
	public function Forget(): Dynamic;
	public function GetBroadcastingEnabled(): Dynamic;
	public function GetChannelName(): Dynamic;
	public function GetChannelURL(): Dynamic;
	public function GetStreamingState(): Dynamic;
	public function GetStreamingStateString(): Dynamic;
	public function GetUserName(): Dynamic;
	public function GetVisibleChatEnabled(): Dynamic;
	public function IsInitialized(): Dynamic;
	public function IsPastInitializedState(): Dynamic;
	public function IsStreaming(): Dynamic;
	public function Login(): Dynamic;
	public function SaveSettings(): Dynamic;
	public function SetBroadcastingEnabled(): Dynamic;
	public function SetVisibleChatEnabled(): Dynamic;
	public function Start(): Dynamic;
	public function Stop(): Dynamic;
	public function SupportedByPlatform(): Dynamic;
	public function ToggleStreaming(): Dynamic;
}

@:native("_G.UITransform")
extern class UITransform {
	public function GetLocalPosition(): Dynamic;
	public function GetRotation(): Dynamic;
	public function GetScale(): Dynamic;
	public function GetWorldPosition(): Dynamic;
	public function SetHAnchor(): Dynamic;
	public function SetMaxPropUpscale(): Dynamic;
	public function SetPosition(): Dynamic;
	public function SetRotation(): Dynamic;
	public function SetScale(): Dynamic;
	public function SetScaleMode(): Dynamic;
	public function SetVAnchor(): Dynamic;
	public function UpdateTransform(): Dynamic;
}

@:native("_G.VFXEffect")
extern class VFXEffect {
	public function AddParticle(): Dynamic;
	public function AddParticleUV(): Dynamic;
	public function AddRotatingParticle(): Dynamic;
	public function AddRotatingParticleUV(): Dynamic;
	public function ClearAllParticles(): Dynamic;
	public function EnableBloomPass(): Dynamic;
	public function EnableDepthTest(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetNumLiveParticles(): Dynamic;
	public function InitEmitters(): Dynamic;
	public function SetAcceleration(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetColourEnvelope(): Dynamic;
	public function SetDragCoefficient(): Dynamic;
	public function SetFollowEmitter(): Dynamic;
	public function SetKillOnEntityDeath(): Dynamic;
	public function SetMaxLifetime(): Dynamic;
	public function SetMaxNumParticles(): Dynamic;
	public function SetRadius(): Dynamic;
	public function SetRenderResources(): Dynamic;
	public function SetRotationStatus(): Dynamic;
	public function SetScaleEnvelope(): Dynamic;
	public function SetSortOffset(): Dynamic;
	public function SetSortOrder(): Dynamic;
	public function SetSpawnVectors(): Dynamic;
	public function SetUVFrameSize(): Dynamic;
}

@:native("_G.VideoWidget")
extern class VideoWidget {
	public function GetSize(): Dynamic;
	public function IsDone(): Dynamic;
	public function Load(): Dynamic;
	public function Pause(): Dynamic;
	public function Play(): Dynamic;
	public function SetHAnchor(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetVAnchor(): Dynamic;
	public function Stop(): Dynamic;
}

@:native("_G.WaveComponent")
extern class WaveComponent {
	public function Init(): Dynamic;
	public function SetWaveEffect(): Dynamic;
	public function SetWaveParams(): Dynamic;
	public function SetWaveSize(): Dynamic;
	public function SetWaveTexture(): Dynamic;
}

@:native("_G.json")
extern class JSON
{
	static private var json_settings: String; // ""
	static private var _M: {}; // table
	static private var _NAME: String; // "json"
	static private var _PACKAGE: String; // ""
	static public function decode(): Dynamic;
	static public function encode(): Dynamic;
	@:native("null")
	static private function _null(): Dynamic; // prefixed for Haxe compat
	static private function object(): Dynamic;
}
	
/**
 * All network types extend this implementation.
 */
private extern class BaseType<T> {
	
	/**
	 * Instantiation; registers a new network type object.
	 * Used to transmit and/or receive change events with the server.

	 * @param guid - Globally Unique Identifier;
	 *   Provided by a call to an Entity:GetGUID() instance method.
	 * @param name - Fully qualified name of the package and variable.
	 *   Probably used for debug toString() dumps.
	 *   But may be tracked by a compiled state machine
	 *   and expected to be unique.
	 * @param dirtyEventCallback - Event fired
	 *   when client detects a change to this variable.
	 *   May be triggered by server-to-client or
	 *   a local-to-client modification.
	 */
	public function new(guid:GUID, name:String, ?dirtyEventCallbackName:String);

	/**
	 * Local and remote setter;
	 * transmit a change notification to server,
	 * and emit a change event locally.
	 */
	public function set(value:T):Void;

	/**
	 * Local-only setter;
	 * Do NOT notify server,
	 * but emit a change event locally.
	 */
	public function set_local(value:T):Void;

	/**
	 * Local-only getter;
	 * Return last known value.
	 */
	public function value():T;
}


/**
	* Collection of typed classes used only by the network
	* interface to transmit binary data.
	*/

@:native("_G.net_bool")
extern class NetBool extends BaseType<Bool> {}

@:native("_G.net_byte")
extern class NetByte extends BaseType<Int> {}

@:native("_G.net_bytearray")
extern class NetByteArray extends BaseType<Bytes> {}

@:native("_G.net_entity")
extern class NetEntity extends BaseType<Entity> {}

@:native("_G.net_float")
extern class NetFloat extends BaseType<Float> {}

@:native("_G.net_hash")
extern class NetHash extends BaseType<Hash> {}

@:native("_G.net_int")
extern class NetInt extends BaseType<Int> {}

@:native("_G.net_shortint")
extern class NetShortInt extends BaseType<Int> {}

@:native("_G.net_uint")
extern class NetUInt extends BaseType<Int> {}

@:native("_G.net_ushortint")
extern class NetUShortInt extends BaseType<Int> {}

@:native("_G.net_tinybyte")
extern class NetTinyByte extends BaseType<Int> {}

@:native("_G.net_smallbyte")
extern class NetSmallByte extends BaseType<Int> {}

@:native("_G.net_smallbytearray")
extern class NetSmallByteArray extends BaseType<Bytes> {}

@:native("_G.net_string")
extern class NetString extends BaseType<String> {}