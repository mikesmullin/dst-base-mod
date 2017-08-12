package ;

/**
 * Custom Haxe helpers to make life easier.
 */
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

/**
 * Similar to ECMAScript object, which is definitely an object
 * (not null, Int, or any other literal)
 * but could have any number of various keys and various types.
 */
class DynamicObject implements Dynamic {
}
