int a[10] = {1,4,7,2,3,0,8,5,9,6};	// BitMINICC灏氭湭瀹炵幇鎸囬拡锛岄噰鐢ㄥ叏灞�鏁扮粍
void quick(int start,int end);
int partion(int low,int high);
void quickSort(int len){
	quick(0,len-1);
	return;
}
void quick(int start,int end){
	int par = partion(start,end);
	if(par > start + 1){
		quick(start, par-1);
	}
	if(par < end - 1){
		quick(par+1, end);
	}
	return;
}
int partion(int low, int high){
	int tmp = a[low];
	for(; low < high; ){
		for(; low < high && a[high] > tmp;){
			high --;
		}
		if(low >= high){
			break;
		}else{
			a[low] = a[high];
		}
		for(; low < high && a[low] < tmp;){
			low ++;
		}
		if(low >= high){
			break;
		}else{
			a[high] = a[low];
		}
	}
	a[low] = tmp;

	return low;
}
int main(){
	Mars_PrintStr("Before quicksort:\n");
	for(int i = 0; i<10; i++){
		Mars_PrintInt(a[i]);
	}
	quickSort(10);
	Mars_PrintStr("\nAfter quicksort:\n");
	for(int i = 0; i<10; i++){
		Mars_PrintInt(a[i]);
	}
    return 0;
}