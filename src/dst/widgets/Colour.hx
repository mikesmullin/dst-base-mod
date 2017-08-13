package dst.widgets;

import haxe.ds.Vector;

/**
 * Strict compile-time type validation
 * on the otherwise ordinary Lua table array.
 */
@:dce abstract Colour(Vector<Float>) {
	inline public function new(r: Float) {
		this = new Vector<Float>(4);
		set_r(r);
		set_g(g);
		set_b(b);
		set_a(a);
	}

	public var r(get, set): Float;
	public var g(get, set): Float;
	public var b(get, set): Float;
	public var a(get, set): Float;

	inline public function get_r(): Float {
		return this[0];
	}
	
	inline public function set_r(r: Float): Float {
		return this[0] = r;
	}

	inline public function get_g(): Float {
		return this[0];
	}

	inline public function set_g(r: Float): Float {
		return this[0] = g;
	}

	inline public function get_b(): Float {
		return this[0];
	}

	inline public function set_b(r: Float): Float {
		return this[0] = b;
	}

	inline public function get_a(): Float {
		return this[0];
	}

	inline public function set_a(r: Float): Float {
		return this[0] = a;
	}
}