#include <stdio.h>
#include <stdlib.h>
#define MAXN 5000005

char rpath[] = "../../data/in.txt";
int arr[MAXN];

extern void Qsort(int a[], int low, int high);

int get_arr(FILE *fp, int arr[])
{
    int id=0;
    fseek(fp, 0, 0);
    while(fscanf(fp,"%d",&arr[id])!=EOF)
        id++;
    return id;
}

int main()
{
    FILE *fp;
    fp = fopen(rpath, "r");
    int len=get_arr(fp,arr);
    fclose(fp);
    Qsort(arr,0,len-1);
    for(int i=len/2;i<len/2+10;i++)
        printf("%d\n",arr[i]);
}
