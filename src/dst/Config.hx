package dst;

@:enum
abstract OPTION_NAME(String) {
	var hide_vignette = "hide_vignette";
	var force_netbookmode = "force_netbookmode";
}

private typedef OPTION_VALUE = {
	? hide_vignette: Bool, // true if ANDROID | IOS
	? force_netbookmode: Bool // true if NACL | ANDROID | IOS
}

 /**
  * data/scripts/config.lua
	*
  * Defines surprisingly few configuration values.
  */
@:native("_G.TheConfig")
extern class Config
{
	/**
	 * Singleton instance reference.
	 */
	static public var TheConfig(default, never): Config;

	private function new(options: OPTION_VALUE);

	/**
	 * Override existing configuration values.
	 *
	 * Used to initially define values, and to override them per-platform.
	 */
	public function SetOptions(options:OPTION_VALUE): Void;

	/**
	 * Whether named option is true or false.
	 */
	public function IsEnabled(option: OPTION_NAME): Bool;

	/**
	 * Set named option true.
	 */
	public function Enable(option: OPTION_NAME): Void;

	/**
	 * Set named option false.
	 */
	public function Disable(option: OPTION_NAME): Void;

	private function __tostring(): String;
}