import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  SplashController({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    validateSession();
    super.onReady();
  }

  void validateSession() async{
    TOKEN = await localRepositoryInterface.getToken();
    if(TOKEN!=null){
      print('home');
      print('token: $TOKEN');
      Get.offAllNamed(Routes.home);
    }else{
      print('login');
      Get.offAllNamed(Routes.login);
    }
  }
}