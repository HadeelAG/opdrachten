void setup() {
  int[] nums = {5, 2, 7, 5, 3, 2, 5, 8, 2, 9, 1};
  int zoek = 5;
  int tel = 0;
  
  for (int i = 0; i < nums.length; i++) {
    if (nums[i] == zoek) {
      tel++;
    }
  }
  
  println("het waarde " + zoek + " zie j " + tel + " keer");
}
