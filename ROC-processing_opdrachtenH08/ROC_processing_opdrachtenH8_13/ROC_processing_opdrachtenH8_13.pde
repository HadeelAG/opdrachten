size(200, 400);
background(255, 255, 255);
int tafel = 3;
for (int i = 1; i <= 10; i++) {
  fill(255,0,0);
  text(i + " x " + tafel + " = " + (i * tafel), 20, 20 + i * 20);
}
