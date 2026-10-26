const std = @import("std");
const writer = std.Io.File.Writer;
const expect = std.testing.expect;

// const debugging = @import("debugging");

pub fn main(init: std.process.Init) !void {
    var stdout_buff: [1024]u8 = undefined;
    var stderr_buff: [1024]u8 = undefined;
    var stdout_writ = writer.init(std.Io.File.stdout(), init.io, &stdout_buff);
    var stderr_writ = writer.init(std.Io.File.stderr(), init.io, &stderr_buff);
    const stdout = &stdout_writ.interface;
    const stderr = &stderr_writ.interface;
    const sum = add(5, 5);

    std.debug.print("debugging?\n", .{});
    try expect(@TypeOf(sum) == i32);
    try stderr.print("Some value\n", .{});
    try stdout.print("Hi btw {d}\n", .{sum});
    try stdout.flush();
}

pub fn add(x: i32, y: i32) i32 {
    return x + y;
}
