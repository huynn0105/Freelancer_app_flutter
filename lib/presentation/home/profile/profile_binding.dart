import 'package:freelance_app/presentation/home/profile/profile_controller.dart';
import 'package:get/get.dart';


class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find(),
    ));
  }
}