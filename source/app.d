import raylib;
import basic;
import consants;

enum windowx=playfieldx;
enum windowy=playfieldy;

void main(){
	mixin(import("drawing.mix"));
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			//DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}