import raylib;
import basic;
import consants;
import types;

enum windowx=playfieldx;
enum windowy=playfieldy;
struct dot{
	int x;
	int y;
}
void main(){
	mixin(import("drawing.mix"));
	import spacetree_;
	dot[9000] dots;
	foreach(i;0..9000){
		dots[i]=dot(uniform(0,playfieldx),uniform(0,playfieldy));
	}
	spacetree!(dot) dottree=spacetree!(dot)(dots[]);
	
	int i;
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			//DrawText("Hello, World!", 10,10, 20, Colors.WHITE);
			//if(i%10==0){dots.sort;} i++;
			dottree.sort;
			foreach(ref e;dots){
				DrawCircle(e.x,e.y,3,Colors.RED);
				e.x+=uniform(-4,5);
				e.y+=uniform(-4,5);
			}
			//int interactions=0;
			//foreach(x;0..32){
			//foreach(y;0..32){
			//	auto r=dots[pos(x,y)];
			//	foreach(j;0..min(r.length-1,r.length)){
			//	foreach(ref e;r[min(1,$)..$]){
			//		//DrawLineV(r.front.v,e.v,Colors.YELLOW);
			//		interactions++;
			//	}
			//		if( ! r.empty){
			//			r.popFront;
			//		}
			//	}
			//}}
			//interactions.writeln;
			DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}

//frame rate drops to 40 with the same number of elements as the other demo... without recursive sorting or drawing, so fuck trees