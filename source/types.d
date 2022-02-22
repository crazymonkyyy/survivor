import raylib;
import gridsorted;
import consants;
struct pos{
	int x;
	int y;
}
alias gridvec2=Vector2;

struct player_{
	int x;
	int y;
	int bulletcd;
	int dashcd;
}
static player_ player;

struct bullet{
	Vector2 v;
	Vector2 vel;
	void update(){
		v+=vel;
	}
	gridvec2 to(T:gridvec2)(){
		auto o=v;
		o.x-=player.x-playfieldx/2;
		o.y-=player.y-playfieldy/2;
		return o;
	}
}
struct enemy{
	Vector2 v;
	gridvec2 to(T:gridvec2)(){
		auto o=v;
		o.x-=player.x-playfieldx/2;
		o.y-=player.y-playfieldy/2;
		return o;
	}
	void update(){
		v-=Vector2Normalize(v-Vector2(player.x,player.y));
	}
	void update(ref bullet b){
		if(Vector2Distance(v,b.v)<12){
			v.x=float.nan;
			v.y=float.nan;
			b.v.x=float.nan;
			b.v.y=float.nan;
	}}
	void update(ref enemy e){
		if(&e==&this){return;}
		if(Vector2Distance(v,e.v)<28){
			  v+=Vector2Normalize(v-e.v)*.25;
			e.v-=Vector2Normalize(v-e.v)*.25;
		}
	}
}
alias bullets_=gridarray!(bullet,1000);
alias enemys_ =gridarray!(enemy,1000);