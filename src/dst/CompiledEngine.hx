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
	static public function AddGameKeyToAccount(): Dynamic;
	static public function CancelLogin(): Dynamic;
	static public function CommunicationSucceeded(): Dynamic;
	static public function CreateAccount(): Dynamic;
	static public function GetSteamLoginURL(): Dynamic;
	static public function GetToken(): Dynamic;
	static public function GetUsername(): Dynamic;
	static public function GetViewAccountURL(): Dynamic;
	static public function HasAuthToken(): Dynamic;
	static public function HasSteamTicket(): Dynamic;
	static public function IsBanned(): Dynamic;
	static public function IsWaitingForResponse(): Dynamic;
	static public function Login(): Dynamic;
	static public function Logout(): Dynamic;
	static public function MustUpgradeClient(): Dynamic;
	static public function MustValidateEmail(): Dynamic;
	static public function RecoverPassword(): Dynamic;
	static public function TokenPurpose(): Dynamic;
	static public function ValidateToken(): Dynamic;
}

@:native("_G.AnimState")
extern class AnimState
{
	static public function AddOverrideBuild(): Dynamic;
	static public function AnimDone(): Dynamic;
	static public function AssignItemSkins(): Dynamic;
	static public function BuildHasSymbol(): Dynamic;
	static public function ClearAllOverrideSymbols(): Dynamic;
	static public function ClearBloomEffectHandle(): Dynamic;
	static public function ClearOverrideBuild(): Dynamic;
	static public function ClearOverrideSymbol(): Dynamic;
	static public function ClearSymbolExchanges(): Dynamic;
	static public function FastForward(): Dynamic;
	static public function GetAddColour(): Dynamic;
	static public function GetCurrentAnimationLength(): Dynamic;
	static public function GetCurrentAnimationTime(): Dynamic;
	static public function GetCurrentFacing(): Dynamic;
	static public function GetMultColor(): Dynamic;
	static public function GetSymbolPosition(): Dynamic;
	static public function Hide(): Dynamic;
	static public function HideSymbol(): Dynamic;
	static public function IsCurrentAnimation(): Dynamic;
	static public function OverrideItemSkinSymbol(): Dynamic;
	static public function OverrideMultColor(): Dynamic;
	static public function OverrideShade(): Dynamic;
	static public function OverrideSymbol(): Dynamic;
	static public function Pause(): Dynamic;
	static public function PlayAnimation(): Dynamic;
	static public function PushAnimation(): Dynamic;
	static public function Resume(): Dynamic;
	static public function SetAddColour(): Dynamic;
	static public function SetBank(): Dynamic;
	static public function SetBloomEffectHandle(): Dynamic;
	static public function SetBuild(): Dynamic;
	static public function SetClientSideBuildOverrideFlag(): Dynamic;
	static public function SetClientsideBuildOverride(): Dynamic; // sic
	static public function SetDeltaTimeMultipler(): Dynamic;
	static public function SetDepthBias(): Dynamic;
	static public function SetDepthTestEnabled(): Dynamic;
	static public function SetErosionParams(): Dynamic;
	static public function SetFinalOffset(): Dynamic;
	static public function SetHaunted(): Dynamic;
	static public function SetHighlightColour(): Dynamic;
	static public function SetLayer(): Dynamic;
	static public function SetLightOverride(): Dynamic;
	static public function SetManualBB(): Dynamic;
	static public function SetMultColour(): Dynamic;
	static public function SetMultiSymbolExchange(): Dynamic;
	static public function SetOrientation(): Dynamic;
	static public function SetPercent(): Dynamic;
	static public function SetRayTestOnBB(): Dynamic;
	static public function SetScale(): Dynamic;
	static public function SetSkin(): Dynamic;
	static public function SetSortOrder(): Dynamic;
	static public function SetSortWorldOffset(): Dynamic;
	static public function SetSymbolExchange(): Dynamic;
	static public function SetTime(): Dynamic;
	static public function Show(): Dynamic;
	static public function ShowSymbol(): Dynamic;
}

@:native("_G.ClientSleepable")
extern class ClientSleepable
{
}

@:native("_G.DebugRender")
extern class DebugRender
{
	static public function Box(): Dynamic;
	static public function Circle(): Dynamic;
	static public function Flush(): Dynamic;
	static public function Line(): Dynamic;
	static public function Poly(): Dynamic;
	static public function SetRenderLoop(): Dynamic;
	static public function SetZ(): Dynamic;
	static public function String(): Dynamic;
	static public function Triangle(): Dynamic;
}

@:native("_G.DynamicShadow")
extern class DynamicShadow
{
	static public function Enable(): Dynamic;
	static public function SetSize(): Dynamic;
}

@:native("_G.Entity")
extern class Entity
{
	static public function AddAccountManager(): Dynamic;
	static public function AddAnimState(): Dynamic;
	static public function AddClientSleepable(): Dynamic;
	static public function AddDebugRender(): Dynamic;
	static public function AddDynamicShadow(): Dynamic;
	static public function AddEnvelopeManager(): Dynamic;
	static public function AddFollower(): Dynamic;
	static public function AddFontManager(): Dynamic;
	static public function AddGraphicsOptions(): Dynamic;
	static public function AddGroundCreep(): Dynamic;
	static public function AddGroundCreepEntity(): Dynamic;
	static public function AddImage(): Dynamic;
	static public function AddImageWidget(): Dynamic;
	static public function AddLabel(): Dynamic;
	static public function AddLight(): Dynamic;
	static public function AddLightWatcher(): Dynamic;
	static public function AddMap(): Dynamic;
	static public function AddMapExplorer(): Dynamic;
	static public function AddMapGenSim(): Dynamic;
	static public function AddMapLayerManager(): Dynamic;
	static public function AddMiniMap(): Dynamic;
	static public function AddMiniMapEntity(): Dynamic;
	static public function AddNetwork(): Dynamic;
	static public function AddParticleEmitter(): Dynamic;
	static public function AddPathfinder(): Dynamic;
	static public function AddPhysics(): Dynamic;
	static public function AddPostProcessor(): Dynamic;
	static public function AddRoadManager(): Dynamic;
	static public function AddShadowManager(): Dynamic;
	static public function AddShardClient(): Dynamic;
	static public function AddShardNetwork(): Dynamic;
	static public function AddSoundEmitter(): Dynamic;
	static public function AddStaticShadow(): Dynamic;
	static public function AddTag(): Dynamic;
	static public function AddTextEditWidget(): Dynamic;
	static public function AddTextWidget(): Dynamic;
	static public function AddTransform(): Dynamic;
	static public function AddTwitchOptions(): Dynamic;
	static public function AddUITransform(): Dynamic;
	static public function AddVFXEffect(): Dynamic;
	static public function AddVideoWidget(): Dynamic;
	static public function AddWaveComponent(): Dynamic;
	static public function CallPrefabConstructionComplete(): Dynamic;
	static public function CanPredictMovement(): Dynamic;
	static public function EnableMovementPrediction(): Dynamic;
	static public function FlattenMovementPrediction(): Dynamic;
	static public function FlushLocalDirtyNetVars(): Dynamic;
	static public function FrustumCheck(): Dynamic;
	static public function GetDebugString(): Dynamic;
	static public function GetGUID(): GUID;
	static public function GetName(): Dynamic;
	static public function GetParent(): Dynamic;
	static public function GetPrefabName(): Dynamic;
	static public function HasTag(): Dynamic;
	static public function Hide(): Dynamic;
	static public function IsAwake(): Dynamic;
	static public function IsValid(): Dynamic;
	static public function IsVisible(): Dynamic;
	static public function LocalToWorldSpace(): Dynamic;
	static public function LocalToWorldSpaceIncParent(): Dynamic;
	static public function MoveToBack(): Dynamic;
	static public function MoveToFront(): Dynamic;
	static public function RemoveTag(): Dynamic;
	static public function Retire(): Dynamic;
	static public function SetAABB(): Dynamic;
	static public function SetCanSleep(): Dynamic;
	static public function SetClickable(): Dynamic;
	static public function SetInLimbo(): Dynamic;
	static public function SetIsPredictingMovement(): Dynamic;
	static public function SetName(): Dynamic;
	static public function SetParent(): Dynamic;
	static public function SetPrefabName(): Dynamic;
	static public function SetPristine(): Dynamic;
	static public function SetSelected(): Dynamic;
	static public function Show(): Dynamic;
	static public function WorldToLocalSpace(): Dynamic;
}

