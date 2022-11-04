def get_arr(arr,fp):
    line=fp.readline()
    while line:
        arr.append(int(line))
        line=fp.readline()
        
def Partition(a,low,high):
    key=a[low]
    while low<high:
        while (low<high and a[high]>=key):
            high-=1
        a[low]=a[high]
        while (low<high and a[low]<=key):
            low+=1
        a[high]=a[low]
    a[low]=key
    return low

def Qsort(a,low,high):
    if(low<high):
        loc=Partition(a,low,high)
        Qsort(a,low,loc-1)
        Qsort(a,loc+1,high)

if __name__ == "__main__":
    rpath = "../../data/in.txt"
    
    fp = open(rpath)
    arr=[]
    get_arr(arr,fp)
    fp.close()
    Len=len(arr)
    
    Qsort(arr,0,Len-1)
    for i in range(int(Len/2),int(Len/2)+10):
        print(arr[i])

    
    
    
    
