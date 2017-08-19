package dst.compiled;

@:native("_G.VideoWidget")
extern class VideoWidget
{
	private function new();

	public function GetSize(): Dynamic;
	public function IsDone(): Dynamic;
	public function Load(): Dynamic;
	public function Pause(): Dynamic;
	public function Play(): Dynamic;
	public function SetHAnchor(): Dynamic;
	public function SetSize(): Dynamic;
	public function SetVAnchor(): Dynamic;
	public function Stop(): Dynamic;
}