//DONT USE
//exists to check if trees are magicly better then gridsorted.d
//they airnt is my current conculsion






import basic;
enum cutoff=32;
struct spacetree(T){
	T[] slice;
		bool haschildren(){return slice.length>cutoff;}
		void selectpivots(){
			ulong a=uniform(2+1,slice.length-3);
			ulong b=uniform(a+1,slice.length-2);
			ulong c=uniform(b+1,slice.length);
			swap(slice[a],slice[0]);
			swap(slice[b],slice[1]);
			swap(slice[c],slice[2]);
		}
		T[] pivots(){return slice[0..3];}
		T[] data(){return slice[3..$];}
	size_t[16] offsets;
		void zerooffsets(){
			foreach(ref e;offsets){
				e=0;}}
		void prefixsumoffsets(){
			size_t total=0;
			foreach(ref e;offsets){
				total+=e;
				e=total-e;
		}}
		size_t tooffset(ref T a){
			int x; int y;
			static foreach(i;0..3){
				x+=pivots[i].x<a.x;
				y+=pivots[i].y<a.y;
			}
			return x+y*4;
		}
	void sort(){
		zerooffsets;
		selectpivots;
		foreach(ref e;data){
			offsets[tooffset(e)]++;
		}
		prefixsumoffsets;
		auto storeoffsets=offsets;
		T[] store= new T[slice.length-3];
		foreach(ref e;data){
			store[offsets[tooffset(e)]]=e;
			offsets[tooffset(e)]++;
		}
		offsets=storeoffsets;
		foreach(ref a,ref b;zip(data,store)){
			a=b;
		}
	}
}