@:native("_G.Ents")
extern class Ents
{
}

@:native("_G.EnvelopeManager")
extern class EnvelopeManager
{
	static public function AddColourEnvelope(): Dynamic;
	static public function AddFloatEnvelope(): Dynamic;
	static public function AddVector2Envelope(): Dynamic;
}

@:native("_G.Follower")
extern class Follower
{
	static public function FollowSymbol(): Dynamic;
	static public function SetOffset(): Dynamic;
}

@:native("_G.FontManager")
extern class FontManager
{
	static public function RegisterFont(): Dynamic;
}

@:native("_G.GameService")
extern class GameService
{
	static public function AwardAchievement(): Dynamic;
	static public function RegisterAchievement(): Dynamic;
}

@:native("_G.GraphicsOptions")
extern class GraphicsOptions
{
	static public function DisableLightMapComponent(): Dynamic;
	static public function DisableStencil(): Dynamic;
	static public function EnableLightMapComponent(): Dynamic;
	static public function EnableStencil(): Dynamic;
	static public function GetCurrentDisplayModeID(): Dynamic;
	static public function GetDisplayMode(): Dynamic;
	static public function GetDisplayName(): Dynamic;
	static public function GetFullscreenDisplayID(): Dynamic;
	static public function GetFullscreenDisplayRefreshRate(): Dynamic;
	static public function GetNumDisplayModes(): Dynamic;
	static public function GetNumDisplays(): Dynamic;
	static public function GetNumRefreshRates(): Dynamic;
	static public function GetRefreshRate(): Dynamic;
	static public function IsBloomEnabled(): Dynamic;
	static public function IsDistortionEnabled(): Dynamic;
	static public function IsFullScreen(): Dynamic;
	static public function IsFullScreenEnabled(): Dynamic;
	static public function IsSmallTexturesMode(): Dynamic;
	static public function SetBloomEnabled(): Dynamic;
	static public function SetDisplayMode(): Dynamic;
	static public function SetDistortionEnabled(): Dynamic;
	static public function SetFullScreen(): Dynamic;
	static public function SetSmallTexturesMode(): Dynamic;
	static public function ToggleFullScreen(): Dynamic;
}

@:native("_G.GroundCreep")
extern class GroundCreep
{
	static public function AddRenderLayer(): Dynamic;
	static public function FastForward(): Dynamic;
	static public function GetAsString(): Dynamic;
	static public function GetTriggeredCreepSpawners(): Dynamic;
	static public function OnCreep(): Dynamic;
	static public function SetFromString(): Dynamic;
	static public function SetMaxRadius(): Dynamic;
	static public function SetUpdateInterval(): Dynamic;
	static public function TriggerCreepSpawners(): Dynamic;
}

@:native("_G.GroundCreepEntity")
extern class GroundCreepEntity
{
	static public function SetRadius(): Dynamic;
}

@:native("_G.Image")
extern class Image
{
	static public function Enable(): Dynamic;
	static public function GetSize(): Dynamic;
	static public function SetAlphaRange(): Dynamic;
	static public function SetBlendMode(): Dynamic;
	static public function SetEffect(): Dynamic;
	static public function SetSize(): Dynamic;
	static public function SetTexture(): Dynamic;
	static public function SetTextureHandle(): Dynamic;
	static public function SetTint(): Dynamic;
	static public function SetUIOffset(): Dynamic;
	static public function SetWorldOffset(): Dynamic;
}

@:native("_G.ImageWidget")
extern class ImageWidget
{
	static public function EnableEffectParams(): Dynamic;
	static public function GetSize(): Dynamic;
	static public function SetAlphaRange(): Dynamic;
	static public function SetBlendMode(): Dynamic;
	static public function SetEffect(): Dynamic;
	static public function SetEffectParams(): Dynamic;
	static public function SetHAnchor(): Dynamic;
	static public function SetSize(): Dynamic;
	static public function SetTexture(): Dynamic;
	static public function SetTextureHandle(): Dynamic;
	static public function SetTint(): Dynamic;
	static public function SetUVScale(): Dynamic;
	static public function SetVAnchor(): Dynamic;
}

