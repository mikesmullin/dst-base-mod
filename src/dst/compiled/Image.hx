package dst.compiled;

@:native("_G.Image")
extern class Image
{
	private function new();

	public function Enable(): Dynamic;
	public function GetSize(): Dynamic;
	public function SetAlphaRange(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetEffect(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetTexture(): Dynamic;
	public function SetTextureHandle(): Dynamic;
	public function SetTint(): Dynamic;
	public function SetUIOffset(): Dynamic;
	public function SetWorldOffset(): Dynamic;
}