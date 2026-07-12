const std = @import("std");
const Io = std.Io;
var buffer: [1024]u8 = undefined;

const User = struct {
    id: usize,
    name: []const u8,

    pub fn init(id: usize, name: []const u8) User {
        return .{ .id = id, .name = name };
    }
};

pub fn main() !void {
    @memset(&buffer, 0);

    var dbga = std.heap.DebugAllocator(.{}){};
    var fba = std.heap.FixedBufferAllocator.init(&buffer);

    const dbg_allocator = dbga.allocator();
    const name = "Matheus";
    const output = try std.fmt.allocPrint(dbg_allocator, "Hello {s}!\n", .{name});

    const fb_allocator = fba.allocator();
    const input = try fb_allocator.alloc(u8, 32);
    defer fb_allocator.free(input);

    const user = try dbg_allocator.create(User);
    defer dbg_allocator.destroy(user);

    std.debug.print("{s}\n", .{output});
}
