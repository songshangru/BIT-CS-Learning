/*
 * name : Bowen Liu
 * ID   : 1120201883
*/

/* 
 * trans.c - Matrix transpose B = A^T
 *
 * Each transpose function must have a prototype of the form:
 * void trans(int M, int N, int A[N][M], int B[M][N]);
 *
 * A transpose function is evaluated by counting the number of misses
 * on a 1KB direct mapped cache with a block size of 32 bytes.
 */ 
#include <stdio.h>
#include "cachelab.h"

int is_transpose(int M, int N, int A[N][M], int B[M][N]);

/* 
 * transpose_submit - This is the solution transpose function that you
 *     will be graded on for Part B of the assignment. Do not change
 *     the description string "Transpose submission", as the driver
 *     searches for that string to identify the transpose function to
 *     be graded. 
 */
char transpose_submit_desc[] = "Transpose submission";
void transpose_submit(int M, int N, int A[N][M], int B[M][N]){
	if(M == 32){
        int i,j,k;
        int temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
        for(i = 0; i < M; i += 8){
            for(j = 0; j < N; j += 8){
                for(k = i; k < i+8; k++){
                    temp0 = A[j][k];
                    temp1 = A[j+1][k];
                    temp2 = A[j+2][k];
                    temp3 = A[j+3][k];
                    temp4 = A[j+4][k];
                    temp5 = A[j+5][k];
                    temp6 = A[j+6][k];
                    temp7 = A[j+7][k];

                    B[k][j] = temp0;
                    B[k][j+1] = temp1;
                    B[k][j+2] = temp2;
                    B[k][j+3] = temp3;
                    B[k][j+4] = temp4;
                    B[k][j+5] = temp5;
                    B[k][j+6] = temp6;
                    B[k][j+7] = temp7;
                }
            }
        }
    }else if(M==64){
        int i, j, x, y;
		int temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
		for (i = 0; i < N; i += 8){
			for (j = 0; j < M; j += 8){
				for (x = i; x < i + 4; ++x){
					temp0 = A[x][j]; 
                    temp1 = A[x][j+1]; 
                    temp2 = A[x][j+2]; 
                    temp3 = A[x][j+3];
					temp4 = A[x][j+4]; 
                    temp5 = A[x][j+5]; 
                    temp6 = A[x][j+6]; 
                    temp7 = A[x][j+7];
					
					B[j][x] = temp0; 
                    B[j+1][x] = temp1; 
                    B[j+2][x] = temp2; 
                    B[j+3][x] = temp3;
					B[j][x+4] = temp4; 
                    B[j+1][x+4] = temp5; 
                    B[j+2][x+4] = temp6; 
                    B[j+3][x+4] = temp7;
				}
				for (y = j; y < j + 4; ++y){
					temp0 = A[i+4][y]; 
                    temp1 = A[i+5][y]; 
                    temp2 = A[i+6][y]; 
                    temp3 = A[i+7][y];
					temp4 = B[y][i+4]; 
                    temp5 = B[y][i+5]; 
                    temp6 = B[y][i+6]; 
                    temp7 = B[y][i+7];
					
					B[y][i+4] = temp0; 
                    B[y][i+5] = temp1; 
                    B[y][i+6] = temp2; 
                    B[y][i+7] = temp3;
					B[y+4][i] = temp4; 
                    B[y+4][i+1] = temp5; 
                    B[y+4][i+2] = temp6; 
                    B[y+4][i+3] = temp7;
				}
				for (x = i + 4; x < i + 8; ++x){
					temp0 = A[x][j+4]; 
                    temp1 = A[x][j+5]; 
                    temp2 = A[x][j+6]; 
                    temp3 = A[x][j+7];
					B[j+4][x] = temp0; 
                    B[j+5][x] = temp1; 
                    B[j+6][x] = temp2; 
                    B[j+7][x] = temp3;
				}
			}
        }
    }else{ // M=61,N=67
        int i,j,temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
        // 8分块
		for (j = 0; j < 56; j += 8){
			for (i = 0; i < 64; ++i){
				temp0 = A[i][j];
				temp1 = A[i][j+1];
				temp2 = A[i][j+2];
				temp3 = A[i][j+3];
				temp4 = A[i][j+4];
				temp5 = A[i][j+5];
				temp6 = A[i][j+6];
				temp7 = A[i][j+7];
				
				B[j][i] = temp0;
				B[j+1][i] = temp1;
				B[j+2][i] = temp2;
				B[j+3][i] = temp3;
				B[j+4][i] = temp4;
				B[j+5][i] = temp5;
				B[j+6][i] = temp6;
				B[j+7][i] = temp7;
			}
        }

        // 直接转置 
		for (i = 0; i < N; ++i){
            for (j = 56; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }

		for (i = 64; i < N; ++i){
            for (j = 0; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }

        for (i = 64; i < N; ++i){
            for (j = 56; j < M; ++j){
				temp0 = A[i][j];
				B[j][i] = temp0;
			}
        }

    }
}

/* 
 * You can define additional transpose functions below. We've defined
 * a simple one below to help you get started. 
 */ 

/* 
 * trans - A simple baseline transpose function, not optimized for the cache.
 */
char trans_desc[] = "Simple row-wise scan transpose";
void trans(int M, int N, int A[N][M], int B[M][N])
{
    int i, j, tmp;
    for (i = 0; i < N; i++) {
        for (j = 0; j < M; j++) {
            tmp = A[i][j];
            B[j][i] = tmp;
        }
    }    

}

/*
 * registerFunctions - This function registers your transpose
 *     functions with the driver.  At runtime, the driver will
 *     evaluate each of the registered functions and summarize their
 *     performance. This is a handy way to experiment with different
 *     transpose strategies.
 */
void registerFunctions()
{
    /* Register your solution function */
    registerTransFunction(transpose_submit, transpose_submit_desc); 

    /* Register any additional transpose functions */
    registerTransFunction(trans, trans_desc); 

}

/* 
 * is_transpose - This helper function checks if B is the transpose of
 *     A. You can check the correctness of your transpose by calling
 *     it before returning from the transpose function.
 */
int is_transpose(int M, int N, int A[N][M], int B[M][N]){
    int i, j;

    for (i = 0; i < N; i++) {
        for (j = 0; j < M; ++j) {
            if (A[i][j] != B[j][i]) {
                return 0;
            }
        }
    }
    return 1;
}

