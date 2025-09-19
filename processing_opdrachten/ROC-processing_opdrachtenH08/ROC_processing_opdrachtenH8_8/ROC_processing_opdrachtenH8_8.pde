int a = 0;
int b = 1;
int count = 10;
println(a);
println(b);
for (int i = 0; i < count ; i++) {
  int nxt = a + b;
  println(nxt);
  a = b;
  // loop 1 : a = 0, b = 1, i = 0
  // loop 2: a = 1, b = 2, i = 1
  // loop 3: 
  b = nxt;
}
