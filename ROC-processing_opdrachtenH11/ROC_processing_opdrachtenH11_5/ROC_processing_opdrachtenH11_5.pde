void setup() {
  String[] names = {"Anna", "Bob", "Jan", "Emma", "David"};
  boolean gevonden = false;
  
  for (int i = 0; i < names.length; i++) {
    if (names[i].equals("Jan")) {
      gevonden = true;
    } 

  }
       println("bestaat jan?", gevonden);

}
