package dst.compiled;

@:native("_G.ShadowManager")
extern class ShadowManager
{
	private function new();

	public function GenerateStaticShadows(): Dynamic;
	public function SetTexture(): Dynamic;
}