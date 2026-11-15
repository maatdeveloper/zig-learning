const std = @import("std");

const A = error {
    ConnectionTimeoutError,
    DatabaseNotFound,
    OutOfMemory,
    InvalidToken,
};

const B = error {
    OutOfMemory,
};

pub fn main(init: std.process.Init) !void {
    const cwd = std.Io.Dir.cwd();
    const file = cwd.openFile(
        init.io, "doesnt_exist.txt", .{}
    ) catch |err| {
        // do something
        return err;
    };
    _ = file;
}

fn cast(err: B) A {
    return err;
}

test "coerce error value" {
    const error_value = cast(B.OutOfMemory);
    try std.testing.expect(
        error_value == A.OutOfMemory,
    );
}