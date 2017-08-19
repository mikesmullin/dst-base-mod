package dst.compiled;

@:native("_G.MapLayerManager")
extern class MapLayerManager
{
	private function new();

	public function CreateRenderLayer(): Dynamic;
	public function ReleaseRenderLayer(): Dynamic;
}