@:native("_G.InputProxy")
extern class InputProxy
{
	static public function AddVibration(): Dynamic;
	static public function ApplyControlMapping(): Dynamic;
	static public function CancelMapping(): Dynamic;
	static public function EnableInputDevice(): Dynamic;
	static public function EnableVibration(): Dynamic;
	static public function FlushInput(): Dynamic;
	static public function GetInputDeviceCount(): Dynamic;
	static public function GetInputDeviceName(): Dynamic;
	static public function GetInputDeviceType(): Dynamic;
	static public function GetLastActiveControllerIndex(): Dynamic;
	static public function GetLocalizedControl(): Dynamic;
	static public function GetOSCursorPos(): Dynamic;
	static public function HasMappingChanged(): Dynamic;
	static public function IsAnyControllerActive(): Dynamic;
	static public function IsAnyControllerConnected(): Dynamic;
	static public function IsAnyInputDeviceConnected(): Dynamic;
	static public function IsInputDeviceConnected(): Dynamic;
	static public function IsInputDeviceEnabled(): Dynamic;
	static public function LoadControls(): Dynamic;
	static public function LoadCurrentControlMapping(): Dynamic;
	static public function LoadDefaultControlMapping(): Dynamic;
	static public function MapControl(): Dynamic;
	static public function RemoveVibration(): Dynamic;
	static public function SaveControls(): Dynamic;
	static public function SetCursorVisible(): Dynamic;
	static public function SetOSCursorPos(): Dynamic;
	static public function StartMappingControls(): Dynamic;
	static public function StopMappingControls(): Dynamic;
	static public function StopVibration(): Dynamic;
	static public function UnMapControl(): Dynamic;
}

@:native("_G.InventoryProxy")
extern class InventoryProxy
{
	static public function CheckClientOwnership(): Dynamic;
	static public function CheckOwnership(): Dynamic;
	static public function CheckOwnershipGetLatest(): Dynamic;
	static public function GetClientGiftCount(): Dynamic;
	static public function GetFullInventory(): Dynamic;
	static public function GetUnopenedEntitlementItems(): Dynamic;
	static public function GetUnopenedItems(): Dynamic;
	static public function HasDownloadedInventory(): Dynamic;
	static public function IsDownloadingInventory(): Dynamic;
	static public function SetItemOpened(): Dynamic;
}

@:native("_G.ItemServerProxy")
extern class ItemServerProxy
{
	static public function GetRecipes(): Dynamic;
	static public function RedeemCode(): Dynamic;
	static public function SwapItems(): Dynamic;
}

@:native("_G.Label")
extern class Label
{
	static public function Enable(): Dynamic;
	static public function SetColour(): Dynamic;
	static public function SetFont(): Dynamic;
	static public function SetFontSize(): Dynamic;
	static public function SetText(): Dynamic;
	static public function SetUIOffset(): Dynamic;
	static public function SetWorldOffset(): Dynamic;
}

@:native("_G.Light")
extern class Light
{
	static public function Enable(): Dynamic;
	static public function EnableClientModulation(): Dynamic;
	static public function GetCalculatedRadius(): Dynamic;
	static public function GetColour(): Dynamic;
	static public function GetDisableOnSceneRemoval(): Dynamic;
	static public function GetFalloff(): Dynamic;
	static public function GetIntensity(): Dynamic;
	static public function GetRadius(): Dynamic;
	static public function IsEnabled(): Dynamic;
	static public function SetColour(): Dynamic;
	static public function SetDisableOnSceneRemoval(): Dynamic;
	static public function SetFalloff(): Dynamic;
	static public function SetIntensity(): Dynamic;
	static public function SetRadius(): Dynamic;
}

@:native("_G.LightWatcher")
extern class LightWatcher
{
	static public function GetLightAngle(): Dynamic;
	static public function GetLightValue(): Dynamic;
	static public function GetTimeInDark(): Dynamic;
	static public function GetTimeInLight(): Dynamic;
	static public function IsInLight(): Dynamic;
	static public function SetDarkThresh(): Dynamic;
	static public function SetLightThresh(): Dynamic;
}

@:native("_G.Map")
extern class Map
{
	static public function AddRenderLayer(): Dynamic;
	static public function Fill(): Dynamic;
	static public function Finalize(): Dynamic;
	static public function GetEntitiesOnTileAtPoint(): Dynamic;
	static public function GetIslandAtPoint(): Dynamic;
	static public function GetNavStringEncode(): Dynamic;
	static public function GetNumVisitedTiles(): Dynamic;
	static public function GetNumWalkableTiles(): Dynamic;
	static public function GetRandomPointsForSite(): Dynamic;
	static public function GetSize(): Dynamic;
	static public function GetStringEncode(): Dynamic;
	static public function GetTile(): Dynamic;
	static public function GetTileAtPoint(): Dynamic;
	static public function GetTileCenterPoint(): Dynamic;
	static public function GetTileCoordsAtPoint(): Dynamic;
	static public function GetTileXYAtPoint(): Dynamic;
	static public function RebuildLayer(): Dynamic;
	static public function Replace(): Dynamic;
	static public function ResetVisited(): Dynamic;
	static public function SetFromString(): Dynamic;
	static public function SetImpassableType(): Dynamic;
	static public function SetNavFromString(): Dynamic;
	static public function SetNavSize(): Dynamic;
	static public function SetOverlayColor0(): Dynamic;
	static public function SetOverlayColor1(): Dynamic;
	static public function SetOverlayColor2(): Dynamic;
	static public function SetOverlayLerp(): Dynamic;
	static public function SetOverlayTexture(): Dynamic;
	static public function SetPhysicsWallDistance(): Dynamic;
	static public function SetSize(): Dynamic;
	static public function SetTile(): Dynamic;
	static public function SetUndergroundRenderLayer(): Dynamic;
	static public function TileVisited(): Dynamic;
	static public function VisitTile(): Dynamic;
}

@:native("_G.MapExplorer")
extern class MapExplorer
{
	static public function ActivateLocalMiniMap(): Dynamic;
	static public function EnableUpdate(): Dynamic;
	static public function LearnRecordedMap(): Dynamic;
	static public function RecordMap(): Dynamic;
	static public function RevealArea(): Dynamic;
}

@:native("_G.MapGenSim")
extern class MapGenSim
{
	static public function CreateBox(): Dynamic;
	static public function CreateCircle(): Dynamic;
	static public function CreateConstraint(): Dynamic;
	static public function CreateWorld(): Dynamic;
	static public function DestroyWorld(): Dynamic;
	static public function GetMinimumRadius(): Dynamic;
	static public function GetNodePosition(): Dynamic;
	static public function UpdateSim(): Dynamic;
}

@:native("_G.MapLayerManager")
extern class MapLayerManager
{
	static public function CreateRenderLayer(): Dynamic;
	static public function ReleaseRenderLayer(): Dynamic;
}

