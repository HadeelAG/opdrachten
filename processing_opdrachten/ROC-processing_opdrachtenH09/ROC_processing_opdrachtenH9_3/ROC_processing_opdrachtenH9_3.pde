int a = 5;
int b = 10;

void setup() {
  float res = berekenGemiddelde(a, b);
  println("Gem: " + res);
}

float berekenGemiddelde(int x, int y) {
  return (x + y) / 2.0;
}
