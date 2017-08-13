package dst.widgets;

import haxe.extern.Rest;

extern class Screen extends Widget
{
	// public var focusstack: {}; // default: {}
	// public var focusindex: Int; // default: 0
	public var handlers: Array<{}>; // default: {}

	public function OnCreate(): Dynamic;
	public function GetHelpText(): Dynamic;
	public function OnDestroy(): Dynamic;
	public function OnUpdate(dt: Dynamic): Dynamic;
	public function OnBecomeInactive(): Dynamic;
	public function OnBecomeActive(): Dynamic;
	public function AddEventHandler(event: Dynamic, fn: Dynamic): Dynamic;
	public function RemoveEventHandler(event: Dynamic, fn: Dynamic): Dynamic;
	public function HandleEvent(type: Dynamic, args:Rest<Dynamic>): Dynamic;
	public function SetDefaultFocus(): Dynamic;
}