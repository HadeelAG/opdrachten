class Bankrekening {
  String rekeningnummer;
  float saldo;
  String eigenaar;
  
  Bankrekening(String RekeningnummerB, float SaldoB, String EigenaarB) {
    rekeningnummer = RekeningnummerB;
    saldo = SaldoB;
    eigenaar = EigenaarB;
  }
  
  void storten(float bedrag) {
    if (bedrag > 0) {
      saldo += bedrag;
      println("Gestort: " + bedrag + ". Nieuw saldo: " + saldo);
    } else {
      println("moet positief ziin");
    }
  }
  
  void opnemen(float bedrag) {
    if (bedrag > 0 && bedrag <= saldo) {
      saldo -= bedrag;
      println("Opgenomen: " + bedrag + ". Nieuw saldo: " + saldo);
    } else if (bedrag > saldo) {
      println("Broke. Huidig saldo: " + saldo);
    } else {
      println("moet positief zijn.");
    }
  }
}

Bankrekening mijnRekening;

void setup() {
  mijnRekening = new Bankrekening("NL123456789", 1000.0, "Bob The Builder");
  mijnRekening.storten(500.0);
  mijnRekening.opnemen(300.0);
  mijnRekening.opnemen(2000.0);
}
