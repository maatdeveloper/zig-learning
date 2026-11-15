const std = @import("std");

const intTarget = union {
    base8: i8,
    base16: i16,
    base32: i32,
    base64: i64,
    base128: i128,
    ibase: isize,
};
pub fn main(init: std.process.Init) !void {
    _ = init;
    
}