@:native("_G.MiniMap")
extern class MiniMap
{
	static public function AddAtlas(): Dynamic;
	static public function AddRenderLayer(): Dynamic;
	static public function ClearRevealedAreas(): Dynamic;
	static public function ContinuouslyClearRevealedAreas(): Dynamic;
	static public function DrawForgottenFogOfWar(): Dynamic;
	static public function EnableFogOfWar(): Dynamic;
	static public function GetTextureHandle(): Dynamic;
	static public function GetZoom(): Dynamic;
	static public function IsVisible(): Dynamic;
	static public function MapPosToWorldPos(): Dynamic;
	static public function Offset(): Dynamic;
	static public function RebuildLayer(): Dynamic;
	static public function ResetOffset(): Dynamic;
	static public function SetEffects(): Dynamic;
	static public function ShowArea(): Dynamic;
	static public function ToggleVisibility(): Dynamic;
	static public function WorldPosToMapPos(): Dynamic;
	static public function Zoom(): Dynamic;
}

@:native("_G.MiniMapEntity")
extern class MiniMapEntity
{
	static public function CopyIcon(): Dynamic;
	static public function SetCanUseCache(): Dynamic;
	static public function SetDrawOverFogOfWar(): Dynamic;
	static public function SetEnabled(): Dynamic;
	static public function SetIcon(): Dynamic;
	static public function SetIsFogRevealer(): Dynamic;
	static public function SetIsProxy(): Dynamic;
	static public function SetPriority(): Dynamic;
	static public function SetRestriction(): Dynamic;
}

@:native("_G.Network")
extern class Network
{
	static public function AddUserFlag(): Dynamic;
	static public function GetClientName(): Dynamic;
	static public function GetPlayerAge(): Dynamic;
	static public function GetPlayerColour(): Dynamic;
	static public function GetUserFlags(): Dynamic;
	static public function GetUserID(): Dynamic;
	static public function IsServerAdmin(): Dynamic;
	static public function RemoveUserFlag(): Dynamic;
	static public function SetClassifiedTarget(): Dynamic;
	static public function SetPlayerAge(): Dynamic;
	static public function SetPlayerEquip(): Dynamic;
	static public function SetPlayerSkin(): Dynamic;
}

@:native("_G.NetworkProxy")
extern class NetworkProxy
{
	static public function AddToWhiteList(): Dynamic;
	static public function Announce(): Dynamic;
	static public function AnnounceDeath(): Dynamic;
	static public function AnnounceResurrect(): Dynamic;
	static public function AnnounceVoteResult(): Dynamic;
	static public function AutoJoinLanServer(): Dynamic;
	static public function Ban(): Dynamic;
	static public function BanForTime(): Dynamic;
	static public function BeginServerModSetup(): Dynamic;
	static public function BeginSession(): Dynamic;
	static public function CallRPC(): Dynamic;
	static public function CleanupSessionCache(): Dynamic;
	static public function DeleteCluster(): Dynamic;
	static public function DeleteSession(): Dynamic;
	static public function DeleteUserSession(): Dynamic;
	static public function DeserializeAllLocalUserSessions(): Dynamic;
	static public function DeserializeUserSession(): Dynamic;
	static public function DeserializeUserSessionInClusterSlot(): Dynamic;
	static public function DiceRoll(): Dynamic;
	static public function Disconnect(): Dynamic;
	static public function DoneLoadingMap(): Dynamic;
	static public function DownloadServerDetails(): Dynamic;
	static public function DownloadServerMods(): Dynamic;
	static public function EncodeUserPath(): Dynamic;
	static public function GenerateClusterToken(): Dynamic;
	static public function GetAllowIncomingConnections(): Dynamic;
	static public function GetAutosaverEnabled(): Dynamic;
	static public function GetAveragePing(): Dynamic;
	static public function GetBlacklist(): Dynamic;
	static public function GetChildProcessError(): Dynamic;
	static public function GetChildProcessStatus(): Dynamic;
	static public function GetClientMetricsForUser(): Dynamic;
	static public function GetClientTable(): Dynamic;
	static public function GetClientTableForUser(): Dynamic;
	static public function GetCountryCode(): Dynamic;
	static public function GetCurrentSnapshot(): Dynamic;
	static public function GetDefaultClanAdmins(): Dynamic;
	static public function GetDefaultClanID(): Dynamic;
	static public function GetDefaultClanOnly(): Dynamic;
	static public function GetDefaultEncodeUserPath(): Dynamic;
	static public function GetDefaultEventSetting(): Dynamic;
	static public function GetDefaultFriendsOnlyServer(): Dynamic;
	static public function GetDefaultGameMode(): Dynamic;
	static public function GetDefaultLANOnlyServer(): Dynamic;
	static public function GetDefaultMaxPlayers(): Dynamic;
	static public function GetDefaultPvpSetting(): Dynamic;
	static public function GetDefaultServerDescription(): Dynamic;
	static public function GetDefaultServerIntention(): Dynamic;
	static public function GetDefaultServerName(): Dynamic;
	static public function GetDefaultServerPassword(): Dynamic;
	static public function GetDefaultVoteEnabled(): Dynamic;
	static public function GetIsClient(): Dynamic;
	static public function GetIsHosting(): Dynamic;
	static public function GetIsMasterSimulation(): Dynamic;
	static public function GetIsServer(): Dynamic;
	static public function GetIsServerAdmin(): Dynamic;
	static public function GetLanguageCode(): Dynamic;
	static public function GetLocalUserName(): Dynamic;
	static public function GetNetworkStatistics(): Dynamic;
	static public function GetPVPEnabled(): Dynamic;
	static public function GetPing(): Dynamic;
	static public function GetPlayerCount(): Dynamic;
	static public function GetPlayerSaveLocationInClusterSlot(): Dynamic;
	static public function GetServerClanID(): Dynamic;
	static public function GetServerClanOnly(): Dynamic;
	static public function GetServerDescription(): Dynamic;
	static public function GetServerEvent(): Dynamic;
	static public function GetServerFriendsOnly(): Dynamic;
	static public function GetServerGameMode(): Dynamic;
	static public function GetServerHasPassword(): Dynamic;
	static public function GetServerHasPresentAdmin(): Dynamic;
	static public function GetServerIntention(): Dynamic;
	static public function GetServerIsClientHosted(): Dynamic;
	static public function GetServerIsDedicated(): Dynamic;
	static public function GetServerLANOnly(): Dynamic;
	static public function GetServerListing(): Dynamic;
	static public function GetServerListingFromActualIndex(): Dynamic;
	static public function GetServerListingReadDirty(): Dynamic;
	static public function GetServerListings(): Dynamic;
	static public function GetServerMaxPlayers(): Dynamic;
	static public function GetServerModNames(): Dynamic;
	static public function GetServerModsDescription(): Dynamic;
	static public function GetServerModsEnabled(): Dynamic;
	static public function GetServerName(): Dynamic;
	static public function GetServerPVP(): Dynamic;
	static public function GetSessionIdentifier(): Dynamic;
	static public function GetUserID(): Dynamic;
	static public function GetUserSessionFile(): Dynamic;
	static public function GetUserSessionFileInClusterSlot(): Dynamic;
	static public function GetWorldSessionFile(): Dynamic;
	static public function GetWorldSessionFileInClusterSlot(): Dynamic;
	static public function HasPendingConnection(): Dynamic;
	static public function IncrementSnapshot(): Dynamic;
	static public function IsClanIDValid(): Dynamic;
	static public function IsDedicated(): Dynamic;
	static public function IsDedicatedOfflineCluster(): Dynamic;
	static public function IsNetIDPlatformValid(): Dynamic;
	static public function IsNetOverlayEnabled(): Dynamic;
	static public function IsOnlineMode(): Dynamic;
	static public function IsSearchingServers(): Dynamic;
	static public function IsVoiceActive(): Dynamic;
	static public function IsWhiteListed(): Dynamic;
	static public function JoinServerResponse(): Dynamic;
	static public function Kick(): Dynamic;
	static public function ListSnapshots(): Dynamic;
	static public function ListSnapshotsInClusterSlot(): Dynamic;
	static public function LoadPermissionLists(): Dynamic;
	static public function NotifyAuthenticationFailure(): Dynamic;
	static public function NotifyLoadingState(): Dynamic;
	static public function OnPlayerHistoryUpdated(): Dynamic;
	static public function PrintNetwork(): Dynamic;
	static public function RemoveFromWhiteList(): Dynamic;
	static public function ReportListing(): Dynamic;
	static public function RequestServerAndStartClient(): Dynamic;
	static public function Say(): Dynamic;
	static public function SearchLANServers(): Dynamic;
	static public function SearchServers(): Dynamic;
	static public function SendModRPCToServer(): Dynamic;
	static public function SendRPCToServer(): Dynamic;
	static public function SendRemoteExecute(): Dynamic;
	static public function SendResumeRequestToServer(): Dynamic;
	static public function SendSlashCmdToServer(): Dynamic;
	static public function SendSpawnRequestToServer(): Dynamic;
	static public function SendWorldResetRequestToServer(): Dynamic;
	static public function SendWorldRollbackRequestToServer(): Dynamic;
	static public function SendWorldSaveRequestToMaster(): Dynamic;
	static public function SerializeUserSession(): Dynamic;
	static public function SerializeWorldSession(): Dynamic;
	static public function ServerModCollectionSetup(): Dynamic;
	static public function ServerModSetup(): Dynamic;
	static public function ServerModsDownloadCompleted(): Dynamic;
	static public function SetAllowIncomingConnections(): Dynamic;
	static public function SetBlacklist(): Dynamic;
	static public function SetCheckVersionOnQuery(): Dynamic;
	static public function SetClientCacheSessionIdentifier(): Dynamic;
	static public function SetCurrentSnapshot(): Dynamic;
	static public function SetDefaultClanInfo(): Dynamic;
	static public function SetDefaultEventSetting(): Dynamic;
	static public function SetDefaultFriendsOnlyServer(): Dynamic;
	static public function SetDefaultGameMode(): Dynamic;
	static public function SetDefaultLANOnlyServer(): Dynamic;
	static public function SetDefaultMaxPlayers(): Dynamic;
	static public function SetDefaultPvpSetting(): Dynamic;
	static public function SetDefaultServerDescription(): Dynamic;
	static public function SetDefaultServerIntention(): Dynamic;
	static public function SetDefaultServerName(): Dynamic;
	static public function SetDefaultServerPassword(): Dynamic;
	static public function SetGameData(): Dynamic;
	static public function SetIsClientInWorld(): Dynamic;
	static public function SetIsWorldResetting(): Dynamic;
	static public function SetIsWorldSaving(): Dynamic;
	static public function SetPlayerMuted(): Dynamic;
	static public function SetSeason(): Dynamic;
	static public function SetServerTags(): Dynamic;
	static public function SetWorldGenData(): Dynamic;
	static public function StartClient(): Dynamic;
	static public function StartServer(): Dynamic;
	static public function StartVote(): Dynamic;
	static public function StopSearchingServers(): Dynamic;
	static public function StopVote(): Dynamic;
	static public function SystemMessage(): Dynamic;
	static public function Talker(): Dynamic;
	static public function TruncateSnapshots(): Dynamic;
	static public function TruncateSnapshotsInClusterSlot(): Dynamic;
	static public function TryDefaultEncodeUserPath(): Dynamic;
	static public function ViewNetFriends(): Dynamic;
	static public function ViewNetProfile(): Dynamic;
	static public function Vote(): Dynamic;
}

