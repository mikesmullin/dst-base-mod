package utils;

import haxe.ds.Either;
using StringTools;

class Console
{
  inline public static var LOG_PREFIX = "Mod: ";

	#if debug

	public static function println(s:String):Void
	{
		dst.DebugPrint.nolineprint(s);
	}

	public static function log(s:String, ?pos:haxe.PosInfos):Void
	{
		println(pos.fileName +":"+ pos.lineNumber +": "+ LOG_PREFIX + s);
	}

	public static function trace(s:String, ?pos:haxe.PosInfos):Void
	{
		log(s, pos);
		println(dst.DebugTools.debugstack());
	}

	/**
	 * If not null, return value of fn, else null.
	 * a.k.a. the "Elvis" operator ?:
	 */
	inline public static function inn<T,R>(v:T, fn:T->R):R
	{
		return (null == v) ? null : fn(v);
	}


	/**
	 * Log message and return value.
	 * Provides optional truthy/falsy string replacement for %s in msg.
	 * Adds a little timer showing how long the value took to be provided.
	 * Helps when debugging long chains of boolean logic.
	 * @returns forwarded value always.
	 */
	public static function lit<T>(
		msg:String,
		?valueProfileFn:Void->T,
		?value:T,
		?truthyReplFn:T->String,
		?truthyRepl:String,
		?falsyRepl:String,
		?expected:Dynamic,
		?pos:haxe.PosInfos
	):T
	{
		var _value:T = null;
		var deltaTime:Null<Float> = null;
		if (null != valueProfileFn)
		{
				// profiler
				var started = dst.MainFunctions.GetTime();
				_value = valueProfileFn();
				var ended = dst.MainFunctions.GetTime();
				deltaTime = Std.int((ended - started) * 1000) / 1000; // milliseconds
		}
		else
		{
				_value = value;
		}

		// ECMAScript-like Truthiness
		var isTruthy: Bool;
		switch (Type.typeof(value))
		{
			case TNull:
				isTruthy = false;
			case TInt, TFloat:
				isTruthy = 0 != (cast _value:Int);
			case TBool:
				isTruthy = (cast _value:Bool);
			case TObject, TFunction, TClass(_), TEnum(_), TUnknown:
				isTruthy = null != _value;
		}

		// either expected is non-null and value equals expected, or value is truthy
		isTruthy = (null != expected && _value == expected) || (null == expected && isTruthy);		

		var replacement:String = "";
		if (isTruthy)
		{
			if (null != truthyReplFn)
			{
				replacement = truthyReplFn(_value);
			}
			else if (null != truthyRepl)
			{
				replacement = truthyRepl;
			}
		}
		else {
			if (null != falsyRepl)
			{
				replacement = falsyRepl;
			}
		}

		log(
			msg.replace("%s", replacement)
			+ (null == deltaTime ? "" : " ("+ deltaTime +"ms)"), 
			pos);

		return _value;
	}

	#else

	inline public static function println(s:String):Void {}
	inline public static function log(s:String, ?pos:haxe.PosInfos):Void {}
	inline public static function trace(s:String, ?pos:haxe.PosInfos):Void {}
	inline public static function public static function lit<T>(msg:String, valueFn:Void->T, ?truthyRepl:String, ?falsyRepl:String, ?expected:Dynamic):T {
		return valueFn(); // pass-through
	}

	#end
}



// see also: https://gist.github.com/mrcdk/d881f85d64379e4384b1
abstract OneOf<A, B>(Either<A, B>) from Either<A, B> to Either<A, B> {
  @:from inline static function fromA<A, B>(a:A) : OneOf<A, B> return Left(a);
  @:from inline static function fromB<A, B>(b:B) : OneOf<A, B> return Right(b);
    
  @:to inline function toA():Null<A> return switch(this) {case Left(a): a; default: null;}
  @:to inline function toB():Null<B> return switch(this) {case Right(b): b; default: null;}
}