import consants;
import types;
enum gridsize=16;
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
	bool isdead(gridvec2 a){
		return a.x!=a.x && a.y!=a.y;
	}
	pos to(S:pos)(T a){
		gridvec2 temp=a.to!gridvec2;
		if(isdead(temp)){return pos(1000,1000);}//make uviversal function call syntax universal
		pos p;
		p.x=cast(int)(temp.x/gridsize);
		p.y=cast(int)(temp.y/gridsize);
		return p;
	}
	size_t[gridcells] offsets;//consider factoring into a god object
		void zerooffsets(){
			foreach(ref e;offsets){
				e=0;}}
		void prefixsumoffsets(){
			size_t total=0;
			foreach(ref e;offsets){
				total+=e;
				e=total;
		}}
		alias offset=int;
		offset to(S:offset)(pos p){
			if(p==pos(1000,1000)){assert(0);}//TODO: should somehow filter out and set length smaller
			if(p.x<0||p.x>=gridcellsx){return -1;}
			if(p.y<0||p.y>=gridcellsy){return -1;}
			auto temp=p.x+p.y*gridcellsx;
			assert(temp<=gridcells);
			return temp;
		}
		ref size_t offsets_(pos p){
			return offsets[to!offset(p)];//make uviversal function call syntax universal
		}
		ref size_t offsets_(T a){
			return offsets_(to!pos(a)); //make uviversal function call syntax universal
		}
	void sort(){
		zerooffsets;
		foreach(e;active[0..length]){
			offsets_(e)++;
		}
		prefixsumoffsets;
		auto store=offsets;
		foreach(e;active[0..length]){
			inactive[offsets_(e)]=e;
			offsets_(e)++;
		}
		offsets=store;
		tick;
	}
}