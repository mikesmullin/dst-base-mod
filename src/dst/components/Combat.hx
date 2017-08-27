package dst.components;

import dst.types.Component;

extern class Combat extends Component
{
	public function GetWeapon(): EntityScript;

	/**
	 * Getter and setter is valid on server side.
	 */
	public var min_attack_period: Int; // default 4;
}