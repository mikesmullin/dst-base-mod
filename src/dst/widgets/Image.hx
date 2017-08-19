package dst.widgets;

extern class Image extends Widget
{
	public function new(? atlas: Dynamic, ? tex: Dynamic, ? default_tex: Dynamic);

	public override function DebugDraw_AddSection(dbui: Dynamic): Dynamic;
	public function SetAlphaRange(min: Dynamic, max: Dynamic): Dynamic;
	public function SetTexture(atlas: Dynamic, tex: Dynamic, default_tex: Dynamic): Dynamic;
	public function SetMouseOverTexture(atlas: Dynamic, tex: Dynamic): Dynamic;
	public function SetDisabledTexture(atlas: Dynamic, tex: Dynamic): Dynamic;
	public function SetSize(w: Dynamic, h: Dynamic): Dynamic;
	public function GetSize(): Dynamic;
	public function ScaleToSize(w: Dynamic, h: Dynamic): Dynamic;
	public function SetTint(r: Dynamic, g: Dynamic,b: Dynamic,a: Dynamic): Dynamic;
	public override function SetFadeAlpha(alpha: Float, skipChildren: Bool): Void;
	public function SetVRegPoint(anchor: Dynamic): Dynamic;
	public function SetHRegPoint(anchor: Dynamic): Dynamic;
	public function OnMouseOver(): Dynamic;
	public function OnMouseOut(): Dynamic;
	public override function OnEnable(): Dynamic;
	public override function OnDisable(): Dynamic;
	public function SetEffect(filename: Dynamic): Dynamic;
	public function SetEffectParams(param1: Dynamic, param2: Dynamic, param3: Dynamic, param4: Dynamic): Dynamic;
	public function EnableEffectParams(enabled: Dynamic): Dynamic;
	public function SetUVScale(xScale: Dynamic, yScale: Dynamic): Dynamic;
	public function SetBlendMode(mode: Dynamic): Dynamic;

	/**
	 * Serialize this object to console-friendly string.
	 */
	public override function __tostring(): String;
}