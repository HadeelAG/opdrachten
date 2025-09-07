int x = 50;
int y = 50;
int w = 40;
int h = 40;

void setup() {
  size(200, 200);
  tekenVierkant(x, y, w, h);
}

void tekenVierkant(int x, int y, int breedte, int hoogte) {
  line(x, y, x + breedte, y);
  line(x + breedte, y, x + breedte, y + hoogte);
  line(x + breedte, y + hoogte, x, y + hoogte);
  line(x, y + hoogte, x, y);
}
