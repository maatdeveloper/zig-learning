const std = @import("std");
const Stack = @import("./stack.zig").Stack;
// stack com generics (comptime)

pub fn main(init: std.process.Init) !void {
    _ = init;
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();
    const Stack_u8 = Stack(u8);

    var stack = try Stack_u8.init(allocator, 32);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);
    try stack.push(4);
    try stack.push(5);
    try stack.push(6);

    std.debug.print("Stack len: {d}\n", .{stack.length});
    std.debug.print("Stack capacity: {d}\n", .{stack.capacity});

    try stack.pop();
    std.debug.print("Stack len: {d}\n", .{stack.length});
    try stack.pop();
    std.debug.print("Stack len: {d}\n", .{stack.length});

    std.debug.print("Stack state: {any}\n", .{stack.items[0..stack.length]});
}
