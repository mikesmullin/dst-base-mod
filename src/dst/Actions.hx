package dst;

import haxe.Constraints.Function;

/**
 * data/scripts/actions.lua
 *
 * Defines an [inter]action usable by entities.
 *
 * Used heavily throughout the game.
 */
@:native("_G.Action")
extern class Action extends ExplicitLuaClass
{
	/**
	 * Define a new Action.
	 */
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
	 * Whether this action should take precedence
	 * when racing other enqueued actions.
	 * Default: 0
	 */
	public var priority: Int;

	/**
	 * The primary function responsible for performing
	 * the work this action enumeration represents.
	 *
	 * There is only room for one of these functions but you
	 * can still chain them by keeping a reference to the old
	 * function before overriding it, and then calling the
	 * old function as if it were `super()`.
	 *
	 * Default: no-op
	 * @return Whether action completed successfully.
	 */
	public var fn: ActionFunction;

	/**
	 * External validation function responsible for determining
	 * if now is an acceptable time to perform this action
	 * using a custom, often very specific, set of checks.
	 *
	 * There is only room for one of these functions but you
	 * can still chain them by keeping a reference to the old
	 * function before overriding it, and then calling the
	 * old function as if it were `super()`.
	 *
	 * Default: null
	 * @return Whether action should be performed now.
	 */
	public var strfn: Null<ActionFunction>;

	/**
	 * Whether action must wait for server acknowledgement.
	 * Default: false
	 */
	public var instant: Bool;

	/**
	 * Whether player right mouse button input was down
	 * when this action was created.
	 * Useful during tool interactions.
	 * Default: null
	 */
	public var rmb: Null<Bool>;

	/**
	 * Minimum distance for `:rangecheckfn()`.
	 * Default: null
	 */
	public var distance: Null<Float>;

	/**
	 * Maximum distance for `:rangecheckfn()`.
	 * Default: null
	 */
	public var mindistance: Null<Float>;

	/**
	 * Whether within range for action.
	 * Most pre-defined actions provide `Actions.DefaultRangeCheck()`,
	 * but that is private, so make a copy if you need it.
	 * Default: null
	 */
	public var rangecheckfn: Null<RangeCheckFunction>;

	/**
	 * Whether only ghosts may perform this action.
	 * Default: false
	 */
	public var ghost_exclusive: Bool;

	/**
	 * Whether ghosts are denied this action.
	 * Default: null
	 */
	public var ghost_valid: Bool;

	/**
	 * Whether actionable while entity is mounted or mounting.
	 * Default: false
	 */
	public var mount_valid: Bool;

	/**
	 * Whether actionable while carrying heavy objects.
	 * Default: false
	 */
	public var encumbered_valid: Bool;

	/**
	 * Default: false
	 */
	public var canforce: Null<Bool>;

	/**
	 * Which mod defines this action.
	 * Most actions are not defined by any mod.
	 * Default: null
	 */
	public var mod_name: Null<String>;
}

typedef ActionFunction = BufferedAction -> Bool; // act
typedef RangeCheckFunction = EntityScript -> EntityScript; // doer, target

/**
 * Set of common actions entities may perform.
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
	static private function DefaultRangeCheck(doer: EntityScript, target: EntityScript): Bool;

	static public var ACTION_IDS: lua.Table<String, Action>;

	/**
	 * Filled by calls to ModUtil.AddAction().
	 */
	static public var ACTION_MOD_IDS: lua.Table<String, Action>;
}