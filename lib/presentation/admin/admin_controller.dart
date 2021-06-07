import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  AdminController({this.apiRepositoryInterface});

  RxInt indexSelected = 0.obs;
  var progressState = sState.loading.obs;
  RxList<Job> jobs = <Job>[].obs;
  Rx<Job> job = Job().obs;

  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }

  Future loadJob(jobId) async {
    try{
      var result = await apiRepositoryInterface.getJobFromId(jobId);
      job(result);
      return job.value;
    }catch(e){
      print('Lỗi $e');
    }
  }

  void loadJobs() async {
    progressState(sState.loading);
    try{
      var result = await apiRepositoryInterface.getJobs();
      jobs.assignAll(result);
      progressState(sState.initial);
    }catch(e){
      progressState(sState.failure);
      print('Lỗi $e');
    }
  }
}
