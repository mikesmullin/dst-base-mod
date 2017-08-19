package dst.compiled;

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