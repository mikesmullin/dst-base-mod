package dst.types;

/**
 * Components belong to prefabs.
 * You will see components called "workable" or "pickable".
 * If a Prefab is pickable, i.e. a flower, it will define
 * a “pickable” component in it's setup method.
 * 
 * Components often have callback functions, i.e. "SetOnPickedFn".
 * These need to be set by the prefab when they initialize themselves.
 *
 * Components are ExplicitLuaClass types; there is no unifying interface
 * or parent type; which means implementation are inconsistent. Therefore
 * we recommend looking for usage examples in existing code before assuming
 * you know how to use it from the component class definition alone.
 */
extern class Component extends ExplicitLuaClass
{

}