
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(
      apiRepositoryInterface: Get.find(),
      localRepositoryInterface: Get.find(),
    ));
  }
}