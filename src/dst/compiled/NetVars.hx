package dst.compiled;

import haxe.io.Bytes;
import dst.CompiledEngine.GUID;
import dst.CompiledEngine.Hash;
import dst.CompiledEngine.Entity;

/**
 * Netvars (Network Variables)
 *
 * A collection of classes representing platform-agnostic data types;
 * streamed change events synchronize their values over a networked machine cluster.
 *
 * All network variable types extend this base class.
 *
 *
 * Client / Server Simulation Relationship
 *
 * Mods should use always guard which side they want code to run on;
 * by default all Lua code runs on BOTH client and server side,
 * and this can be very wasteful!
 *
 * Definitions:
 *
 * - client host: DST > Play > Host Game > Generate/Resume World
 * - remote client: DST > Play > Browse Games > Join
 * - dedicated: Steam > Tools > Dont Starve Together Dedicated Server
 * 
 * |                      | client host | remote client | dedicated |
 * |----------------------|-------------|---------------|-----------|
 * | TheWorld.ismastersim |    true     |     false     |   true    |
 * | TheNet.GetIsServer() |    true     |     false     |   true    |
 * | TheNet.IsDedicated() |    false    |     false     |   true    |
 * | TheNet.GetIsClient() |    false    |     true      |   false   |
 * 
 * `TheWorld.ismastersim` == `TheNet:GetIsServer()` // this is running on a computer hosting the game
 * `not TheWorld.ismastersim` == `TheNet:GetIsClient()` // this is running on a computer joining a game
 * `TheNet:IsDedicated()` // this is a headless dedicated server
 * 
 * NOTICE client host means client and server share a single simulator;
 *        evaluating one instance of the logic for both client and server.
 *
 * The intended use case for netvars is to be exclusively `:set()` by the server,
 * while `:value()` is read by the client(s). Although `:set_local()` can be used by
 * any side, its most useful on the client-side for network lag interpolation 
 * between `:set()` values and subsequent dirty events.
 * 
 * The interface for dirty event listeners is `f(e:Entity):Void`.
 *
 * Netvars must be defined on both sending and receiving sides before 
 * changing values will cause a sync or dirty event.
 *
 * fig. 1: `Entity:ListenForEvent()` will trigger
 * | if listening from... | and `:set()` on...                       |
 * |                      | client host | remote client | dedicated  |
 * |----------------------|-------------|---------------|------------|
 * |          client host |    true     |     false     |     -      |
 * |        remote client |    true     |     false     |   true     |
 * |            dedicated |      -      |     false     |   true     |
 *
 * fig. 2: `NetVar:set()` will always change local `NetVar:value()`,
 * but it will only sync
 * | `:value()` of...     | if `:set()` on...                        |
 * |                      | client host | remote client | dedicated  |
 * |----------------------|-------------|---------------|------------|
 * |          client host |    true     |    false      |     -      |
 * |        remote client |    true     |    false      |   true     |
 * |            dedicated |      -      |    false      |   true     |
 *
 * Its not an error to `:set()`, or `:set_local()` from the client, but realize it
 * only changes it for that one local client instance. If you do it mistakenly,
 * you will find the `:value()` is not the same on the server or other clients.
 *
 * If you bind a new netvar to an Entity GUID that only exists on the client,
 * or an Entity that does not have an `:AddNetwork()` component attached to it,
 * it will NOT sync or trigger, neither locally or remotely.
 *
 * Binding a netvar to an Entity GUID that different on the client side
 * will cause a hard crash on the client.
 *
 * Network protocol is an un-encrypted implementation of RakNet mainly udp/10999
 * http://raknet.com/raknet/manual/
 */
private extern class NetVar<T>
{
	/**
	 * Register event handler for network variable of a given name.
	 *
	 * See set() for more details.
	 *
	 * @param guid - Entity GUID.
	 * @param name - Network variable name. Must be unique per entity.
	 * @param dirtyEventName - Can be bound by `Entity:ListenForEvent()`.
	 */
	@:selfCall
	public function new(guid:GUID, name:String, ?dirtyCb:String);

	/**
	 * Unidirectional setter;
	 * - Sets new value locally
	 * - Triggers dirty event listeners (see fig. 1 above)
	 * - Syncs new value from server to client(s) (see fig. 2 above)
	 *
	 * Will no-op unless one of the following is true:
	 *
	 * - given value is different than last value, or;
	 * - `set_local()` used one or more times since last `set()`.
	 */
	public function set(value:T):Void;

	/**
	 * Local-only setter;
	 * Does NOT notify the cluster or trigger dirty event listeners.
	 *
	 * Recommended for frame-rate-dependant interpolation.
	 * (e.g. client makes guesses locally until corrected by the server)
	 */
	public function set_local(value:T):Void;

	/**
	 * Local-only getter;
	 * Return last value received by network sync, :set(), or :set_local().
	 */
	public function value():T;
}

/**
 * 1-bit boolean
 *
 * Default: false
 *
 * e.g., set_local(true); set(true); can be used on net_bool
 *   to transmit event notifications without having to
 *   toggle true on/off between each event.
 */
@:native("_G.net_bool")
extern class NetBool extends NetVar<Bool>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 8-bit unsigned integer   [0..255]
 */
@:native("_G.net_byte")
extern class NetByte extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * array of 8-bit unsigned integers (max size = 31)
 *
 * Arrays are expensive; avoid if you will dirty them often.
 */
@:native("_G.net_bytearray")
extern class NetByteArray extends NetVar<Bytes>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * unsigned 64-bit integer containing entity network id
 * represents the entity instance
 */
@:native("_G.net_entity")
extern class NetEntity extends NetVar<Entity>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 32-bit float
 */
@:native("_G.net_float")
extern class NetFloat extends NetVar<Float>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 32-bit unsigned integer
 *
 * If value is a number, it is forwarded as the hash.
 * If value is a string, it is converted to a hash before sending.
 *
 * REMINDER: The hash algorithm is deterministic, so expect
 *   clients to agree on output value regardless of platform.
 */
@:native("_G.net_hash")
extern class NetHash extends NetVar<Hash>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 32-bit signed integer    [-2147483647..2147483647]
 */
@:native("_G.net_int")
extern class NetInt extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 16-bit signed integer    [-32767..32767]
 */
@:native("_G.net_shortint")
extern class NetShortInt extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * Maps to an unsigned 32-bit integer.
 */
@:native("_G.net_uint")
extern class NetUInt extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 16-bit unsigned integer  [0..65535]
 */
@:native("_G.net_ushortint")
extern class NetUShortInt extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 3-bit unsigned integer   [0..7]
 */
@:native("_G.net_tinybyte")
extern class NetTinyByte extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * 6-bit unsigned integer   [0..63]
 */
@:native("_G.net_smallbyte")
extern class NetSmallByte extends NetVar<Int>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * array of 6-bit unsigned integers (max size = 31)
 *
 * Arrays are expensive; avoid if you will dirty them often.
 */
@:native("_G.net_smallbytearray")
extern class NetSmallByteArray extends NetVar<Bytes>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * variable length string
 */
@:native("_G.net_string")
extern class NetString extends NetVar<String>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);
}

/**
 * A convenience wrapper over net_bool.
 * does the set_local(true) set(true) trick for you.
 *
 * Use for one-shot triggers.
 */
@:native("_G.net_event")
extern class NetEvent extends NetVar<String>
{
	@:selfCall public function new(guid:GUID, name:String, ?dirtyCb:String);

	/**
	 * Remote trigger.
	 *
	 * Like set() but no value is required.
	 */
	public function push(): Void;
}