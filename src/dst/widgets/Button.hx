package dst.widgets;

import dst.Fonts.FONT;
import dst.Constants.CONTROL;

extern class Button extends Widget
{
	public function new();

	public var font: FONT;
	public var fontdisabled: String;

	public var textcolour: Colour;
	public var textfocuscolour: Colour;
	public var textdisabledcolour: Colour;
	public var textselectedcolour: Colour;

	public var text: Text;

	public var clickoffset: Vector3;

	public var selected: Bool; // default: false
	public var control: CONTROL; // default: ACCEPT
	public var help_message: String; // default: STRINGS.UI.HELP.SELECT

	public function SetControl(ctrl: Dynamic): Dynamic;
	public override function OnControl(control: Dynamic, down: Dynamic): Dynamic;
	public function OnUpdate(dt: Dynamic): Dynamic;
	public override function OnGainFocus(): Dynamic;
	public override function OnLoseFocus(): Dynamic;
	public override function OnEnable(): Dynamic;
	public override function OnDisable(): Dynamic;
	public function Select(): Dynamic;
	public function Unselect(): Dynamic;
	public function OnSelect(): Dynamic;
	public function OnUnselect(): Dynamic;
	public function IsSelected(): Dynamic;
	public function SetOnClick( fn : Dynamic): Dynamic;
	public function SetOnSelect( fn : Dynamic): Dynamic;
	public function SetOnUnSelect( fn : Dynamic): Dynamic;
	public function SetOnDown( fn : Dynamic): Dynamic;
	public function SetWhileDown( fn : Dynamic): Dynamic;
	public function SetFont(font: Dynamic): Dynamic;
	public function SetDisabledFont(font: Dynamic): Dynamic;
	public function SetTextColour(r: Dynamic, g: Dynamic, b: Dynamic, a: Dynamic): Dynamic;
	public function SetTextFocusColour(r: Dynamic, g: Dynamic, b: Dynamic, a: Dynamic): Dynamic;
	public function SetTextDisabledColour(r: Dynamic, g: Dynamic, b: Dynamic, a: Dynamic): Dynamic;
	public function SetTextSelectedColour(r: Dynamic, g: Dynamic, b: Dynamic, a: Dynamic): Dynamic;
	public function SetTextSize(sz: Dynamic): Dynamic;
	public function GetText(): Dynamic;
	public function SetText(msg: Dynamic, dropShadow: Dynamic, dropShadowOffset: Dynamic): Dynamic;
	public function SetHelpTextMessage(str: Dynamic): Dynamic;
	public function GetHelpText(): Dynamic;
}