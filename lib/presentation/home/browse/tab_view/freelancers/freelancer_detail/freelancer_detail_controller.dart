import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';

class FreelancerDetailController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;
  final int freelancerId;

  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;
  FreelancerDetailController({this.apiRepositoryInterface,this.freelancerId});
  var progressState = sState.loading.obs;

  Rx<Account> freelancer = Account().obs;

  void loadFreelancer() async {
    try{
      progressState(sState.loading);
     await apiRepositoryInterface.getAccountFromId(freelancerId).then((value){
        freelancer(value);
        progressState(sState.initial);
      });

    }catch(e){
     print('lỗi: ${e.toString()}');
     progressState(sState.failure);
    }
  }
  void getCapacityProfiles(int freelancerId) async {
    try{
     await apiRepositoryInterface.getCapacityProfiles(freelancerId).then((value) => capacityProfiles.assignAll(value));
    }catch(e){
      print('Lỗi: ${e.toString()}');
    }
  }

  @override
  void onReady() {
    loadFreelancer();
    super.onReady();
  }
}