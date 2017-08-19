package dst.types;

/**
 * Platform-agnostic hash algorithm
 * produces these integers from any string.
 *
 * Used to minimize the amount of memory which would
 * be required to store the raw string value, when all
 * you need is relatively reliable value comparison,
 * not reading the string back out later.
 */
typedef Hash = Int;