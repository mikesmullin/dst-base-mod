package dst.compiled;

@:native("_G.MapGenSim")
extern class MapGenSim
{
	public function CreateBox(): Dynamic;
	public function CreateCircle(): Dynamic;
	public function CreateConstraint(): Dynamic;
	public function CreateWorld(): Dynamic;
	public function DestroyWorld(): Dynamic;
	public function GetMinimumRadius(): Dynamic;
	public function GetNodePosition(): Dynamic;
	public function UpdateSim(): Dynamic;
}