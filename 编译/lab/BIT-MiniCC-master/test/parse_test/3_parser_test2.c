int main() {
  int a[5], i, j, t;
  for(i = 0; i < 5; i++) {
    a[i] = MARS_GETI();
  }
  for(i = 0; i < 4; i++) {
    for(j = 0; j < 5 - i; j++) {
      if(a[j] > a[j+1]) {
        t = a[j];
        a[j] = a[j+1];
        a[j+1] = t;
      }
    }
  }
  for(i = 0; i < 5; i++) {
    t = a[i];
    MARS_PUTI(t);
    MARS_PUTS("\n");
  }
  return;
}
