package ;

class Utils
{
  public static inline var LOG_PREFIX = "MikesPlugin: ";
	public static inline function log(s : String)
	{
		#if debug
      // this special prefix appears highlighted
      // when viewed with LogExpert.exe
			trace(LOG_PREFIX + s);
		#end
	}
}
