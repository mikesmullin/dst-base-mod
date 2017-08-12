package dst;

interface IAllRecipes
{
	public var abigail_flower : IRecipe;
}

interface IRecipeIngredient 
{
	public var amount: Int;
	public var atlas: String;
	public var type: String;
}

interface IRecipeLevel
{
	public var ANCIENT: Int;
	public var CARTOGRAPHY: Int;
	public var MAGIC: Int;
	public var ORPHANAGE: Int;
	public var PERDOFFERING: Int;
	public var SCIENCE: Int;
	public var SCULPTING: Int;
	public var SHADOW: Int;
}

interface IRecipeTab 
{
	public var icon : String;
	public var sort : Int;
	public var str : String;
}

interface IRecipe 
{
	public var atlas : String;
	public var builder_tag : String;
	public var character_ingredients : Dynamic;
	public var image : String;
	public var ingredients : Array<IRecipeIngredient>; 
	public var level : IRecipeLevel;
	public var min_spacing : Float;
	public var name	 : String;
	public var nounlock : Bool;
	public var numtogive : Int;
	public var product : String;
	public var rpc_id : Int;
	public var sortkey : Int;
	public var tab : IRecipeTab;
	public var tech_ingredients	: Dynamic;
}