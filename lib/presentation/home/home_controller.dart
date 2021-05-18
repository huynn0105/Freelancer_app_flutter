import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;


  HomeController({this.apiRepositoryInterface,this.localRepositoryInterface});


  Rx<Account> account = Account().obs;
  RxInt indexSelected = 0.obs;
  RxList<Skill> skillsFreelancer = <Skill>[].obs;
  RxString level = ''.obs;


  @override
  void onReady() {

    super.onReady();
  }
  @override
  void onInit() async{
    super.onInit();
    await loadAccount();
    await getLevelFromId();
  }

  Future<void> loadAccount() async {
   try {
     var user = await apiRepositoryInterface.getAccountFromToken();
     if(user!=null){
       account.value = user;
       print('account: ${account.value.name}');
     }else if(user == null){
       print('lỗi: user null');
       Get.offAllNamed(Routes.login);
     }
   }catch(e){
     print('lỗi: user ${e.toString()}');
     Get.offAllNamed(Routes.login);
   }
  }

  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }



  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }



  Future getLevelFromId()async{
    try{
      Level result = await apiRepositoryInterface.getLevelFromId(account.value.levelId);
      level(result.name);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }



}