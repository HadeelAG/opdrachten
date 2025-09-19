String s1 = "Hello";
String s2 = " ";
String s3 = "World";
String s4 = "!";

void setup() {
  noLoop();
  String resultaat = combineStringz(s1, s2, s3, s4);
  println(resultaat);
}

String combineStringz(String a, String b, String c, String d) {
  return a + b + c + d;
}
