package dst.types;

/**
 * The names of StateGraph instances are always references
 * to lua filenames in the data/scripts/stategraphs/ directory
 * (e.g. "SGbee") so its important that you provide them consciously
 * as they are case-sensitive strings.
 */
typedef StateGraphInstanceName = String;
