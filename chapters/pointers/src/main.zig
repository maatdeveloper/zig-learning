const std = @import("std");
const Io = std.Io;

pub fn main(init: std.process.Init) !void {
    _ = init;

    const arr = [_]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    const sli = arr[0..arr.len]; // slices são ponteiros!
    var ptr: [*]const u8 = &arr;
    _ = sli;

    std.debug.print("{d}\n", .{ptr[0]});
    ptr += 1;
    std.debug.print("{d}\n", .{ptr[0]});
    ptr += 1;
    std.debug.print("{d}\n", .{ptr[0]});

    const number = 10;
    const pointer = &number;
    const double = pointer.* * 2;
    std.debug.print("{d}\n", .{double});

    //pointer.* = 5; tentando alterar um valor const
    // optional e nulls
    var num: ?i32 = 10;
    if (num) |not_null_num| {
        std.debug.print("num ({d}) is not null\n", .{not_null_num});
    }
    const x: ?i32 = null;
    const xx = (x orelse 15) * 2;
    std.debug.print("{d}\n", .{xx});

    const point = &num;
    _ = point;
}
