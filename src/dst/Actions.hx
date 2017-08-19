package dst;

import haxe.Constraints.Function;

/**
 * data/scripts/actions.lua
 */
@:native("_G.ACTIONS")
@:enum
extern abstract ACTIONS(Action) // Externs
{
	var ABANDON;
	var ACTIVATE;
	var ADDFUEL;
	var ADDWETFUEL;
	var ATTACK;
	var ATTUNE;
	var BAIT;
	var BLINK;
	var BRUSH;
	var BUILD;
	var BUNDLE;
	var BUNDLESTORE;
	var CASTSPELL;
	var CATCH;
	var CATPLAYAIR;
	var CATPLAYGROUND;
	var CHANGEIN;
	var CHECKTRAP;
	var CHOP;
	var COMBINESTACK;
	var COOK;
	var CREATE;
	var DECORATEVASE;
	var DEPLOY;
	var DIG;
	var DISMOUNT;
	var DRAW;
	var DROP;
	var DRY;
	var EAT;
	var EQUIP;
	var EXTINGUISH;
	var FAN;
	var FEED;
	var FEEDPLAYER;
	var FERTILIZE;
	var FILL;
	var FISH;
	var GIVE;
	var GIVEALLTOPLAYER;
	var GIVETOPLAYER;
	var GOHOME;
	var HAIRBALL;
	var HAMMER;
	var HARVEST;
	var HAUNT;
	var HEAL;
	var INVESTIGATE;
	var JOIN;
	var JUMPIN;
	var LAYEGG;
	var LIGHT;
	var LOOKAT;
	var MAKEBALLOON;
	var MAKEMOLEHILL;
	var MANUALEXTINGUISH;
	var MIGRATE;
	var MINE;
	var MOLEPEEK;
	var MOUNT;
	var MURDER;
	var NET;
	var NUZZLE;
	// var OPEN_SHOP;
	var PET;
	var PICK;
	var PICKUP;
	var PLANT;
	var PLAY;
	var POLLINATE;
	var READ;
	var REEL;
	var REMOTERESURRECT;
	var REPAIR;
	var RESETMINE;
	var RUMMAGE;
	var SADDLE;
	var SEW;
	var SHAVE;
	var SLEEPIN;
	var SMOTHER;
	var STARTCHANNELING;
	var STEAL;
	var STEALMOLEBAIT;
	var STOPCHANNELING;
	var STORE;
	var SUMMONGUARDIAN;
	var TAKEITEM;
	var TALKTO;
	var TEACH;
	var TELEPORT;
	var TERRAFORM;
	var TOGGLE_DEPLOY_MODE;
	var TOSS;
	var TRAVEL;
	var TURNOFF;
	var TURNON;
	var UNEQUIP;
	var UNLOCK;
	var UNPIN;
	var UNSADDLE;
	var UNWRAP;
	var UPGRADE;
	var USEITEM;
	var USEKLAUSSACKKEY;
	var WALKTO;
	var WRAPBUNDLE;
	var WRITE;
}

@:native("_G")
extern class ActionExterns // Externs
{
	static public var ACTION_IDS: lua.Table<String, Action>;

	/**
	 * Filled by calls to ModUtil.AddAction().
	 */
	static public var ACTION_MOD_IDS: lua.Table<String, Action>;
}

@:native("_G.Action")
extern class Action extends ExplicitLuaClass
{
	@:selfCall
	public function new(data: {
		?priority: Int,
		?instant: Bool,
		?rmb: Bool,
		?distance: Float,
		?mindistance: Float,
		?ghost_exclusive: Bool,
		?ghost_valid: Bool,
		?mount_valid: Bool,
		?encumbered_valid: Bool,
		?canforce: Bool,
		?rangecheckfn: Function
	});

	/**
	 * Default: 0
	 */
	public var priority: Int;
	/**
	 * Default: no-op
	 */
	public var fn: ActionFunction;
	public var strfn: Null<ActionFunction>;
	public var instant: Bool;
	public var rmb: Null<Bool>;
	public var distance: Null<Float>;
	public var mindistance: Null<Float>;
	public var ghost_exclusive: Null<Bool>;
	public var ghost_valid: Null<Bool>;
	public var mount_valid: Null<Bool>;
	public var encumbered_valid: Null<Bool>;
	public var canforce: Null<Bool>;
	public var rangecheckfn: Null<RangeCheckFunction>;
	public var mod_name: Null<String>;
}

typedef ActionFunction = BufferedAction -> Void; // act
typedef RangeCheckFunction = EntityScript -> EntityScript; // doer, target