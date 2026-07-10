const std = @import("std");
const writer = std.Io.File.Writer;

const Role = enum {
    SE,
    DPE,
    DE,
    DA,
    PM,
    PO,
    KS,
};

pub fn main(init: std.process.Init) !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = writer.init(std.Io.File.stdout(), init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    var area: []const u8 = undefined;
    const role = Role.SE;
    const x = 5;
    const name = [_]u8{ 'M', 'a', 't', 'h', 'e', 'u', 's' };

    if (x > 5) {
        try stdout.print("x > 10\n", .{});
    } else {
        try stdout.print("x <= 10\n", .{});
    }

    switch (role) {
        .PM, .SE, .DPE, .PO => {
            area = "Plataform";
        },
        .DE, .DA => {
            area = "Data & Analytics";
        },
        .KS => {
            area = "Sales";
        },
    }

    foo();

    for (name, 0..) |c, n| {
        std.debug.print("{d}: {c}\n", .{ n, c });
    }

    try stdout.print("{s}\n", .{area});
    try stdout.flush();
}

fn foo() void {
    defer std.debug.print("Exiting function...\n", .{});
}

fn add_two(x: *u32) void {
    x.* = x.* + 2;
}
