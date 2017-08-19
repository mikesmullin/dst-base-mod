package dst.compiled;

@:native("_G.ShardProxy")
extern class ShardProxy {
	public function GetDefaultShardEnabled(): Dynamic;
	public function GetShardId(): Dynamic;
	public function GetSlavePlayerCounts(): Dynamic;
	public function IsMaster(): Dynamic;
	public function IsMigrating(): Dynamic;
	public function IsPlayer(): Dynamic;
	public function IsSlave(): Dynamic;
	public function SetSlaveLoading(): Dynamic;
	public function StartMigration(): Dynamic;
}