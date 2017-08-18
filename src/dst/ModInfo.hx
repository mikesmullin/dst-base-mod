package dst;

/**
 * Describes values used by modinfo.lua
 */
interface ModInfo
{
	var name: String;
	var description: String;
	var author: String;
	var version: String;
	var dont_starve_compatible: Bool;
	var dst_compatible: Bool;

	var icon_atlas: String; // ie. "preview.xml"
	var icon: String; // ie. "preview.tex"
	
	var ?reign_of_giants_compatible: Bool;

	var all_clients_require_mod: Bool;
	var client_only_mod: Bool;

	var ?configuration_options: Utils.DynamicObject;
	var ?version_compatible: String;
	var ?forumthread: String;
	var ?api_version: Int; // ie. 10
	var ?game_modes: Array<{label:String,name:String}>;
	var ?server_filter_tags: Array<String>;
	var ?priority: Int; // default: 0
	var ?standalone: Bool;
}