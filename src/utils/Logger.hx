package utils;

class Logger
{
  public static inline var LOG_PREFIX = "MikesPlugin: ";
	public static function log(s:String, ?pos:haxe.PosInfos):Void
	{
		#if debug
      // this special prefix appears highlighted
      // when viewed with LogExpert.exe
			dst.DebugPrint.nolineprint(pos.fileName +":"+ pos.lineNumber +": "+ LOG_PREFIX + s);
		#end
	}
}