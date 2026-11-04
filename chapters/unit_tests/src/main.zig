const std = @import("std");
const expect = std.testing.expect;
const Allocator = std.mem.Allocator;
const expectError = std.testing.expectError;

pub fn main(init: std.process.Init) !void {
    _ = init;
}

fn some_memory_leak(allocator: Allocator) !void {
    const buffer = try allocator.alloc(u32, 10);
    _ = buffer;
}

fn alloc_error(allocator: Allocator) !void {
    var ibuffer = try allocator.alloc(u8, 100);
    defer allocator.free(ibuffer);
    ibuffer[0] = 2;
}

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "testing simple sum" {
    const a: u8 = 2;
    const b: u8 = 2;
    try expect((a + b) == 4);
}

test "memory leak" {
    const allocator = std.testing.allocator;
    try some_memory_leak(allocator);
}

test "testing error" {
    var buffer: [10]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    try expectError(error.OutOfMemory, alloc_error(allocator));
}

test "array is equal?" {
    const array1 = [3]u32{ 1, 2, 3 };
    const array2 = [3]u32{ 1, 2, 3 };
    try std.testing.expectEqualSlices(u32, &array1, &array2);
}
