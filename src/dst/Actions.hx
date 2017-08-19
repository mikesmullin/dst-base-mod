package dst;

import haxe.Constraints.Function;

/**
 * data/scripts/actions.lua
 */
@:native("_G.ACTIONS")
extern class ACTIONS // Externs
{
	static public var ABANDON: Action;
	static public var ACTIVATE: Action;
	static public var ADDFUEL: Action;
	static public var ADDWETFUEL: Action;
	static public var ATTACK: Action;
	static public var ATTUNE: Action;
	static public var BAIT: Action;
	static public var BLINK: Action;
	static public var BRUSH: Action;
	static public var BUILD: Action;
	static public var BUNDLE: Action;
	static public var BUNDLESTORE: Action;
	static public var CASTSPELL: Action;
	static public var CATCH: Action;
	static public var CATPLAYAIR: Action;
	static public var CATPLAYGROUND: Action;
	static public var CHANGEIN: Action;
	static public var CHECKTRAP: Action;
	static public var CHOP: Action;
	static public var COMBINESTACK: Action;
	static public var COOK: Action;
	static public var CREATE: Action;
	static public var DECORATEVASE: Action;
	static public var DEPLOY: Action;
	static public var DIG: Action;
	static public var DISMOUNT: Action;
	static public var DRAW: Action;
	static public var DROP: Action;
	static public var DRY: Action;
	static public var EAT: Action;
	static public var EQUIP: Action;
	static public var EXTINGUISH: Action;
	static public var FAN: Action;
	static public var FEED: Action;
	static public var FEEDPLAYER: Action;
	static public var FERTILIZE: Action;
	static public var FILL: Action;
	static public var FISH: Action;
	static public var GIVE: Action;
	static public var GIVEALLTOPLAYER: Action;
	static public var GIVETOPLAYER: Action;
	static public var GOHOME: Action;
	static public var HAIRBALL: Action;
	static public var HAMMER: Action;
	static public var HARVEST: Action;
	static public var HAUNT: Action;
	static public var HEAL: Action;
	static public var INVESTIGATE: Action;
	static public var JOIN: Action;
	static public var JUMPIN: Action;
	static public var LAYEGG: Action;
	static public var LIGHT: Action;
	static public var LOOKAT: Action;
	static public var MAKEBALLOON: Action;
	static public var MAKEMOLEHILL: Action;
	static public var MANUALEXTINGUISH: Action;
	static public var MIGRATE: Action;
	static public var MINE: Action;
	static public var MOLEPEEK: Action;
	static public var MOUNT: Action;
	static public var MURDER: Action;
	static public var NET: Action;
	static public var NUZZLE: Action;
	// static public var OPEN_SHOP: Action;
	static public var PET: Action;
	static public var PICK: Action;
	static public var PICKUP: Action;
	static public var PLANT: Action;
	static public var PLAY: Action;
	static public var POLLINATE: Action;
	static public var READ: Action;
	static public var REEL: Action;
	static public var REMOTERESURRECT: Action;
	static public var REPAIR: Action;
	static public var RESETMINE: Action;
	static public var RUMMAGE: Action;
	static public var SADDLE: Action;
	static public var SEW: Action;
	static public var SHAVE: Action;
	static public var SLEEPIN: Action;
	static public var SMOTHER: Action;
	static public var STARTCHANNELING: Action;
	static public var STEAL: Action;
	static public var STEALMOLEBAIT: Action;
	static public var STOPCHANNELING: Action;
	static public var STORE: Action;
	static public var SUMMONGUARDIAN: Action;
	static public var TAKEITEM: Action;
	static public var TALKTO: Action;
	static public var TEACH: Action;
	static public var TELEPORT: Action;
	static public var TERRAFORM: Action;
	static public var TOGGLE_DEPLOY_MODE: Action;
	static public var TOSS: Action;
	static public var TRAVEL: Action;
	static public var TURNOFF: Action;
	static public var TURNON: Action;
	static public var UNEQUIP: Action;
	static public var UNLOCK: Action;
	static public var UNPIN: Action;
	static public var UNSADDLE: Action;
	static public var UNWRAP: Action;
	static public var UPGRADE: Action;
	static public var USEITEM: Action;
	static public var USEKLAUSSACKKEY: Action;
	static public var WALKTO: Action;
	static public var WRAPBUNDLE: Action;
	static public var WRITE: Action;
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