@:native("_G.ParticleEmitter")
extern class ParticleEmitter
{
	static public function AddParticle(): Dynamic;
	static public function AddParticleUV(): Dynamic;
	static public function AddRotatingParticle(): Dynamic;
	static public function AddRotatingParticleUV(): Dynamic;
	static public function ClearAllParticles(): Dynamic;
	static public function EnableBloomPass(): Dynamic;
	static public function EnableDepthTest(): Dynamic;
	static public function FastForward(): Dynamic;
	static public function GetNumLiveParticles(): Dynamic;
	static public function SetAcceleration(): Dynamic;
	static public function SetBlendMode(): Dynamic;
	static public function SetColourEnvelope(): Dynamic;
	static public function SetDragCoefficient(): Dynamic;
	static public function SetLayer(): Dynamic;
	static public function SetMaxLifetime(): Dynamic;
	static public function SetMaxNumParticles(): Dynamic;
	static public function SetRadius(): Dynamic;
	static public function SetRenderResources(): Dynamic;
	static public function SetRotationStatus(): Dynamic;
	static public function SetScaleEnvelope(): Dynamic;
	static public function SetSortOrder(): Dynamic;
	static public function SetSpawnVectors(): Dynamic;
	static public function SetUVFrameSize(): Dynamic;
}

@:native("_G.PathFinder")
extern class PathFinder
{
	static public function AddWall(): Dynamic;
	static public function GetPathTileIndexFromPoint(): Dynamic;
	static public function GetSearchResult(): Dynamic;
	static public function GetSearchStatus(): Dynamic;
	static public function HasWall(): Dynamic;
	static public function IsClear(): Dynamic;
	static public function KillSearch(): Dynamic;
	static public function RemoveWall(): Dynamic;
	static public function SubmitSearch(): Dynamic;
}

