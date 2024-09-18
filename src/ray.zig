const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() !void {
    const scr_width: i32 = 800;
    const scr_height: i32 = 600;

    rl.InitWindow(scr_width, scr_height, "bebra");

    rl.SetTargetFPS(60);

    while (!rl.WindowShouldClose()) {
        rl.BeginDrawing();

        rl.ClearBackground(rl.RAYWHITE);
        rl.DrawText("Bebra", 192, 200, 20, rl.LIGHTGRAY);

        rl.EndDrawing();
    }

    rl.CloseWindow();
}
