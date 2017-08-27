package dst;

import haxe.extern.EitherType;

/**
 * data/scripts/vector3.lua
 *
 * Provides a commonly used interface in 3D games
 * to a 3-float vector data structure with
 * equally common geometric math helper functions.
 *
 * Used alot throught most parts of game code.
 */
@:native("_G.Vector3")
extern class Vector3 extends ExplicitLuaClass
{
	@:selfCall
	public function new(x: Float, y: Float, z: Float);

	public var x: Float;
	public var y: Float;
	public var z: Float;

	/**
	 * @returns new vector of current plus (+) given
	 */
	public function __add(v: Vector3): Vector3;

	/**
	 * @returns new vector of current minus (-) given
	 */
	public function __sub(v: Vector3): Vector3;

	/**
	 * @returns new vector multiple (*) of current and given
	 */
	public function __mul(v: Vector3): Vector3;

	/**
	 * @returns new vector division (/) of current by given
	 */
	public function __div(v: Vector3): Vector3;

	/**
	 * @returns new vector dot product of current and given
	 */
	public function Dot(v: Vector3): Float;

	/**
	 * @returns new vector cross product of current and given
	 */
	public function Cross(v: Vector3): Vector3;

	/**
	 * @returns whether given and current hold the same values
	 */
	public function __eq(v: Vector3): Bool;

	/**
	 * @returns distance squared between current and given
	 */
	public function DistSq(other: Vector3): Float;

	/**
	 * @returns distance between current and given
	 */
	public function Dist(other: Vector3): Float;

	/**
	 * @returns length squared between current and given
	 */
	public function LengthSq(): Float;

	/**
	 * @returns length between current and given
	 */
	public function Length(): Float;

	/**
	 * Normalize the current vector and return it.
	 */
	public function Normalize(): Vector3;

	/**
	 * @return copy of vector, normalized,
	 *   without modification to this one.
	 */
	public function GetNormalized(): Float;

	/**
	 * @return Tuple3 of x, y, and z.
	 */
	public function Get(): Vector3Tuple;

	/**
	 * Whether this class is a Vector3 type.
	 * Used by other [non-strongly-typed] Lua code
	 * as a kind of Reflection.
	 * @return true, always.
	 */
	public function IsVector3(): Bool;

	/**
	 * Factory method generates new Vector3 instances
	 * from either a non-vector Array<Int>(3), or
	 * a series of 3 Float arguments.
	 */
	static public function ToVector3(obj: EitherType<Float,Array<Int>>, y: Float, z: Float): Vector3;

	/**
	 * Serialize this object to console-friendly string.
	 */
	override public function __tostring(): String;
}

@:native("_G.Point")
typedef Point = Vector3;

@:multiReturn
extern class Vector3Tuple {
	var x: Float;
	var y: Float;
	var z: Float;
}
