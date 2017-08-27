package dst.components;

import dst.types.ReplicaComponent;

extern class InventoryReplica extends ReplicaComponent
{
	public function IsHeavyLifting():Bool;

	public function GetEquippedItem(eslot: dst.Constants.EQUIPSLOTS): EntityScript;
}