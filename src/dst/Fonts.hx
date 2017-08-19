package dst;

/**
 * data/scripts/fonts.lua
 *
 * Enumerates available font names.
 */
@:native("_G")
@:enum
extern abstract FONT(String) // Externs
{
	var DEFAULTFONT; // "opensans"
	var DIALOGFONT; // "opensans"
	var TITLEFONT; // "bp100"
	var UIFONT; // "bp50"
	var BUTTONFONT; // "buttonfont"
	var NEWFONT; // "spirequal"
	var NEWFONT_SMALL; // "spirequal_small" -- hardly used
	var NEWFONT_OUTLINE; // "spirequal_outline"
	var NEWFONT_OUTLINE_SMALL; // "spirequal_outline_small" -- not in use
	var NUMBERFONT; // "stint-ucr"
	var TALKINGFONT; // "talkingfont"
	var SMALLNUMBERFONT; // "stint-small"
	var BODYTEXTFONT; // "stint-ucr"
	var CODEFONT; // "ptmono" -- not in use yet
	var CONTROLLERS; // "controllers"

	var FALLBACK_FONT; // "fallback_font"
	var FALLBACK_FONT_OUTLINE; // "fallback_font_outline"
}

@:native("_G")
extern class Fonts // Externs
{
	static public var DEFAULT_FALLBACK_TABLE: FONT; // CONTROLLERS, FALLBACK_FONT
	static public var DEFAULT_FALLBACK_TABLE_OUTLINE: FONT; // CONTROLLERS, FALLBACK_FONT_OUTLINE
	static public var FONTS: lua.Table<Int, FontDef>; // default: list of 15
}

private typedef FontDef =
{
	filename: String,
	alias: FONT,
	fallback: FONT,
	?adjustadvance: Int
};