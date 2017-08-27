package dst.types;

/**
 * Replica components container with overridden accessor.
 */
extern class ReplicaComponent extends ExplicitLuaClass
{
	@:selfCall
	public function new (inst: EntityScript);

	public var inst: EntityScript;

	public var classified: EntityScript;

	/**
	 * This holds all the override values.
	 */
	public var _: {};
}