@:native("_G.Physics")
extern class Physics
{
	static public function CheckGridOffset(): Dynamic;
	static public function ClearCollisionMask(): Dynamic;
	static public function ClearMotorVelOverride(): Dynamic;
	static public function CollidesWith(): Dynamic;
	static public function GeoProbe(): Dynamic;
	static public function GetCollisionGroup(): Dynamic;
	static public function GetCollisionMask(): Dynamic;
	static public function GetHeight(): Dynamic;
	static public function GetMass(): Dynamic;
	static public function GetMotorSpeed(): Dynamic;
	static public function GetMotorVel(): Dynamic;
	static public function GetRadius(): Dynamic;
	static public function GetVelocity(): Dynamic;
	static public function IsActive(): Dynamic;
	static public function IsPassable(): Dynamic;
	static public function SetActive(): Dynamic;
	static public function SetCapsule(): Dynamic;
	static public function SetCollides(): Dynamic;
	static public function SetCollisionCallback(): Dynamic;
	static public function SetCollisionGroup(): Dynamic;
	static public function SetCollisionMask(): Dynamic;
	static public function SetCylinder(): Dynamic;
	static public function SetDamping(): Dynamic;
	static public function SetDontRemoveOnSleep(): Dynamic;
	static public function SetFriction(): Dynamic;
	static public function SetMass(): Dynamic;
	static public function SetMotorVel(): Dynamic;
	static public function SetMotorVelOverride(): Dynamic;
	static public function SetRestitution(): Dynamic;
	static public function SetSphere(): Dynamic;
	static public function SetVel(): Dynamic;
	static public function Stop(): Dynamic;
	static public function Teleport(): Dynamic;
}

@:native("_G.PostProcessor")
extern class PostProcessor
{
	static public function SetColourCubeData(): Dynamic;
	static public function SetColourCubeLerp(): Dynamic;
	static public function SetColourModifier(): Dynamic;
	static public function SetDistortionFactor(): Dynamic;
	static public function SetDistortionRadii(): Dynamic;
	static public function SetEffectTime(): Dynamic;
}

@:native("_G.RawImgui")
extern class RawImgui
{
	static public function IsImguiEnabled(): Dynamic;
}

@:native("_G.RoadManager")
extern class RoadManager {
	static public function AddControlPoint(): Dynamic;
	static public function AddSmoothedControlPoint(): Dynamic;
	static public function BeginRoad(): Dynamic;
	static public function GenerateQuadTree(): Dynamic;
	static public function GenerateVB(): Dynamic;
	static public function IsOnRoad(): Dynamic;
	static public function SetStripEffect(): Dynamic;
	static public function SetStripTextures(): Dynamic;
	static public function SetStripUVAnimStep(): Dynamic;
	static public function SetStripWrapMode(): Dynamic;
}

@:native("_G.ShadowManager")
extern class ShadowManager {
	static public function GenerateStaticShadows(): Dynamic;
	static public function SetTexture(): Dynamic;
}

@:native("_G.ShardClient")
extern class ShardClient {

}

@:native("_G.ShardNetwork")
extern class ShardNetwork {

}

@:native("_G.ShardProxy")
extern class ShardProxy {
	static public function GetDefaultShardEnabled(): Dynamic;
	static public function GetShardId(): Dynamic;
	static public function GetSlavePlayerCounts(): Dynamic;
	static public function IsMaster(): Dynamic;
	static public function IsMigrating(): Dynamic;
	static public function IsPlayer(): Dynamic;
	static public function IsSlave(): Dynamic;
	static public function SetSlaveLoading(): Dynamic;
	static public function StartMigration(): Dynamic;
}

