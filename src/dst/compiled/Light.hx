package dst.compiled;

/**
 * Light behaves a lot like a component, but isn’t one.
 * You must enable it on an EntityScript via `inst.entity.AddLight()`.
 *
 * see http://web.archive.org/web/20160529140348/http://dontstarveapi.com/wp-content/uploads/2015/02/light2.jpg
 */
extern class Light
{
	/**
	 * True activates the light,
	 * false disables it.
	 */
	public function Enable(enabled: Bool): Void;

	public function EnableClientModulation(): Void;

	public function GetCalculatedRadius(): Dynamic;
	public function GetColour(): Dynamic;
	public function GetDisableOnSceneRemoval(): Dynamic;
	public function GetFalloff(): Dynamic;

	public function GetIntensity(): Float;
	public function GetRadius(): Float;
	public function IsEnabled(): Bool;

	public function SetDisableOnSceneRemoval(): Void;

	/**
	 * Red, green, blue in percent.
	 */
	public function SetColour(r: Float, g: Float, b: Float): Void;

	/**
	 * How rapidly the light goes from full intensity to none.
	 */
	public function SetFalloff(percent: Float): Void;

	/**
	 * How bright the light is.
	 */
	public function SetIntensity(percent: Float): Void;

	/**
	 * How far the light shines.
	 */
	public function SetRadius(radius: Int): Void;
}