package dst.widgets;

import haxe.extern.Rest;

extern class Text extends Widget
{
	public function new(font: String, size: Int, text: String, colour: Colour);

	public var font: String;
	public var size: Int;
	public var colour: Colour;

	public override function DebugDraw_AddSection(dbui: Dynamic): Dynamic;

	// compile-time type-checking overload
	inline public function SetColour(colour: Colour): Void {
		untyped SetColourRGBA(unwrap(colour));
	}

	// a middle overload for untyped call above
	@:overload(function(rgba: Rest<Float>): Void {})
	// the real interface
	@:native("SetColour")
	private function SetColourRGBA(r: Float, g: Float, b: Float, a: Float): Void;
	public function GetColour(): Colour;

	public function SetHorizontalSqueeze(squeeze: Dynamic): Void;
	public override function SetFadeAlpha(alpha: Float, skipChildren: Bool): Void;
	public function SetAlpha(a: Float): Void;
	public function SetFont(font: String): Void;
	public function SetSize(sz: Dynamic): Void;
	public function SetRegionSize(w: Int, h: Int): Void;
	public function GetRegionSize(): RegionSize;
	public function SetString(str: String): Void;
	public function GetString(): String;
	public function SetTruncatedString(str: String, maxwidth: Int, maxchars: Int, ellipses: Dynamic): Void;
	public function SetMultilineTruncatedString(str: String, maxlines: Int, maxwidth: Int, maxcharsperline: Int, ellipses: Dynamic): Void;
	public function SetVAlign(anchor: Int): Void;
	public function SetHAlign(anchor: Int): Void;
	public function EnableWordWrap(enable: Bool): Void;
	public function EnableWhitespaceWrap(enable: Bool): Void;

	private override function __tostring(): String;
}

@:multiReturn
private extern class RegionSize {
	var w: Float;
	var h: Float;
}