@:native("_G.Sim")
extern class Sim {
	static public function AdjustFontAdvance(): Dynamic;
	static public function CanWriteConfigurationDirectory(): Dynamic;
	static public function CheckPersistentStringExists(): Dynamic;
	static public function CleanAllMods(): Dynamic;
	static public function ClearAllDSP(): Dynamic;
	static public function ClearDSP(): Dynamic;
	static public function ClearFileSystemAliases(): Dynamic;
	static public function ClearInput(): Dynamic;
	static public function CreateEntity(): Dynamic;
	static public function DebugPause(): Dynamic;
	static public function DebugPushJsonMessage(): Dynamic;
	static public function DebugStringScreen(): Dynamic;
	static public function DumpMemInfo(): Dynamic;
	static public function DumpMemoryStats(): Dynamic;
	static public function ErasePersistentString(): Dynamic;
	static public function FindEntities(): Dynamic;
	static public function FindFirstEntityWithTag(): Dynamic;
	static public function ForceAbort(): Dynamic;
	static public function GenerateNewWorld(): Dynamic;
	static public function GetAnalogControl(): Dynamic;
	static public function GetBuildDate(): Dynamic;
	static public function GetClientModsDownloading(): Dynamic;
	static public function GetClipboardData(): Dynamic;
	static public function GetDebugPhysicsRenderEnabled(): Dynamic;
	static public function GetDebugRenderEnabled(): Dynamic;
	static public function GetDigitalControl(): Dynamic;
	static public function GetEntitiesAtScreenPoint(): Dynamic;
	static public function GetEntityAtScreenPoint(): Dynamic;
	static public function GetFPS(): Dynamic;
	static public function GetFileModificationTime(): Dynamic;
	static public function GetGameID(): Dynamic;
	static public function GetGroundViewDirection(): Dynamic;
	static public function GetLightAtPoint(): Dynamic;
	static public function GetMOTDImage(): Dynamic;
	static public function GetModDirectoryNames(): Dynamic;
	static public function GetMouseButtonState(): Dynamic;
	static public function GetNumLaunches(): Dynamic;
	static public function GetNumberOfEntities(): Dynamic;
	static public function GetPersistentString(): Dynamic;
	static public function GetPersistentStringInClusterSlot(): Dynamic;
	static public function GetPosition(): Dynamic;
	static public function GetRealTime(): Dynamic;
	static public function GetScreenPos(): Dynamic;
	static public function GetScreenSize(): Dynamic;
	static public function GetServerModsDownloading(): Dynamic;
	static public function GetSetting(): Dynamic;
	static public function GetSoundVolume(): Dynamic;
	static public function GetStashedPlayInstance(): Dynamic;
	static public function GetSteamAppID(): Dynamic;
	static public function GetSteamBetaBranchName(): Dynamic;
	static public function GetSteamIDNumber(): Dynamic;
	static public function GetSteamUserID(): Dynamic;
	static public function GetStep(): Dynamic;
	static public function GetTick(): Dynamic;
	static public function GetTickTime(): Dynamic;
	static public function GetTimeScale(): Dynamic;
	static public function GetUserHasLicenseForApp(): Dynamic;
	static public function GetUsersName(): Dynamic;
	static public function GetWindowSize(): Dynamic;
	static public function GetWorkshopVersion(): Dynamic;
	static public function HasWindowFocus(): Dynamic;
	static public function HideAnimOnEntitiesWithTag(): Dynamic;
	static public function Hook(): Dynamic;
	static public function IsBorrowed(): Dynamic;
	static public function IsDLCEnabled(): Dynamic;
	static public function IsDLCInstalled(): Dynamic;
	static public function IsDebugPaused(): Dynamic;
	static public function IsKeyDown(): Dynamic;
	static public function IsLoggedOn(): Dynamic;
	static public function IsNetbookMode(): Dynamic;
	static public function IsPlaying(): Dynamic;
	static public function LoadFont(): Dynamic;
	static public function LoadPrefabs(): Dynamic;
	static public function LoadUserFile(): Dynamic;
	static public function LockModDir(): Dynamic;
	static public function LogBulkMetric(): Dynamic;
	static public function LuaPrint(): Dynamic;
	static public function LuaPrintRemote(): Dynamic;
	static public function MemTrackerPop(): Dynamic;
	static public function MemTrackerPush(): Dynamic;
	static public function OnAssetPathResolve(): Dynamic;
	static public function PreloadFile(): Dynamic;
	static public function PrintTextureInfo(): Dynamic;
	static public function Profile(): Dynamic;
	static public function ProfilerPop(): Dynamic;
	static public function ProfilerPush(): Dynamic;
	static public function ProjectScreenPos(): Dynamic;
	static public function QueryServer(): Dynamic;
	static public function QueryStats(): Dynamic;
	static public function QueueDownloadTempMod(): Dynamic;
	static public function Quit(): Dynamic;
	static public function RegisterPrefab(): Dynamic;
	static public function RemapSoundEvent(): Dynamic;
	static public function RenderOneFrame(): Dynamic;
	static public function ReportAction(): Dynamic;
	static public function RequestPlayerID(): Dynamic;
	static public function Reset(): Dynamic;
	static public function SendGameStat(): Dynamic;
	static public function SendHardwareStats(): Dynamic;
	static public function SendJSMessage(): Dynamic;
	static public function SendProfileStats(): Dynamic;
	static public function SendUITrigger(): Dynamic;
	static public function SetActiveAreaCenterpoint(): Dynamic;
	static public function SetAmbientColour(): Dynamic;
	static public function SetCameraDir(): Dynamic;
	static public function SetCameraFOV(): Dynamic;
	static public function SetCameraPos(): Dynamic;
	static public function SetCameraUp(): Dynamic;
	static public function SetDLCEnabled(): Dynamic;
	static public function SetDebugCameraRotation(): Dynamic;
	static public function SetDebugCameraTarget(): Dynamic;
	static public function SetDebugPhysicsRenderEnabled(): Dynamic;
	static public function SetDebugRenderEnabled(): Dynamic;
	static public function SetErosionTexture(): Dynamic;
	static public function SetHighPassFilter(): Dynamic;
	static public function SetInstanceParameters(): Dynamic;
	static public function SetListener(): Dynamic;
	static public function SetLowPassFilter(): Dynamic;
	static public function SetMemInfoTrackingInterval(): Dynamic;
	static public function SetMemoryTracking(): Dynamic;
	static public function SetNetbookMode(): Dynamic;
	static public function SetPersistentString(): Dynamic;
	static public function SetPersistentStringInClusterSlot(): Dynamic;
	static public function SetRenderPassDefaultEffect(): Dynamic;
	static public function SetReverbPreset(): Dynamic;
	static public function SetSetting(): Dynamic;
	static public function SetSoundVolume(): Dynamic;
	static public function SetTimeScale(): Dynamic;
	static public function SetUIRoot(): Dynamic;
	static public function SetVisualAmbientColour(): Dynamic;
	static public function SetupFontFallbacks(): Dynamic;
	static public function ShouldPlayIntroMovie(): Dynamic;
	static public function ShouldWarnModsLoaded(): Dynamic;
	static public function ShowAnimOnEntitiesWithTag(): Dynamic;
	static public function SpawnPrefab(): Dynamic;
	static public function StartDownloadTempMods(): Dynamic;
	static public function StartWorkshopQuery(): Dynamic;
	static public function StashPlayInstance(): Dynamic;
	static public function Step(): Dynamic;
	static public function StopAllSounds(): Dynamic;
	static public function SubscribeToMod(): Dynamic;
	static public function ToggleDataProfiler(): Dynamic;
	static public function ToggleDebugCamera(): Dynamic;
	static public function ToggleDebugPause(): Dynamic;
	static public function ToggleDebugTexture(): Dynamic;
	static public function ToggleFrameProfiler(): Dynamic;
	static public function TogglePerfGraph(): Dynamic;
	static public function TryLockModDir(): Dynamic;
	static public function TurnOffReverb(): Dynamic;
	static public function UnloadAllPrefabs(): Dynamic;
	static public function UnloadFont(): Dynamic;
	static public function UnloadPrefabs(): Dynamic;
	static public function UnlockModDir(): Dynamic;
	static public function UnregisterAllPrefabs(): Dynamic;
	static public function UnregisterPrefabs(): Dynamic;
	static public function UpdateDebugTexture(): Dynamic;
	static public function UpdateDeviceCaps(): Dynamic;
	static public function UpdateWorkshopMod(): Dynamic;
	static public function UserChooseDirectory(): Dynamic;
	static public function ValidateHeap(): Dynamic;
	static public function VerifyModVersions(): Dynamic;
	static public function WorldPointInPoly(): Dynamic;
}

@:native("_G.SoundEmitter")
extern class SoundEmitter {
	static public function GetEntity(): Dynamic;
	static public function KillAllSounds(): Dynamic;
	static public function KillSound(): Dynamic;
	static public function OverrideVolumeMultiplier(): Dynamic;
	static public function PlaySound(): Dynamic;
	static public function PlaySoundWithParams(): Dynamic;
	static public function PlayingSound(): Dynamic;
	static public function SetMute(): Dynamic;
	static public function SetParameter(): Dynamic;
	static public function SetVolume(): Dynamic;
}

@:native("_G.StaticShadow")
extern class StaticShadow {
	static public function SetSize(): Dynamic;
}

