package dst;

/**
 * data/scripts/input.lua
 */
@:native("_G")
extern class InputExterns { // Externs
}

/**
 * Don't reference this directly.
 * Use Main.TheInput instead.
 */
extern class Input extends EntityScript
{
	public function GetWorldEntityUnderMouse(): EntityScript;
	
	// TODO: finish
}