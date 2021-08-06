int main(){
	int a[10];
	Mars_PrintStr("please input ten int number for bubble sort:\n");
	for (int i = 0; i < 10; i++) {
		a[i] = Mars_GetInt();
	}
	Mars_PrintStr("before bubble sort:\n");
	for (int i = 0; i < 10; i++) {
		Mars_PrintInt(a[i]);
	}
	Mars_PrintStr("\n");
	// bubble sort
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 10-i-1; j++) {
			if (a[j] > a[j + 1]) {
				int tmp = a[j];
				a[j] = a[j + 1];
				a[j + 1] = tmp;
			}
		}
	}
	Mars_PrintStr("after bubble sort:\n");
	for (int i = 0; i < 10; i++) {
		Mars_PrintInt(a[i]);
	}

    return 0;
}