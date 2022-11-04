int Partition(int a[], int low, int high)
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
void Qsort(int a[], int low, int high)
{
    if(low < high)
    {
        int loc = Partition(a, low, high);
        Qsort(a, low, loc-1);
        Qsort(a, loc+1, high);
    }
}

