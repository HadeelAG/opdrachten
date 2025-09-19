int steen1 = 4;
int steen2 = 2;
int steen3 = 6;

if (steen1 == 1 && steen2 == 1 && steen3 == 1) {
  println("Critical MISS!");
} else if (steen1 == 6 && steen2 == 6 && steen3 == 6) {
  println("Gefeliciteerd!!!");
} else if (steen1 == 1 || steen2 == 1 || steen3 == 1) {
  println("mis!");
} else {
  int gemiddelde = (steen1 + steen2 + steen3) / 3;
  println(gemiddelde + " HIT!");
}
