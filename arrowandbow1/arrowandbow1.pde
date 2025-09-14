float y = 500;
float y1 = 500;
float x = 0;
float x2 = 50;


void setup() {
  size(500, 500);
}

void draw() {
  background(255, 255, 255);
  y = y - 4;
  y1 = y1 - 6;
  ellipse(100, y, 30, 30);
  ellipse(130, y1, 30, 30);
  x = x + 2;
  x2 = x2 + 2;

  line(x, 80, x2, 80);
  if (y <= 0) {
    y = 500;
  }

  if (y1 <= 0) {
    y1 = 500;
  }

  if (x >= 500 && x2 >= 500) {
    x = 0;
    x2 = 50;
  }
}
