String naam = "Jan";
int totaalAantalLessen = 20;
int gevolgdeLessen = 17;
float cijfer = 7.0;

float percentageLessenGevolgd = (gevolgdeLessen * 100.0) / totaalAantalLessen;

if (cijfer >= 5.5 && percentageLessenGevolgd >= 80) {
  println(naam + " is geslaagd");
} else {
  println(naam + " is gezakt");
}

naam = "Klaas";
totaalAantalLessen = 20;
gevolgdeLessen = 16;
cijfer = 5.5;

percentageLessenGevolgd = (gevolgdeLessen * 100.0) / totaalAantalLessen;

if (cijfer >= 5.5 && percentageLessenGevolgd >= 80) {
  println(naam + " is geslaagd");
} else {
  println(naam + " is gezakt");
}
