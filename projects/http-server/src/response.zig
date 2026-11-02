const std = @import("std");
const Stream = std.Io.net.Stream;

pub fn send_200(conn: Stream, io: std.Io) !void {
    const message = ("HTTP/1.1 200 OK\nContent-Length: 48" ++ "\nContent-Type: text/html\n" ++ "Connection: Closed\n\n<html><body>" ++ "<h1>oiii rs (from zig)</h1></body></html>");
    var stream_writer = conn.writer(io, &.{});
    _ = try stream_writer.interface.write(message);
}

pub fn send_404(conn: Stream, io: std.Io) !void {
    const message = ("HTTP/1.1 404 Not Found\nContent-Length: 50" ++ "Content-Type: text/html\n" ++ "Connection: Closed\n\n<html><body>" ++ "<h1>não deu certo chefe desista</h1></body></html>");
    var stream_writer = conn.writer(io, &.{});
    _ = try stream_writer.interface.write(message);
}
