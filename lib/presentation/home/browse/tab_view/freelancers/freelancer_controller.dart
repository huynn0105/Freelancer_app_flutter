import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';

class FreelancerController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;

  FreelancerController({this.apiRepositoryInterface});

  RxList<Account> freelancers = <Account>[].obs;


  Future loadFreelancer() async {
    final result = await apiRepositoryInterface.getAccountsPagination(page: 1,count: 5);
    if(result !=null){
      freelancers.assignAll(result);
    }
  }

  @override
  void onReady() {
    loadFreelancer();
    super.onReady();
  }

}