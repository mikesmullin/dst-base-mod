package dst.compiled;

@:native("_G.TextEditWidget")
extern class TextEditWidget
{
	private function new();

	public function EnableScrollEditWindow(): Dynamic;
	public function GetString(): Dynamic;
	public function OnKeyDown(): Dynamic;
	public function OnKeyUp(): Dynamic;
	public function OnTextInput(): Dynamic;
	public function SetForceUpperCase(): Dynamic;
	public function SetPassword(): Dynamic;
	public function SetString(): Dynamic;
}