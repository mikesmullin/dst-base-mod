package dst;

import haxe.Constraints.Function;
import dst.types.TagName;

/**
 * data/scripts/recipes.lua
 */
@:native("_G")
extern class RecipesExterns // Externs
{
	/**
	 * An index of all Recipe objects currently instantiated.
	 */
	static public var AllRecipes: lua.Table<String,Recipe>;

	static public var mod_protect_Recipe: Bool; // default: false

	static public function IsCharacterIngredient(type: String): Bool;
	static public function IsTechIngredient(type: String): Bool;
	static public function GetValidRecipe(name: String): Recipe;
	static public function IsRecipeValid(name: String): Bool;
}

/**
 * An ingredient.
 */
@:native("_G.Ingredient")
extern class Ingredient extends ExplicitLuaClass
{
	@:selfCall
	public function new(type: String, amount: Int, atlas: String, deconstruct: Dynamic);

	public var type: String;
	public var amount: Int;
	public var atlas: String;
	public var deconstruct: Dynamic;
}

/**
 * A recipe.
 */
@:native("_G.Recipe")
extern class Recipe extends ExplicitLuaClass
{
	/**
	 * Mods should not not instantiate Recipe directly.
	 * Use `components.builder:AddRecipe()` instead.
	 */
	@:deprecated
	@:selfCall
	public function new(name: String, ingredients: lua.Table<Int,Ingredient>, tab: Dynamic, level: Dynamic, placer: Dynamic, min_spacing: Dynamic, nounlock: Dynamic, numtogive: Dynamic, builder_tag: Dynamic, atlas: Dynamic, image: Dynamic, testfn: Dynamic);

	public var name: String;
	public var ingredients: lua.Table<Int,Ingredient>; // default: {}
	public var character_ingredients: {}; // default: {}
	public var tech_ingredients: {}; // default: {}

	public var product: String; // default: name
	public var tab: Dynamic;

	public var atlas: String;
	public var imagefn: Function;
	public var image: String;

	//publi var lockedatlas: String;
	//publi var lockedimage: String;

	public var sortkey: Int;
	public var rpc_id: Int;
	public var level: String;
	public var placer: Dynamic;
	public var min_spacing: Float; // default: 3.2

	/**
	 * Custom test function if default test isn't enough
	 */
	public var testfn: Function;

	public var nounlock: Bool; // default: false

	public var numtogive: Int; // default: 1

	public var builder_tag: TagName; // default: nil

	public function SetModRPCID(): Void;
}