package dst;

@:native("_G.BufferedAction")
extern class BufferedAction extends ExplicitLuaClass
{
	@:selfCall
	public function new(doer: Dynamic, target: Dynamic, action: Dynamic,
		invobject: Dynamic, pos: Dynamic, recipe: Dynamic, 
		distance: Dynamic, forced: Dynamic, rotation: Dynamic);
}