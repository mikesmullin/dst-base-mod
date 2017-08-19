package dst.compiled;

@:native("_G.PathFinder")
extern class PathFinder
{
	private function new();

	public function AddWall(): Dynamic;
	public function GetPathTileIndexFromPoint(): Dynamic;
	public function GetSearchResult(): Dynamic;
	public function GetSearchStatus(): Dynamic;
	public function HasWall(): Dynamic;
	public function IsClear(): Dynamic;
	public function KillSearch(): Dynamic;
	public function RemoveWall(): Dynamic;
	public function SubmitSearch(): Dynamic;
}