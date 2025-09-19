size(600, 600);
background(255, 255, 255);
int sizeC = 500;
for (int i = 0; i < 50; i++) {
  ellipse(300, 300, sizeC, sizeC);
  println("Circle size: " + sizeC);
  sizeC -= 10;
}
