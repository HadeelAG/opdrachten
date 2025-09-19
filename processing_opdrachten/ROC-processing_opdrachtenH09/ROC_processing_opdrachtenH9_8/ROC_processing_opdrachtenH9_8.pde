int x = 100;
int y = 150;

void setup() {
  size(200, 200);
  noLoop();
  tekenBoom(x, y);
}

void tekenBoom(int x, int y) {
  rect(x - 10, y - 40, 20, 40);
  ellipse(x, y - 60, 40, 40);
}
//heel simple boom...
