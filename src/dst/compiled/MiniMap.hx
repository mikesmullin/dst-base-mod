package dst.compiled;

@:native("_G.MiniMap")
extern class MiniMap
{
	private function new();

	public function AddAtlas(): Dynamic;
	public function AddRenderLayer(): Dynamic;
	public function ClearRevealedAreas(): Dynamic;
	public function ContinuouslyClearRevealedAreas(): Dynamic;
	public function DrawForgottenFogOfWar(): Dynamic;
	public function EnableFogOfWar(): Dynamic;
	public function GetTextureHandle(): Dynamic;
	public function GetZoom(): Dynamic;
	public function IsVisible(): Dynamic;
	public function MapPosToWorldPos(): Dynamic;
	public function Offset(): Dynamic;
	public function RebuildLayer(): Dynamic;
	public function ResetOffset(): Dynamic;
	public function SetEffects(): Dynamic;
	public function ShowArea(): Dynamic;
	public function ToggleVisibility(): Dynamic;
	public function WorldPosToMapPos(): Dynamic;
	public function Zoom(): Dynamic;
}