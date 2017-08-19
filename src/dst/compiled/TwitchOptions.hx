package dst.compiled;

/**
 * bin/twitchsdk_32_release.dll
 */
@:native("_G.TwitchOptions")
extern class TwitchOptions
{
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