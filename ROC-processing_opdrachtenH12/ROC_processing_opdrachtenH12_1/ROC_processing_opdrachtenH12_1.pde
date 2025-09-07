class Rechthoek {
  float x, y;
  float breedte, hoogte;
  
  Rechthoek(float tempX, float tempY, float tempBreedte, float tempHoogte) {
    x = tempX;
    y = tempY;
    breedte = tempBreedte;
    hoogte = tempHoogte;
  }
  
  void teken() {
    rect(x, y, breedte, hoogte);
  }
}

Rechthoek mijnRechthoek;

void setup() {
  size(400, 400);
  mijnRechthoek = new Rechthoek(100, 100, 200, 150);
}

void draw() {
  background(255);
  mijnRechthoek.teken();
}
