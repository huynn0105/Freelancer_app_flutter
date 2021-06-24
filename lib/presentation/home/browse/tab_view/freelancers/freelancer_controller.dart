import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/rating_request.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/requests/search_request.dart';

class FreelancerController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;

  FreelancerController({this.apiRepositoryInterface});

  RxList<Account> freelancers = <Account>[].obs;
  var progressState = sState.loading.obs;


  RxString provinceId = '00'.obs;
  RxBool isSearching = false.obs;
  TextEditingController searchQueryController = TextEditingController();

  Rx<Level> level = Level(id: 0,name: 'Tất cả').obs;
  RxList<Level> levels = <Level>[Level(id: 0,name: 'Tất cả')].obs;

  Rx<Province> province = Province(provinceId: '00',name: 'Tất cả').obs;
  RxList<Province> provinces = <Province>[Province(provinceId: '00',name: 'Tất cả')].obs;

  Rx<Specialty> specialty =  Specialty(id: 0,name: 'Tất cả').obs;
  RxList<Specialty> specialties = <Specialty>[Specialty(id: 0,name: 'Tất cả')].obs;

  Rx<Service> service =  Service(id: 0,name: 'Tất cả').obs;
  RxList<Service> services = <Service>[Service(id: 0,name: 'Tất cả')].obs;

  void sendSearch() async{
    progressState(sState.loading);
    try{
      await apiRepositoryInterface.searchFreelancer(SearchRequest(
          provinceId: province.value.provinceId,
          levelId: level.value.id,
          search: searchQueryController.text,
          serviceId: service.value.id,
          specialtyId: specialty.value.id
      )).then((value){
        if(value!=null){
          freelancers.assignAll(value);
          progressState(sState.initial);
        }
      });
    }catch(e){
      print('lỗi: $e');
      progressState(sState.failure);
    }
  }

  Future loadServices() async {
    try {
      await apiRepositoryInterface.getServices().then((value) => services.addAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadSpecialties() async {
    try {
      await apiRepositoryInterface.getSpecialties().then((value) => specialties.addAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }


  Future loadProvinces() async {
    try {
      await apiRepositoryInterface.getProvinces().then((value) => provinces.addAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }
  Future loadLevels() async {
    try {
     await apiRepositoryInterface.getLevels().then((value) => levels.addAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }



  Future loadFreelancer() async {
    progressState(sState.loading);
    try{
      await apiRepositoryInterface.getAccounts().then((value){
        if(value !=null){
          freelancers.assignAll(value);
        }
        progressState(sState.initial);
      });
    }catch(e){
      print("lỗi: $e");
      progressState(sState.failure);
    }
  }

  @override
  void onReady() {
    loadFreelancer();
    super.onReady();
  }



}