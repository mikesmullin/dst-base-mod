package dst.compiled;

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