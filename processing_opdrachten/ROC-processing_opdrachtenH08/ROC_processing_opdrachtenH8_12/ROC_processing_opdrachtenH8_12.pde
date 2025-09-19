size(240, 240);
background(255, 255, 255);
for (int i = 0; i < 10; i++) {
  for (int j = 0; j < 10; j++) {
    if ((i + j) % 2 == 0) {
      fill(0, 0, 0);
    } else {
      fill(255, 255, 255);
    }
    rect(20 + i * 20, 20 + j * 20, 20, 20);
  }
}
