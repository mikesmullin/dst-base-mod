package dst;

/**
 * Use this type for compile-time checking.
 */
abstract STRING(String) {}

/**
 * Handy list of the characters in the game,
 * to aid pattern matching and exhaustiveness checking,
 * since they are used to look up data throughout the game.
 */
@:enum
abstract CharacterName(String)
{
	var wilson = "wilson";
	var willow = "willow";
	var wendy = "wendy";
	var wolfgang = "wolfgang";
	var woodie = "woodie";
	var wickerbottom = "wickerbottom";
	var wx78 = "wx78";
	var wes = "wes";
	var waxwell = "waxwell";
	var wathgrithr = "wathgrithr";
	var webber = "webber";
}

/**
 * data/scripts/strings.lua
 *
 * List of string values used for player-facing
 * and therefore localized text. Includes everything
 * from labels to character dialog.
 *
 * This file is essentially a flat-file database,
 * and as such is subject to change frequently between
 * releases. Therefore, we only include what is useful
 * for now, until perhaps its worth automatically importing
 * from Lua to Haxe in the future.
 */
@:native("_G.STRINGS")
extern class STRINGS
{

	static public var CHARACTER_NAMES:
	{
		wilson: STRING,
		willow: STRING,
		wendy: STRING,
		wolfgang: STRING,
		woodie: STRING,
		wickerbottom: STRING,
		wx78: STRING,
		wes: STRING,
		waxwell: STRING,
		wathgrithr: STRING,
		webber: STRING,
		unknown: STRING,
		random: STRING
	};

	static public var CHARACTER_QUOTES:
	{
		wilson: STRING,
		willow: STRING,
		woodie: STRING,
		wendy: STRING,
		wolfgang: STRING,
		wx78: STRING,
		wickerbottom: STRING,
		waxwell: STRING,
		wes: STRING,
		wathgrithr: STRING,
		webber: STRING,
		random: STRING
	};

	static public var CHARACTER_TITLES:
	{
		wilson: STRING,
		willow: STRING,
		wendy: STRING,
		woodie: STRING,
		wolfgang: STRING,
		wx78: STRING,
		wickerbottom: STRING,
		wes: STRING,
		waxwell: STRING,
		wathgrithr: STRING,
		webber: STRING,
		random: STRING
	}

	static public var CHARACTER_DESCRIPTIONS:
	{
		wilson: STRING,
		willow: STRING,
		wendy: STRING,
		wolfgang: STRING,
		wx78: STRING,
		wickerbottom: STRING,
		wes: STRING,
		waxwell: STRING,
		woodie: STRING,
		woodie_us: STRING,
		woodie_canada: STRING,
		wathgrithr: STRING,
		webber: STRING,
		random: STRING
	}

	/**
	 * Action strings;
	 * describe the action in localized words
	 * for the player to choose with.
	 */
	static public var ACTIONS: {
		TRAVEL: STRING,
		GNAW: STRING,
		READ: STRING,
		MAKEBALLOON: STRING,
		SEW: {
			GENERIC: STRING,
			PATCH: STRING,
		},
		GIVE: {
			GENERIC: STRING,
			NOTREADY: STRING,
			READY: STRING,
			SOCKET: STRING,
		},
		GIVETOPLAYER: STRING,
		GIVEALLTOPLAYER: STRING,
		FEEDPLAYER: STRING,
		DECORATEVASE: STRING,
		DROP: {
			GENERIC: STRING,
			SETTRAP: STRING,
			SETMINE: STRING,
			PLACELANTERN: STRING,
		},
		PICK: STRING,
		REPAIR: STRING,
		PICKUP: {
			GENERIC: STRING,
			HEAVY: STRING,
		},
		CHOP: STRING,
		FERTILIZE: STRING,
		SMOTHER: STRING,
		MANUALEXTINGUISH: STRING,
		EAT: STRING,
		BAIT: STRING,
		COOK: STRING,
		FILL: STRING,
		ADDFUEL: STRING,
		ADDWETFUEL: STRING,
		LIGHT: STRING,
		EXTINGUISH: STRING,
		LOOKAT: STRING,
		TALKTO: STRING,
		MINE: STRING,
		ATTACK: {
			GENERIC: STRING,
			SMASHABLE: STRING,
			RANGEDSMOTHER: STRING,
			RANGEDLIGHT: STRING,
			WHACK: STRING,
		},
		WALKTO: STRING,
		CHECKTRAP: STRING,
		BUILD: STRING,
		CRAFT: STRING,
		PLANT: {
			GENERIC: STRING,
			PLANTER: STRING,
		},
		HARVEST: STRING,
		GOHOME: STRING,
		DIG: STRING,
		SLEEPIN: STRING,
		CHANGEIN: {
			GENERIC: STRING,
			DRESSUP: STRING,
		},
		EQUIP: STRING,
		TERRAFORM: STRING,
		UNEQUIP: {
			GENERIC: STRING,
			HEAVY: STRING,
		},
		RESEARCH: STRING,
		SHAVE: {
			GENERIC: STRING,
			SELF: STRING,
		},
		DRY: STRING,
		STORE: {
			GENERIC: STRING,
			COOK: STRING,
			IMPRISON: STRING,
			DECORATE: STRING,
		},
		RUMMAGE: {
			GENERIC: STRING,
			CLOSE: STRING,
			DECORATE: STRING,
		},
		TOGGLE_DEPLOY_MODE: {
			GENERIC: STRING,
			GROUNDTILE: STRING,
			WALL: STRING,
			FENCE: STRING,
			GATE: STRING,
			TURRET: STRING,
		},
		DEPLOY: {
			GENERIC: STRING,
			GROUNDTILE: STRING,
			WALL: STRING,
			FENCE: STRING,
			GATE: STRING,
			TURRET: STRING,
		},
		PLAY: STRING,
		NET: STRING,
		CATCH: STRING,
		FISH: STRING,
		REEL: {
			GENERIC: STRING,
			REEL: STRING,
			CANCEL: STRING,
		},
		POLLINATE: STRING,
		HAMMER: STRING,
		RESETMINE: STRING,
		ACTIVATE: {
			GENERIC: STRING,
			INVESTIGATE: STRING,
			SPELUNK: STRING,
			CLIMB: STRING,
			ACCOMPLISH: STRING,
			TOUCH: STRING,
			OPEN: STRING,
			CLOSE: STRING,
		},
		JUMPIN: {
			GENERIC: STRING,
			HAUNT: STRING,
		},
		TELEPORT: {
			GENERIC: STRING,
			TOWNPORTAL: STRING,
		},
		MURDER: STRING,
		HEAL: {
			GENERIC: STRING,
			SELF: STRING,
		},
		UNLOCK: {
			GENERIC: STRING,
			LOCK: STRING,
		},
		USEKLAUSSACKKEY: STRING,
		TEACH: STRING,
		TURNON: STRING,
		TURNOFF: {
			GENERIC: STRING,
			EMERGENCY: STRING,
		},
		USEITEM: STRING,
		USEDOOR: {
			OPEN: STRING,
			CLOSE: STRING,
		},
		TAKEITEM: {
			GENERIC: STRING,
			BIRDCAGE: STRING,
		},
		CASTSPELL: {
			GENERIC: STRING,
			SCIENCE: STRING,
		},
		BLINK: STRING,
		COMBINESTACK: STRING,
		BURY: STRING,
		FEED: STRING,
		FAN: STRING,
		UPGRADE: STRING,
		HAUNT: STRING,
		UNPIN: STRING,
		TOSS: STRING,
		WRITE: STRING,
		ATTUNE: STRING,
		MIGRATE: STRING,
		REMOTERESURRECT: STRING,
		MOUNT: STRING,
		DISMOUNT: STRING,
		SADDLE: STRING,
		UNSADDLE: STRING,
		BRUSH: STRING,
		DANCE: STRING,
		ABANDON: STRING,
		PET: STRING,
		DRAW: STRING,
		DRAWITEM: STRING,
		BUNDLE: STRING,
		BUNDLESTORE: STRING,
		WRAPBUNDLE: STRING,
		UNWRAP: STRING,
		STARTCHANNELING: STRING,
		STOPCHANNELING: STRING
	};

	// TODO: finish this to the extent that it is useful.
}