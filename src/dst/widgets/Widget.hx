package dst.widgets;

import haxe.Constraints.Function;
import haxe.extern.Rest;
import dst.EntityScript;
import dst.ExplicitLuaClass;

/**
 * data/scripts/widgets/widget.lua
 *
 * Base class extended by anything displayed
 * on the screen in the foreground GUI.
 *
 * It yields core functions, focus and child systems,
 * and an entity for the uianim component.
 */
extern class Widget extends ExplicitLuaClass
{
	@:selfCall
	public function new(name: String);
	
	/**
	 * The parent widget, if available.
	 */
	public var parent: Widget;

	/**
	 * All widgets added to this one as a child are referenced here.
	 */
	public var children: Array<Widget>;

	/**
	 * Holds a list of callbacks, not really used externally.
	 */
	public var callbacks: Array<Function>;


	public var name: String; // default: "widget"

	/**
	 * An EntityScript for the uianim component, positioning and other stuff.
	 */
	public var inst: WidgetEntity; // default: CreateEntity()

	/**
	 * Whether the widget is enabled.
	 * You can break the focus flow using this.
	 */
	public var enabled: Bool; // default: true

	/**
	 * Whether the widget is visible.
	 */
	public var shown: Bool; // default: true

	/**
	 * Whether the mouse hovers over this widget.
	 */
	public var focus: Bool; // default: false

	/**
	 * Whether this widget is the absolute target of the mouse.
	 */
	public var focus_target: Bool; // default: false
	public var can_fade_alpha: Bool; // default: true

	/**
	 * Not really used externally.
	 */
	public var focus_flow: Array<{}>; // default: {}

	/**
	 * Not really used externally.
	 */
	public var focus_flow_args: Array<{}>; // default: {}


	public function IsDeepestFocus(): Bool;
	public function OnMouseButton(button: Dynamic, down: Dynamic, x: Dynamic, y: Dynamic): Dynamic;
	public function MoveToBack(): Dynamic;
	public function MoveToFront(): Dynamic;
	public function OnFocusMove(dir: Dynamic, down: Dynamic): Dynamic;
	public function IsVisible(): Dynamic;
	public function OnRawKey(key: Dynamic, down: Dynamic): Dynamic;
	public function OnTextInput(text: Dynamic): Dynamic;
	public function OnStopForceProcessTextInput(): Dynamic;
	public function OnControl(control: Dynamic, down: Dynamic): Dynamic;
	public function SetParentScrollList(list: Dynamic): Dynamic;
	public function IsEditing(): Dynamic;
	public function ScaleTo(from: Dynamic, to: Dynamic, time: Dynamic, fn: Dynamic): Dynamic;
	
	public function CancelMoveTo(run_complete_fn: Dynamic): Dynamic;
	public function MoveTo(from: Dynamic, to: Dynamic, time: Dynamic, fn: Dynamic): Dynamic;
	public function TintTo(from: Dynamic, to: Dynamic, time: Dynamic, fn: Dynamic): Dynamic;
	public function ForceStartWallUpdating(): Dynamic;
	public function ForceStopWallUpdating(): Dynamic;
	public function IsEnabled(): Dynamic;
	public function GetParent(): Dynamic;
	public function GetChildren(): Dynamic;
	public function Enable(): Dynamic;
	public function Disable(): Dynamic;
	public function OnEnable(): Dynamic;
	public function OnDisable(): Dynamic;
	public function RemoveChild(child: Dynamic): Dynamic;
	public function KillAllChildren(): Dynamic;
	public function AddChild(child: Dynamic): Dynamic;
	public function Hide(): Dynamic;
	public function Show(): Dynamic;
	public function Kill(): Dynamic;
	public function GetWorldPosition(): Dynamic;
	public function GetPosition(): Dynamic;
	public function Nudge(offset: Dynamic): Dynamic;
	public function GetLocalPosition(): Dynamic;
	public function SetPosition(pos: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function SetRotation(angle: Dynamic): Dynamic;
	public function SetMaxPropUpscale(val: Dynamic): Dynamic;
	public function SetScaleMode(mode: Dynamic): Dynamic;
	public function SetScale(pos: Dynamic, y: Dynamic, z: Dynamic): Dynamic;
	public function HookCallback(event: Dynamic, fn: Dynamic): Dynamic;
	public function SetVAnchor(anchor: Dynamic): Dynamic;
	public function SetHAnchor(anchor: Dynamic): Dynamic;
	public function OnShow(): Dynamic;
	public function OnHide(): Dynamic;
	public function SetTooltip(str: Dynamic): Dynamic;
	public function SetTooltipPos(pos: Dynamic, pos_y: Dynamic, pos_z: Dynamic): Dynamic;
	public function SetTooltipColour(r: Dynamic,g: Dynamic,b: Dynamic,a: Dynamic): Dynamic;
	public function GetTooltipColour(): Dynamic;
	public function GetTooltip(): Dynamic;
	public function GetTooltipPos(): Dynamic;
	public function StartUpdating(): Dynamic;
	public function StopUpdating(): Dynamic;
	// public function Update(dt: Dynamic): Dynamic;
	public function DebugDraw_AddSection(dbui: Dynamic): Dynamic;
	public function SetFadeAlpha(alpha: Int, skipChildren: Bool): Void;;
	public function SetCanFadeAlpha(fade: Dynamic, skipChildren: Dynamic): Dynamic;
	public function SetClickable(val: Dynamic): Dynamic;
	public function UpdatePosition(x: Dynamic,y: Dynamic): Dynamic;
	public function FollowMouse(): Dynamic;
	public function StopFollowMouse(): Dynamic;
	public function GetScale(): Dynamic;
	public function GetLooseScale(): Dynamic;

	/**
	 * Focus management.
	 */
	 
	public function OnGainFocus(): Dynamic;
	public function OnLoseFocus(): Dynamic;
	public function SetOnGainFocus(fn: Dynamic): Dynamic;
	public function SetOnLoseFocus(fn: Dynamic): Dynamic;
	public function ClearFocusDirs(): Dynamic;
	public function SetFocusChangeDir(dir: Dynamic, widget: Dynamic, args:Rest<Dynamic>): Dynamic;
	public function GetDeepestFocus(): Dynamic;
	public function GetFocusChild(): Dynamic;
	public function ClearFocus(): Dynamic;
	public function SetFocusFromChild(from_child: Dynamic): Dynamic;
	public function SetFocus(): Dynamic;
	public function GetStr(indent: Dynamic): Dynamic;
	public function SetHoverText(text: Dynamic, params: Dynamic): Dynamic;
	public function ClearHoverText(): Dynamic;

	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

private extern class WidgetEntity extends EntityScript
{
	public var widget: Widget;
}