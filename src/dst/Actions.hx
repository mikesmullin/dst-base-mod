package dst;

import haxe.Constraints.Function;
import dst.Strings.STRING;

/**
 * data/scripts/actions.lua
 *
 * Defines an [inter]action usable by entities.
 *
 * Not only a kind of global enum, but
 * also defines a global function implementation
 * that could generally apply to any entity;
 * deferring to invoking callbacks on the entity
 * for anything parts that might vary or be too specific.
 * Entities expecting compatibility with this action
 * therefore are obligated to either implement said callbacks
 * or attach a Component or StateGraph that does.
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
	 * The name of this action.
	 * Same as the key name in the ACTIONS table.
	 * (e.g., ACTIONS.EAT.id == "EAT")
	 * Defined automatically by a for...loop in data/scripts/actions.lua.
	 */
	public var id(get,never): String;

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
	 * Every action that can be chosen needs a 1-3 word label
	 * which the player sees when performing that action is an option.
	 * (e.g, When the player is holding a hambat, and the mouse is
	 * over a mole, the label displayed above the mole is "Attack".
	 * But when the player is holding a hammer, then the label changes
	 * to "Whack", signifying that a different action used to capture
	 * the mole alive is available.)
	 *
	 * In the above example, the same action has different labels in
	 * different scenarios, which is why this field is a function.
	 *
	 * These string names are defined by data/scripts/strings.lua,
	 * and are also localized, so you should provide the string constant
	 * name here, not a literal string value, and it should be one that
	 * is already defined and localized.
	 *
	 * This is optional because its not the only way to specify an
	 * action label. The first and most authoritative definition is
	 * the Action.id string, and strfn is only used in the event
	 * that key does not exist in the STRINGS table.

	 * The BufferedAction.doer can also implement
	 * `EntityScript.ActionStringOverride(:BufferedAction):String`
	 * which is used to override a strfn definition. (ie. Currently only
	 * used by Woodie's character to convert ACTIONS.EAT into ACTIONS.GNAW)
	 *
	 * Default: null
	 */
	@:optional
	public var strfn: Null<ActionStringFunction>;

	/**
	 * Same as strfn, but only used by ACTIONS.DRAW.
	 * Don't use this. Use .strfn instead.
	 * Default: null
	 */
	@:optional
	@:deprecated
	public var stroverridefn: BufferedAction -> String;


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
typedef ActionStringFunction = BufferedAction -> STRING; // act
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