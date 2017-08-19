package dst.compiled;

@:native("_G.WaveComponent")
extern class WaveComponent
{
	private function new();

	public function Init(): Dynamic;
	public function SetWaveEffect(): Dynamic;
	public function SetWaveParams(): Dynamic;
	public function SetWaveSize(): Dynamic;
	public function SetWaveTexture(): Dynamic;
}