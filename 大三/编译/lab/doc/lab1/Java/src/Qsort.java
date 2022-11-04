import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;

public class Qsort {
	public static void main(String[] args) throws Exception
	{
		String rpath = "../../data/in.txt";
		File fp = new File(rpath);
		int[] arr=new int[5000005];
		int len=get_arr(fp,arr);
		Qsort(arr,0,len-1);
        	for(int i=len/2;i<len/2+10;i++)
            		System.out.println( arr[i] + " ");
		
	}
	
	private static int get_arr(File file,int[] arr) throws Exception {
		int id=0;
		
		BufferedReader br= new BufferedReader(new FileReader(file));
		String line=null;
		while((line=br.readLine())!=null)
		{
			arr[id]=Integer.parseInt(line);
			id+=1;
		}
		if(br!= null){
			br.close();
			br = null;
		}
		return id;
	}
	
	private static int Partition(int[] a, int low, int high)
	{
	    int key = a[low];
	    while(low<high)
	    {
	        while(low<high && a[high] >= key) --high;
	        a[low] = a[high];
	        while(low<high && a[low] <= key) ++low;
	        a[high] = a[low];
	    }
	    a[low] = key;
	    return low;
	}
	public static void Qsort(int[] a, int low, int high)
	{
	    if(low < high)
	    {
	        int loc = Partition(a, low, high);
	        Qsort(a, low, loc-1);
	        Qsort(a, loc+1, high);
	    }
	}


}
