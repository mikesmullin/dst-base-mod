package dst;

 /**
  * data/scripts/config.lua
	*
  * Not as useful as it sounds.
  */
@:native("_G")
extern class ConfigExterns // Externs
{
	/**
	* Singleton instance.
	*/
	static public var TheConfig: Config;
}

private extern class Config extends ExplicitLuaClass
{
	@:selfCall
	public function new(options: OPTION_VALUE);

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

	/**
	 * Serialize this object to console-friendly string.
	 */
	public function __tostring(): String;
}

@:enum
abstract OPTION_NAME(String) {
	var hide_vignette = "hide_vignette";
	var force_netbookmode = "force_netbookmode";
}

private typedef OPTION_VALUE = {
	? hide_vignette: Bool, // true if ANDROID | IOS
	? force_netbookmode: Bool // true if NACL | ANDROID | IOS
}