import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
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

  var progressState = sState.initial.obs;
  Rx<Account> account = Account().obs;
  RxInt indexSelected = 0.obs;
  RxList<Skill> skillsFreelancer = <Skill>[].obs;
  RxString level = ''.obs;
  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;

  @override
  void onReady()  {
    loadAccountLocal();
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadAccountFromToken() async {
   try {
     progressState(sState.loading);
     var user = await apiRepositoryInterface.getAccountFromToken();
     progressState(sState.initial);
     if(user!=null){
       account(user);
     }else if(user == null){
       print('lỗi: user null');
       await apiRepositoryInterface.logout();
       await localRepositoryInterface.clearData();
       Get.offAllNamed(Routes.login);
     }
   }catch(e){
     print('lỗi: user ${e.toString()}');
     progressState(sState.initial);
     await apiRepositoryInterface.logout();
     await localRepositoryInterface.clearData();
     Get.offAllNamed(Routes.login);
   }
  }

  Future loadAccountLocal() async {
    progressState(sState.loading);
    await localRepositoryInterface.getAccount().then(
          (value) {
            account(value);
      },
    );
    progressState(sState.initial);
  }

  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }

  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }

  void getCapacityProfiles(int freelancerId) async {
    try{
      final result = await apiRepositoryInterface.getCapacityProfiles(freelancerId);
      capacityProfiles.assignAll(result);
    }catch(e){
      print('lỗi:  ${e.toString()}');
    }
  }
}