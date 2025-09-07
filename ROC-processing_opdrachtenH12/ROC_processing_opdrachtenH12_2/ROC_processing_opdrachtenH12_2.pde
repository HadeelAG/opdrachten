class Persoon {
  String naam;
  int leeftijd;
  String geslacht;
  
  Persoon(String naamP, int leeftijdP, String GeslachtP) {
    naam = naamP;
    leeftijd = leeftijdP;
    geslacht = GeslachtP;
  }
  
  void naamGeven() {
    println("Naam: " + naam);
  }
   
  void leeftijdGeven() {
    println("Leeftijd: " + leeftijd);
  }
}

Persoon mijnPersoon;

void setup() {
  mijnPersoon = new Persoon("iemand", 30, "Vrouw");
  mijnPersoon.naamGeven();
  mijnPersoon.leeftijdGeven();
}
