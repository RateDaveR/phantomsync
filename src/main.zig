const std = @import("std");

// Custom error type
const SessionError = error{
    NotX11Session,
};

pub fn main() !void {
    // Create our allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Get environment variable
    const xdg_session = std.process.getEnvVarOwned(allocator, "XDG_SESSION_TYPE") catch |err| {
        std.debug.print("Error: {}\n", .{err});
        return;
    };
    // Free the memory when we're done
    defer allocator.free(xdg_session);

    // Check if it's not X11
    if (!std.mem.eql(u8, xdg_session, "x11")) {
        std.debug.print("Error: Not running X11 (current session: {s})\n", .{xdg_session});
        return SessionError.NotX11Session;
    }

    std.debug.print("Running X11!\n", .{});
}
