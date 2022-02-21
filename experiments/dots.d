import raylib;
import basic;
import consants;
import types;

enum windowx=playfieldx;
enum windowy=playfieldy;
struct dot{
	gridvec2 to(T:gridvec2)(){
		return gridvec2();
	}
}
void main(){
	mixin(import("drawing.mix"));
	import gridsorted;
	gridarray!(dot,1000) dots;
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			//DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}