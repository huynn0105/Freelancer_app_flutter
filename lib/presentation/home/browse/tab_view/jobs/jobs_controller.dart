import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';
import 'package:freelance_app/domain/requests/search_request.dart';

class JobsController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;
   JobsController({this.apiRepositoryInterface});


  var progressState = sState.loading.obs;
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController expectedDayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController todoListController = TextEditingController();

  RxList<Job> jobs = <Job>[].obs;


  RxInt floorPrice = 0.obs;
  RxInt cellingPrice = 200000000.obs;


  RxString provinceId = '00'.obs;

  RxList<FormOfWork> formOfWorks = <FormOfWork>[FormOfWork(id: 0,name: 'Tất cả')].obs;
  RxList<TypeOfWork> typeOfWorks = <TypeOfWork>[TypeOfWork(id: 0,name: 'Tất cả')].obs;
  RxList<Service> services = <Service>[Service(id: 0,name: 'Tất cả')].obs;
  RxList<Specialty> specialties = <Specialty>[Specialty(id: 0,name: 'Tất cả')].obs;
  RxList<PayForm> payForms = <PayForm>[PayForm(id: 0,name: 'Tất cả')].obs;

  RxBool isSearching = false.obs;

  TextEditingController searchQueryController = TextEditingController();
  TextEditingController floorPriceTextController = TextEditingController();
  TextEditingController cellingPriceTextController = TextEditingController();

  RxList<Province> provinces = <Province>[Province(provinceId: '00',name: 'Tất cả')].obs;



  Rx<Service> service = Service(id: 0,name: 'Tất cả').obs;
  Rx<FormOfWork> formOfWork = FormOfWork(id: 0,name: 'Tất cả').obs;
  Rx<TypeOfWork> typeOfWork = TypeOfWork(id: 0,name: 'Tất cả').obs;
  Rx<PayForm> payForm = PayForm(id: 0,name: 'Tất cả').obs;
  Rx<Specialty> specialty = Specialty(id: 0,name: 'Tất cả').obs;
  Rx<Province> province = Province(provinceId: '00',name: 'Tất cả').obs;

  void sendSearch() async{
    progressState(sState.loading);
    try{
      await apiRepositoryInterface.searchJob(SearchRequest(
        provinceId: province.value.provinceId,
        serviceId: service.value.id,
        specialtyId: specialty.value.id,
        search: searchQueryController.text,
        floorPrice: floorPriceTextController.text.isNotEmpty ? int.parse(floorPriceTextController.text.replaceAll(',', '')) : 0,
        cellingPrice: cellingPriceTextController.text.isNotEmpty ? int.parse(cellingPriceTextController.text.replaceAll(',', '')) : 200000000,
        formOfWorkId: formOfWork.value.id,
        payFormId: payForm.value.id,
        typeOfWorkId: typeOfWork.value.id,
      )).then((value){
        jobs.assignAll(value);
        progressState(sState.initial);
      });
    }catch(e){
      print('lỗi: $e');
      progressState(sState.initial);
    }
  }

  void loadFormOfWorks() async {
    try {
      await apiRepositoryInterface.getFormOfWorks().then((value) =>  formOfWorks.addAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadTypeOfWorks() async {
    try {
      await apiRepositoryInterface.getTypeOfWorks().then((value) =>  typeOfWorks.addAll(value));
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
  Future loadServices() async {
    try {
      await apiRepositoryInterface.getServices().then((value) =>  services.addAll(value));
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
  Future loadPayForms() async {
    try {
      await apiRepositoryInterface.getPayForms().then((value) => payForms.addAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }


  Future loadJobs() async {
    progressState(sState.loading);
    try{await apiRepositoryInterface.getJobs().then((value){
      if(value!=null)
      jobs.assignAll(value);
        progressState(sState.initial);
      });
    }catch(e){
      progressState(sState.failure);
    }
  }




  @override
  void onReady() {
    loadJobs();
    super.onReady();
  }
}