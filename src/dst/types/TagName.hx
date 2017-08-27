package dst.types;

/**
 * Tags are a simple system for making Prefab interactions flexible.
 *
 * For instance, let’s assume we're making a spooky ghost.
 * We can give it related tags like "ghost", "shadow", "scarytoprey".
 * On their own, those tags don’t do anything. But critters like 
 * rabbits check for the “scarytoprey” tag and get spooked by it.
 *
 * You will often see tags to indicate certain things for certain
 * components or creatures (e.g. Chester’s Eyebone), but also for
 * general differences (e.g. “wall”, “fire”).
 *
 * The names of tags are always references to indexes
 * so its important that you provide them consciously
 * as they are case-sensitive strings.
 */
abstract TagName(String){}