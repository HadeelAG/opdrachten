int x = 50;
int y = 150;

void setup() {
  size(200, 200);
  tekenBos(3);
}

void tekenBoom(int x, int y) {
  rect(x - 10, y - 40, 20, 40);
  ellipse(x, y - 60, 40, 40);
}

void tekenBos(int aantal) {
  for (int i = 0; i < aantal; i++) {
    tekenBoom(x + i * 50, y);
  }
}

//heel simple bos...
