int[] nums = {5, 2, 7, 5, 3, 2, 5, 8, 2, 9, 1};
int tel = 0;

void setup() {
  println("het waarde 5" + " zie je " + telHoeVaakGetalVoorkomt(5)  + " keer");
  println("het waarde 6" + " zie je " + telHoeVaakGetalVoorkomt(6)  + " keer");
  println("het waarde 9" + " zie je " + telHoeVaakGetalVoorkomt(9)  + " keer");
}

int telHoeVaakGetalVoorkomt(int getal) {
   for (int i = 0; i < nums.length; i++) {
    if (nums[i] == getal) {
      tel++;
    }
  }
  return tel;
}
