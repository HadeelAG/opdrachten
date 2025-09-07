int a = 0;
int b = 1;
int count = 10;
println(a);
println(b);
for (int i = 0; i < count - 2; i++) {
  int nxt = a + b;
  println(nxt);
  a = b;
  b = nxt;
}
