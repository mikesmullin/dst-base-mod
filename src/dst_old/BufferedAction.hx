package dst;

@:native("GLOBAL")
extern class BufferedAction 
{
	@:native("BufferedAction")
	static public function factory(
		doer : Dynamic, target : Dynamic, action : Dynamic, ? invobject : Dynamic, 
		? pos : Dynamic, ? recipe : Dynamic, ? distance : Dynamic, ? forced : Dynamic, 
		? rotation : Dynamic) : BufferedAction ;
	
	public function new(
		doer : Dynamic, target : Dynamic, action : Dynamic, ? invobject : Dynamic, 
		? pos : Dynamic, ? recipe : Dynamic, ? distance : Dynamic, ? forced : Dynamic, 
		? rotation : Dynamic);
		
	public var action : IAction;
	
	public dynamic function preview_cb() : Void;
	
}

typedef IAction =
{
	var code : Dynamic;
}