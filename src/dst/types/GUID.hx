package dst.types;

/**
 * Global Unique Identifier (GUID)
 *
 * A platform-agnostic way to reference a single
 * Entity instance managed by the compiled binary
 * at runtime.
 *
 * Used frequently to identify the same object
 * across networked server and clients, or between
 * Lua memory and compiled memory.
 */
abstract GUID(Int){}