float cijfer = 9.1;
boolean diploma = false;
boolean cumlaude = false;

if (cijfer >= 5.5) {
  diploma = true;
}

if (cijfer > 8) {
  cumlaude = true;
}

if (diploma) {
  println("je bent geslaagd");
  if (cumlaude) {
    println("En ook cumlaude");
  }
}
