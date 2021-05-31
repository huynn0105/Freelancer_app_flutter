import 'package:get/get.dart';

class AdminController extends GetxController{
  AdminController();

  RxInt indexSelected = 0.obs;
  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }

}