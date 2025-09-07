int a = 5;
int b = 10;

void setup() {
  berekenGemiddelde(a, b); 
}

void berekenGemiddelde(int x, int y) {
  int gemiddelde = (x + y) / 2;
  println("Gemiddelde: " + gemiddelde);
}
