package dst.components;

import dst.types.ReplicaComponent;

extern class HealthReplica extends ReplicaComponent
{
	public function IsDead(): Bool;
}