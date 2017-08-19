package dst.compiled;

@:native("_G.SystemService")
extern class SystemService
{
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