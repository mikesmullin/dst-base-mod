package utils;

import lua.Table;

typedef Pair<K,V> = {
	index: K,
	value: V
};

class Lua
{
	// NOTICE: technically you could iterate with ipairs on a non-Int key but so rare
	// the strong typing and implicit assumption is more helpful
	// make your own iterator if you enjoy making life hard
	public static function ipairs<V>(table:Table<Int,V>): Iterator<Pair<Int,V>>
	{
		var i:Int = 1;
		return {
			next: function(): Pair<Int,V>
			{
				return { index: i, value: table[i++] };
			},
			/**
			 * NOTICE: This defintion means null values found in the
			 * table array will be considered the end of the array range.
			 */
			hasNext: function(): Bool
			{
				return null != table[i];
			}
		};
	}
}