import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
class FilterController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  FilterController({this.apiRepositoryInterface});

  var currentRangeValues = RangeValues(20, 30).obs;

  RxInt jobTypeId = 0.obs;
  RxInt levelId = 0.obs;
  RxInt typeOfWorkId = 0.obs;
  RxList<Level> levels = <Level>[].obs;
  RxList<FormOfWork> formOfWorks = <FormOfWork>[].obs;
  RxList<TypeOfWork> typeOfWorks = <TypeOfWork>[].obs;
  RxBool isSearching = false.obs;
  RxString searchQuery = "Search query".obs;
  TextEditingController searchQueryController = TextEditingController();
  TextEditingController floorPriceTextController = TextEditingController();
  TextEditingController cellingPriceTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  RxList<Province> provinces = <Province>[].obs;
  RxString provinceId = ''.obs;
  @override
  void onReady() {
    getLevel();
    getFormOfWorks();
    getTypeOfWorks();
    super.onReady();
  }

  Future getLevel() async {
    try {
      final result = await apiRepositoryInterface.getLevels();
      levels.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  void getFormOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getFormOfWorks();
      formOfWorks.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getTypeOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getTypeOfWorks();
      typeOfWorks.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadProject() async {
    try {
      final result = await apiRepositoryInterface.getJobs();

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
  Future loadProvinces() async {
    try {
      final result = await apiRepositoryInterface.getProvinces();
      provinces.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
}