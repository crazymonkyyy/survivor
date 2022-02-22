import raylib;
import basic;
import consants;
import types;

enum windowx=playfieldx;
enum windowy=playfieldy;

void main(){ with(KeyboardKey){with(Colors){//HACK
	bullets_ bullets;
	enemys_ enemys;
	int enemycd;
	mixin(import("drawing.mix"));
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(BLACK);
			if(player.bulletcd==0){//TODO: factor all this into gameplay.d or sometin
				player.bulletcd=100;
				foreach(x;[-2,-1,0,1,2]){
				foreach(y;[-2,-1,0,1,2]){
					bullets~=bullet(Vector2(player.x,player.y),Vector2(x,y));
			}}}
			player.bulletcd--;
			int dash=1;
			if(IsKeyDown(KEY_SPACE)&& player.dashcd==0){
				player.dashcd=300;
				dash=25;
			}
			player.dashcd=max(player.dashcd-1,0);
			player.x+=IsKeyDown(KEY_D)*3*dash+IsKeyDown(KEY_A)*-3*dash;
			player.y+=IsKeyDown(KEY_S)*3*dash+IsKeyDown(KEY_W)*-3*dash;
			foreach(ref e;bullets){
				e.update;
			}
			
			if(enemycd==0){
				enemycd=10;
				foreach(x;[-2,-1,-.6,-0.51,0,.51,.6,1,2]){
				foreach(y;[-2,-1,-.6,-0.51,0,.51,.6,1,2]){
					enemys~=enemy(Vector2(player.x+x*playfieldx,player.y+y*playfieldy));
			}}}
			foreach(ref e;enemys){
				e.update;
				foreach(ref b;bullets[e]){
					e.update(b);
				}
				foreach(ref f;enemys[e]){
					e.update(f);
				}
			}
			draw(enemys);
			draw(player);
			draw(bullets);
			bullets.sort;
			enemys.sort;
			DrawFPS(10,10);
		EndDrawing();
	}
	CloseWindow();
}}}