package dst.types;

/**
 * Components are ordinary Class types.
 *
 * Every Prefab consists of components.
 * Components define what can be done.
 * You will see components called "workable" or "pickable".
 * If a Prefab is pickable, i.e. a flower, it will define
 * a “pickable” component in it's setup method.
 * Components often have callback functions, i.e. "SetOnPickedFn".
 * These need to be set by the prefab when they initialize themselves.
 */
typedef Component = ExplicitLuaClass;