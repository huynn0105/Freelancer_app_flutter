import 'package:freelance_app/data/data_source/api_repository_impl.dart';
import 'package:freelance_app/data/data_source/local_repository_impl.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl(), fenix: true);
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl(), fenix: true);
  }

}