package dst;

/**
 * data/scripts/fonts.lua
 *
 * Enumerates available font names.
 */
@:native("_G")
extern enum FONT
{
	DEFAULTFONT; // "opensans"
	DIALOGFONT; // "opensans"
	TITLEFONT; // "bp100"
	UIFONT; // "bp50"
	BUTTONFONT; // "buttonfont"
	NEWFONT; // "spirequal"
	NEWFONT_SMALL; // "spirequal_small" -- hardly used
	NEWFONT_OUTLINE; // "spirequal_outline"
	NEWFONT_OUTLINE_SMALL; // "spirequal_outline_small" -- not in use
	NUMBERFONT; // "stint-ucr"
	TALKINGFONT; // "talkingfont"
	SMALLNUMBERFONT; // "stint-small"
	BODYTEXTFONT; // "stint-ucr"
	CODEFONT; // "ptmono" -- not in use yet
	CONTROLLERS; // "controllers"

	FALLBACK_FONT; // "fallback_font"
	FALLBACK_FONT_OUTLINE; // "fallback_font_outline"
}

@:native("_G")
extern class Fonts
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