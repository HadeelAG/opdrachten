int sizeC = 100;

void setup() {
  size(200, 200);
  tekenCirkels();
}
void tekenCirkels() {
  for (int i = 0; i < 5; i++) {
    ellipse(100 - sizeC / 2, 100, sizeC, sizeC);
    sizeC -= 20;
  }
}
