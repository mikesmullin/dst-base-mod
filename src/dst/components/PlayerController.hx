package dst.components;

import dst.types.Component;

extern class PlayerController extends Component
{
	public var inst: EntityScript; // player instance

	public var directwalking: Bool;

	/**
	 * Searches combatable entities within reach and returns nearest-distance valid match.
	 */
	dynamic public function GetAttackTarget(force_attack:Bool, force_target:EntityScript, isretarget:Bool): EntityScript;
}