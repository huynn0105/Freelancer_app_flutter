import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';

class FreelancerController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;

  FreelancerController({this.apiRepositoryInterface});

  RxList<Account> freelancers = <Account>[].obs;
  var progressState = sState.loading.obs;

  Future loadFreelancer() async {
    progressState(sState.loading);
    final result = await apiRepositoryInterface.getAccounts();
    if(result !=null){
      freelancers.assignAll(result);
    }
    progressState(sState.initial);
  }

  @override
  void onReady() {
    //loadFreelancer();
    super.onReady();
  }

}