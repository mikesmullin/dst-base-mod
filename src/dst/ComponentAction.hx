package dst;

/**
 * data/scripts/componentactions.lua
 */
@:native("_G")
extern class ComponentAction
{
	public function AddComponentAction(actiontype: Dynamic, component: Dynamic, fn: Dynamic, modname: Dynamic): Void;
}