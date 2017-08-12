package dst.components;

interface PlayerController
{
	public dynamic function GetActionButtonAction(self : Dynamic, force_target : Dynamic) : Dynamic;
	public function DoAction(act : BufferedAction) : Void;
	public var inst : IPlayerControllerInst;
	public var directwalking : Bool;
}

interface IPlayerControllerInst
{
	public var userid : Int;
	public var prefab : String;
}

interface IBufferedAction
{
	public var action : Dynamic;
}