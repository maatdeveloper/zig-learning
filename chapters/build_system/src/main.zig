const std = @import("std");

pub fn main(init: std.process.Init) !void {
    // Prints to stderr, unbuffered, ignoring potential errors.
    _ = init;
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
