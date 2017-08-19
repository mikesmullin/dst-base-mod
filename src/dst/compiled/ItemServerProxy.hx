package dst.compiled;

@:native("_G.ItemServerProxy")
extern class ItemServerProxy
{
	private function new();

	public function GetRecipes(): Dynamic;
	public function RedeemCode(): Dynamic;
	public function SwapItems(): Dynamic;
}