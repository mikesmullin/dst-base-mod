package dst.compiled;

@:native("_G.LightWatcher")
extern class LightWatcher
{
	private function new();

	public function GetLightAngle(): Dynamic;
	public function GetLightValue(): Dynamic;
	public function GetTimeInDark(): Dynamic;
	public function GetTimeInLight(): Dynamic;
	public function IsInLight(): Dynamic;
	public function SetDarkThresh(): Dynamic;
	public function SetLightThresh(): Dynamic;
}