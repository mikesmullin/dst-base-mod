package dst.compiled;

@:native("_G.GraphicsOptions")
extern class GraphicsOptions
{
	private function new();

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