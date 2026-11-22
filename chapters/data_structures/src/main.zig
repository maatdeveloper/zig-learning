const std = @import("std");
const AutoHashMap = std.hash_map.AutoHashMap;

const node = struct {
    value: u32,
    next: std.SinglyLinkedList.Node = .{},
};

pub fn main(init: std.process.Init) !void {
    _ = init;

    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    // ArrayList
    var arrlist = try std.ArrayList(u8).initCapacity(allocator, 512);
    defer arrlist.deinit(allocator);

    try arrlist.append(allocator, 'z');
    try arrlist.append(allocator, 'i');
    try arrlist.append(allocator, 'g');
    try arrlist.append(allocator, '!');

    _ = arrlist.pop();

    try arrlist.insert(allocator, 0, '.');
    try arrlist.insertSlice(allocator, 0, "main");

    std.debug.print("{s}\n", .{arrlist.items});

    // HashTable
    var htable = AutoHashMap(u8, u32).init(allocator);
    defer htable.deinit();

    try htable.put('A', 45834);
    try htable.put('B', 62674);
    try htable.put('C', 84346);

    std.debug.print("N of values stored: {d}\n", .{htable.count()});
    std.debug.print("Value at 'B' key: {d}\n", .{htable.get('B').?});

    if (htable.remove('A')) {
        std.debug.print("Value at 'A' key has successfully removed\n", .{});
    }

    var it = htable.iterator();
    while (it.next()) |key| {
        std.debug.print("{c}: ", .{key.key_ptr.*});
        std.debug.print("{d}\n", .{key.value_ptr.*});
    }

    // LinkedList
    var llist: std.SinglyLinkedList = .{};

    var one: node = .{.value = 10};
    var two: node = .{.value = 20};
    var thr: node = .{.value = 30};

    llist.prepend(&one.next);   // head
    one.next.insertAfter(&two.next);
    two.next.insertAfter(&thr.next);

    _ = llist.popFirst();

    std.debug.print("Size of LinkedList: {d}\n", .{llist.len()});
}