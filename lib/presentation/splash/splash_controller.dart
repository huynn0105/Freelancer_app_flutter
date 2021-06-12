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
    try {
      if (TOKEN != null) {
        print('home');
        print('token: $TOKEN');
        var account = await apiRepositoryInterface.getAccountFromToken();
        await localRepositoryInterface.saveAccount(account);
        CURRENT_ID = account.id;
        if(account.role.id ==  1){
          print('admin');
        Get.offAllNamed(Routes.admin);
        }
        else {
          Get.offAllNamed(Routes.home);
          print('home');
        }
      } else {
        print('login');
        Get.offAllNamed(Routes.login);
      }
    }catch(e){
      print('lỗi: user ${e.toString()}');
      await apiRepositoryInterface.logout();
      await localRepositoryInterface.clearData();
      Get.offAllNamed(Routes.login);
    }
  }



}

