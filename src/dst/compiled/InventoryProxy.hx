package dst.compiled;

@:native("_G.InventoryProxy")
extern class InventoryProxy
{
	public function CheckClientOwnership(): Dynamic;
	public function CheckOwnership(): Dynamic;
	public function CheckOwnershipGetLatest(): Dynamic;
	public function GetClientGiftCount(): Dynamic;
	public function GetFullInventory(): Dynamic;
	public function GetUnopenedEntitlementItems(): Dynamic;
	public function GetUnopenedItems(): Dynamic;
	public function HasDownloadedInventory(): Dynamic;
	public function IsDownloadingInventory(): Dynamic;
	public function SetItemOpened(): Dynamic;
}