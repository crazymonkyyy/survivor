import consants;
import types;
import basic;//BAD: I want writeln rn
enum gridsize=32;
enum gridcellsx=playfieldx/gridsize;
enum gridcellsy=playfieldy/gridsize;
enum gridcells=gridcellsx*gridcellsy;

struct gridarray(T,int n){
	bool evenodd;
		void tick(){evenodd= ! evenodd;}
	int length=0;
		bool isfull(){return length>=n;}
	T[n][2] arrays;
		ref T[n]   active(){return arrays[evenodd];}
		ref T[n] inactive(){return arrays[ ! evenodd];}
		void opOpAssign(string s:"~")(T a){
			assert( ! isfull);//BAD: should drop elements, not cause crashes, but leave this till array sizes are not causing problems
			active[length]=a;
			length++;
		}
		ref auto torange(){return active[0..length];}
		alias torange this;
	bool isdead(gridvec2 a){
		return a.x!=a.x && a.y!=a.y;
	}
	pos to(S:pos)(gridvec2 v){
		pos p;
		p.x=cast(int)(v.x/gridsize);
		p.y=cast(int)(v.y/gridsize);
		return p;
	}
	
	pos to(S:pos)(T a){
		gridvec2 temp=a.to!gridvec2;
		if(isdead(temp)){return pos(1000,1000);}//make uviversal function call syntax universal
		return to!pos(temp);//make uviversal function call syntax universal
	}
	size_t[gridcells+1] offsets;//consider factoring into a god object
		void zerooffsets(){
			foreach(ref e;offsets){
				e=0;}}
		void prefixsumoffsets(){
			size_t total=0;
			foreach(ref e;offsets){
				total+=e;
				e=total-e;
		}}
		alias offset=int;
		offset to(S:offset)(pos p){
			//TODO: uncomment this if(p==pos(1000,1000)){assert(0);}//TODO: should somehow filter out and set length smaller
			if(p.x<0||p.x>=gridcellsx){return -1;}
			if(p.y<0||p.y>=gridcellsy){return -1;}
			auto temp=p.x+p.y*gridcellsx;
			assert(temp<=gridcells);
			return temp;
		}
		ref size_t offsets_(pos p){
			return offsets[min(to!offset(p)+1,$-1)];//make uviversal function call syntax universal
		}
		ref size_t offsets_(T a){
			return offsets_(to!pos(a)); //make uviversal function call syntax universal
		}
	void sort(){
		zerooffsets;
		foreach(i,e;active[0..length]){
			offsets_(e)++;
		}
		prefixsumoffsets;
		auto store=offsets;
		foreach(i,e;active[0..length]){
			inactive[offsets_(e)]=e;
			offsets_(e)++;
		}
		offsets=store;
		tick;
	}
	T[] opIndex(pos p){
		return active[min(offsets_(p),$-1)..min(offsets[min(to!offset(p)+2,$-1)],$-1)];//BAD oh my god I need to write an abstraction for slicing thats returns an empty one for whatever reason
	}
	T[] opIndex(S)(S a){
		auto temp=a.to!gridvec2;
		if(isdead(temp)){return [];}//make uviversal function call syntax universal
		return this[to!pos(temp)];
	}
}
//TODO: add delete system
//TODO: make nice ranges for pairing off local elements
//TODO: check the speed is in line with kd trees memes