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
  void onReady() async {
    await loadAccount();
    await getLevelFromId();
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();

  }

  Future<void> loadAccount() async {
   try {
     var user = await apiRepositoryInterface.getAccountFromToken();
     if(user!=null){
       account.value = user;
       print('account: ${account.value.name}');
     }else{
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
    await localRepositoryInterface.clearAllData();
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