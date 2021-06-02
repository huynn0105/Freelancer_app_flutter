import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
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
  RxList<FormOfWork> formOfWorks = <FormOfWork>[FormOfWork(id: -1,name: 'Tất cả')].obs;
  RxList<TypeOfWork> typeOfWorks = <TypeOfWork>[TypeOfWork(id: -1,name: 'Tất cả')].obs;
  RxList<Service> services = <Service>[Service(id: -1,name: 'Tất cả')].obs;
  RxList<Specialty> specialties = <Specialty>[Specialty(id: -1,name: 'Tất cả')].obs;
  RxList<PayForm> payForms = <PayForm>[PayForm(id: -1,name: 'Tất cả')].obs;
  RxBool isSearching = false.obs;
  RxString searchQuery = "Search query".obs;
  TextEditingController searchQueryController = TextEditingController();
  TextEditingController floorPriceTextController = TextEditingController();
  TextEditingController cellingPriceTextController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  RxList<Province> provinces = <Province>[Province(provinceId: '-01',name: 'Tất cả')].obs;
  RxString provinceId = ''.obs;


  Rx<Service> service = Service(id: -1,name: 'Tất cả').obs;
  Rx<FormOfWork> formOfWork = FormOfWork(id: -1,name: 'Tất cả').obs;
  Rx<TypeOfWork> typeOfWork = TypeOfWork(id: -1,name: 'Tất cả').obs;
  Rx<PayForm> payForm = PayForm(id: -1,name: 'Tất cả').obs;
  Rx<Specialty> specialty = Specialty(id: -1,name: 'Tất cả').obs;
  Rx<Province> province = Province(provinceId: '-01',name: 'Tất cả').obs;

  @override
  void onReady() {
    loadFormOfWorks();
    loadTypeOfWorks();
    loadSpecialties();
    loadServices();
    loadPayForms();
    loadProvinces();
    super.onReady();
  }



  void loadFormOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getFormOfWorks();
      formOfWorks.addAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadTypeOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getTypeOfWorks();
      typeOfWorks.addAll(result);
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
      provinces.addAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
  Future loadServices() async {
    try {
      final result = await apiRepositoryInterface.getServices();
      services.addAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
  Future loadSpecialties() async {
    try {
      final result = await apiRepositoryInterface.getSpecialties();
      specialties.addAll(result);

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
  Future loadPayForms() async {
    try {
      final result = await apiRepositoryInterface.getPayForms();
      payForms.addAll(result);

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
}