@:native("_G.SystemService")
extern class SystemService {
	static public function AdjustDisplaySafeArea(): Dynamic;
	static public function ClearLastOperation(): Dynamic;
	static public function DidBugReportSucceed(): Dynamic;
	static public function EnableAutosave(): Dynamic;
	static public function EnableStorage(): Dynamic;
	static public function FileBugReport(): Dynamic;
	static public function GetBugReportUserCode(): Dynamic;
	static public function GetLastOperation(): Dynamic;
	static public function GotoStorePageROG(): Dynamic;
	static public function HasFocus(): Dynamic;
	static public function IsAutosaveEnabled(): Dynamic;
	static public function IsBugReportRunning(): Dynamic;
	static public function IsDisplaySafeAreaAdjusted(): Dynamic;
	static public function IsStorageAvailable(): Dynamic;
	static public function IsStorageEnabled(): Dynamic;
	static public function OverwriteStorage(): Dynamic;
	static public function PrepareStorage(): Dynamic;
	static public function RetryOperation(): Dynamic;
	static public function SetStalling(): Dynamic;
	static public function StartDedicatedServers(): Dynamic;
	static public function StopDedicatedServers(): Dynamic;
}

@:native("_G.TextEditWidget")
extern class TextEditWidget {
	static public function EnableScrollEditWindow(): Dynamic;
	static public function GetString(): Dynamic;
	static public function OnKeyDown(): Dynamic;
	static public function OnKeyUp(): Dynamic;
	static public function OnTextInput(): Dynamic;
	static public function SetForceUpperCase(): Dynamic;
	static public function SetPassword(): Dynamic;
	static public function SetString(): Dynamic;
}

@:native("_G.TextWidget")
extern class TextWidget {
	static public function EnableWhitespaceWrap(): Dynamic;
	static public function EnableWordWrap(): Dynamic;
	static public function GetRegionSize(): Dynamic;
	static public function GetString(): Dynamic;
	static public function HasOverflow(): Dynamic;
	static public function SetColour(): Dynamic;
	static public function SetEditCursorColour(): Dynamic;
	static public function SetFont(): Dynamic;
	static public function SetHAnchor(): Dynamic;
	static public function SetHorizontalSqueeze(): Dynamic;
	static public function SetRegionSize(): Dynamic;
	static public function SetSize(): Dynamic;
	static public function SetString(): Dynamic;
	static public function SetVAnchor(): Dynamic;
	static public function ShowEditCursor(): Dynamic;
}

@:native("_G.Transform")
extern class Transform {
	static public function GetFacing(): Dynamic;
	static public function GetLocalPosition(): Dynamic;
	static public function GetPredictionPosition(): Dynamic;
	static public function GetRotation(): Dynamic;
	static public function GetScale(): Dynamic;
	static public function GetWorldPosition(): Dynamic;
	static public function SetEightFaced(): Dynamic;
	static public function SetFourFaced(): Dynamic;
	static public function SetFromProxy(): Dynamic;
	static public function SetNoFaced(): Dynamic;
	static public function SetPosition(): Dynamic;
	static public function SetRotation(): Dynamic;
	static public function SetScale(): Dynamic;
	static public function SetSixFaced(): Dynamic;
	static public function SetTwoFaced(): Dynamic;
	static public function UpdateTransform(): Dynamic;
}

@:native("_G.TwitchOptions")
extern class TwitchOptions {
	static public function Forget(): Dynamic;
	static public function GetBroadcastingEnabled(): Dynamic;
	static public function GetChannelName(): Dynamic;
	static public function GetChannelURL(): Dynamic;
	static public function GetStreamingState(): Dynamic;
	static public function GetStreamingStateString(): Dynamic;
	static public function GetUserName(): Dynamic;
	static public function GetVisibleChatEnabled(): Dynamic;
	static public function IsInitialized(): Dynamic;
	static public function IsPastInitializedState(): Dynamic;
	static public function IsStreaming(): Dynamic;
	static public function Login(): Dynamic;
	static public function SaveSettings(): Dynamic;
	static public function SetBroadcastingEnabled(): Dynamic;
	static public function SetVisibleChatEnabled(): Dynamic;
	static public function Start(): Dynamic;
	static public function Stop(): Dynamic;
	static public function SupportedByPlatform(): Dynamic;
	static public function ToggleStreaming(): Dynamic;
}

@:native("_G.UITransform")
extern class UITransform {
	static public function GetLocalPosition(): Dynamic;
	static public function GetRotation(): Dynamic;
	static public function GetScale(): Dynamic;
	static public function GetWorldPosition(): Dynamic;
	static public function SetHAnchor(): Dynamic;
	static public function SetMaxPropUpscale(): Dynamic;
	static public function SetPosition(): Dynamic;
	static public function SetRotation(): Dynamic;
	static public function SetScale(): Dynamic;
	static public function SetScaleMode(): Dynamic;
	static public function SetVAnchor(): Dynamic;
	static public function UpdateTransform(): Dynamic;
}

@:native("_G.VFXEffect")
extern class VFXEffect {
	static public function AddParticle(): Dynamic;
	static public function AddParticleUV(): Dynamic;
	static public function AddRotatingParticle(): Dynamic;
	static public function AddRotatingParticleUV(): Dynamic;
	static public function ClearAllParticles(): Dynamic;
	static public function EnableBloomPass(): Dynamic;
	static public function EnableDepthTest(): Dynamic;
	static public function FastForward(): Dynamic;
	static public function GetNumLiveParticles(): Dynamic;
	static public function InitEmitters(): Dynamic;
	static public function SetAcceleration(): Dynamic;
	static public function SetBlendMode(): Dynamic;
	static public function SetColourEnvelope(): Dynamic;
	static public function SetDragCoefficient(): Dynamic;
	static public function SetFollowEmitter(): Dynamic;
	static public function SetKillOnEntityDeath(): Dynamic;
	static public function SetMaxLifetime(): Dynamic;
	static public function SetMaxNumParticles(): Dynamic;
	static public function SetRadius(): Dynamic;
	static public function SetRenderResources(): Dynamic;
	static public function SetRotationStatus(): Dynamic;
	static public function SetScaleEnvelope(): Dynamic;
	static public function SetSortOffset(): Dynamic;
	static public function SetSortOrder(): Dynamic;
	static public function SetSpawnVectors(): Dynamic;
	static public function SetUVFrameSize(): Dynamic;
}

@:native("_G.VideoWidget")
extern class VideoWidget {
	static public function GetSize(): Dynamic;
	static public function IsDone(): Dynamic;
	static public function Load(): Dynamic;
	static public function Pause(): Dynamic;
	static public function Play(): Dynamic;
	static public function SetHAnchor(): Dynamic;
	static public function SetSize(): Dynamic;
	static public function SetVAnchor(): Dynamic;
	static public function Stop(): Dynamic;
}

@:native("_G.WaveComponent")
extern class WaveComponent {
	static public function Init(): Dynamic;
	static public function SetWaveEffect(): Dynamic;
	static public function SetWaveParams(): Dynamic;
	static public function SetWaveSize(): Dynamic;
	static public function SetWaveTexture(): Dynamic;
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