import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
class BrowseController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  BrowseController({this.apiRepositoryInterface});

  RxInt jobTypeId = 0.obs;
  RxInt levelId = 0.obs;
  RxList<Level> levels = <Level>[].obs;
  RxList<FormOfWork> formOfWorks = <FormOfWork>[].obs;

  Future getLevel() async{
    try{
      final result = await apiRepositoryInterface.getLevels();
      levels.assignAll(result);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }
  void getFormOfWorks() async {
    try{
      final result = await apiRepositoryInterface.getFormOfWorks();
      formOfWorks.assignAll(result);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }


  @override
  void onReady() {
    getLevel();
    getFormOfWorks();
    super.onReady();
  }
}