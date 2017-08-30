package utils;

import haxe.ds.Either;
using StringTools;

class Console
{
  inline public static var LOG_PREFIX = "Mod: ";

	/**
	 * If not null, return value of fn, else null.
	 * a.k.a. the "Elvis" operator ?:
	 */
	inline public static function inn<T,R>(v:T, fn:T->R):R
	{
		return (null == v) ? null : fn(v);
	}

	public static function serpent(v: Dynamic): Void
	{
		var serpent = lua.Lua.require('serpent');
		untyped __lua__("print(serpent.block({0}))", v);
	}

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
	 * Log message and return value.
	 * Provides optional truthy/falsy string replacement for %s in msg.
	 * Adds a little timer showing how long the value took to be provided.
	 * Helps when debugging long chains of boolean logic.
	 * @returns forwarded value always.
	 */
	public static function lit<T>(
		msg:String,
		value:OneOf<Void->T,T>,
		truthyRepl:OneOf<Dynamic->String,String>,
		falsyRepl:String,
		?expected:Dynamic,
		?pos:haxe.PosInfos
	):T
	{
		var _value:T;
		var deltaTime:Null<Float> = null;
		switch (value)
		{
			case Left(fn):
				// profiler
				var started = dst.MainFunctions.GetTime();
				_value = fn();
				var ended = dst.MainFunctions.GetTime();
				deltaTime = Std.int((ended - started) * 1000) / 1000; // milliseconds
			case Right(v):
				_value = v;
		}

		// ECMAScript-like Truthiness
		var isTruthy: Bool;
		switch (Type.typeof(_value))
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
			switch (truthyRepl)
			{
				case Left(fn): replacement = fn(_value);
				case Right(s): replacement = s;
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
	inline public static function lit<T>(msg:String, value:OneOf<Void->T,T>, truthyRepl:OneOf<Dynamic->String,String>, falsyRepl:String, ?expected:Dynamic):T {
		// pass-through
		switch (value)
		{
			case Left(fn):
				return fn();
			case Right(v):
				return v;
		}
	}

	#end
}



// see also: https://gist.github.com/mrcdk/d881f85d64379e4384b1
abstract OneOf<A, B>(Either<A, B>) from Either<A, B> {
  @:from inline static function fromA<A, B>(a:A) : OneOf<A, B> return Left(a);
  @:from inline static function fromB<A, B>(b:B) : OneOf<A, B> return Right(b);
}