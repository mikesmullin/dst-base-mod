package dst.components;

import dst.types.Component;

extern class FollowerReplica extends Component
{
	public function GetLeader(): EntityScript;
}