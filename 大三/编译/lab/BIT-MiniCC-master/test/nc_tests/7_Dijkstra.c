/*
input : 
5
7
1 2 10
1 4 30
1 5 100
2 3 50
3 5 10
4 3 20
4 5 60
In mars, you should input these numbers by line:
5
7
1
2
10
...
*/
int maxint = 999999;

int dist[50];
int prev[50];
int cc[50][50];
int n,line;
void Dijkskra(int n, int v){
	int s[50];
	for(int i = 1; i<=n; ++i){
		dist[i] = cc[v][i];
		s[i] = 0;
		if(dist[i] == maxint){
			prev[i] = 0;
		}else{
			prev[i] = v;
		}
	}
	dist[v] = 0;
	s[v] = 1;
	for(int i = 2; i<=n; ++i){
		int tmp = maxint;
		int u = v;
		for(int j = 1; j<=n; ++j){
			if((!s[j]) && dist[j] < tmp){
				u = j;
				tmp = dist[j];
			}
		}
		s[u] = 1;
		for(int j = 1; j<=n; ++j){
			if((!s[j]) && cc[u][j] < maxint){
				int newdist = dist[u] + cc[u][j];

				if(newdist < dist[j]){
					dist[j] = newdist;
					prev[j] = u;
				}
			}
		}
	}
	return;
}
void searchPath(int v,int u){
	int que[50];
	int tot = 1;
	que[tot] = u;
	tot++;
	int tmp = prev[u];

	for(;tmp!=v;){
		que[tot] = tmp;
		tot++;
		tmp = prev[tmp];
	}
	que[tot] = v;
	for(int i = tot; i>=1; --i){
		Mars_PrintInt(que[i]);
		if(i!=1){
			Mars_PrintStr("->");
		}else{
			Mars_PrintStr("\n");
		}
	}
	return;
}
int main(){

	n = Mars_GetInt();
	line = Mars_GetInt();
	int p,q,len;
	for(int i = 1; i<=n; ++i){
		for(int j = 1; j<=n; j++){
			cc[i][j] = maxint;
		}
	}

	for(int i = 1; i<=line; ++i){
		p = Mars_GetInt();
		q = Mars_GetInt();
		len = Mars_GetInt();
		if(len < cc[p][q]){
			cc[p][q] = len;
			cc[q][p] = len;
		}
	}

	for(int i = 1; i<=n; ++i){
		dist[i] = maxint;
	}

	for(int i = 1; i<=n; ++i){
		for(int j = 1; j<=n; ++j){
			Mars_PrintInt(cc[i][j]);
		}
		Mars_PrintStr("\n");
	}
	Dijkskra(n,1);

	Mars_PrintStr("Shortest path length from source point to last vertex:");
	Mars_PrintInt(dist[n]);
	Mars_PrintStr("\nThe path is:\n");
	searchPath(1,n);
    return 0;
}