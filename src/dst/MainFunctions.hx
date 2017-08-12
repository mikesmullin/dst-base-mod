package dst;

import dst.CompiledEngine.Entity;

@:native("_G")
extern class MainFunctions
{
	static public function CreateEntity(): Entity;
}