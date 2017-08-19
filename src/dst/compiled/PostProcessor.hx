package dst.compiled;

@:native("_G.PostProcessor")
extern class PostProcessor
{
	private function new();

	public function SetColourCubeData(): Dynamic;
	public function SetColourCubeLerp(): Dynamic;
	public function SetColourModifier(): Dynamic;
	public function SetDistortionFactor(): Dynamic;
	public function SetDistortionRadii(): Dynamic;
	public function SetEffectTime(): Dynamic;
}