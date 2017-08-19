package dst.compiled;

@:native("_G.MapExplorer")
extern class MapExplorer
{
	private function new();

	public function ActivateLocalMiniMap(): Dynamic;
	public function EnableUpdate(): Dynamic;
	public function LearnRecordedMap(): Dynamic;
	public function RecordMap(): Dynamic;
	public function RevealArea(): Dynamic;
}