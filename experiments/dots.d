import raylib;
import basic;
import consants;
import types;

enum windowx=playfieldx;
enum windowy=playfieldy;
struct dot{
	Vector2 v;
	gridvec2 to(T:gridvec2)(){
		return v;
	}
}
void main(){
	mixin(import("drawing.mix"));
	import gridsorted;
	gridarray!(dot,10000) dots;
	foreach(i;0..9000){
		dots~=dot(Vector2(uniform(0,playfieldx),uniform(0,playfieldy)));
	}
	int i;
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			//DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			if(i%10==0){dots.sort;} i++;
			foreach(ref e;dots){
				DrawCircleV(e.v,3,Colors.RED);
				e.v.x+=uniform(-4,5);
				e.v.y+=uniform(-4,5);
			}
			int interactions=0;
			foreach(x;0..32){
			foreach(y;0..32){
				auto r=dots[pos(x,y)];
				foreach(j;0..min(r.length-1,r.length)){
				foreach(ref e;r[min(1,$)..$]){
					//DrawLineV(r.front.v,e.v,Colors.YELLOW);
					interactions++;
				}
					if( ! r.empty){
						r.popFront;
					}
				}
			}}
			interactions.writeln;
			DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}