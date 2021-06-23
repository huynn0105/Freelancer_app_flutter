import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class ProfileController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProfileController(
      {this.apiRepositoryInterface});



  RxList<Service> services = <Service>[].obs;
  RxList<Service> servicesSelected = <Service>[].obs;
  var progressState = sState.initial.obs;
  RxList<Skill> skills = <Skill>[].obs;
  RxList<Skill> skillsSelected = <Skill>[].obs;
  RxList<Level> levels = <Level>[].obs;
  RxList<FormOfWork> formOfWorks = <FormOfWork>[].obs;
  RxList<Specialty> specialties = <Specialty>[].obs;
  RxList<Province> provinces = <Province>[].obs;

  Rx<Province> province = Province().obs;

  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlPhoneNumber = TextEditingController();
  TextEditingController ctrlTitle = TextEditingController();
  TextEditingController ctrlWebsite = TextEditingController();
  TextEditingController ctrlDescription = TextEditingController();
  TextEditingController ctrlSpecialty = TextEditingController();
  TextEditingController ctrlProvince = TextEditingController();
  RxInt specialtyId = 0.obs;
  RxBool isChange = false.obs;
  RxInt levelId = 0.obs;


    Future<bool> uploadProfile(int id) async {
    try {
      progressState(sState.loading);
      var freelancerSkills =  skillsSelected.where((e) => e.isValue == true).toList();
      var freelancerServices =  servicesSelected.where((e) => e.isValue == true).toList();
      var rs =  await apiRepositoryInterface.putAccount(
          id,
          AccountRequest(
            name: ctrlName.text,
            roleId: 2,
            phone: ctrlPhoneNumber.text,
            provinceID: province.value.provinceId,
            tile: ctrlTitle.text,
            description: ctrlDescription.text,
            website: ctrlWebsite.text,
            specialtyId: specialtyId.value,
            levelId: levelId.value,
            skills: freelancerSkills,
            services: freelancerServices,
          ));
      if(rs == 200){
        progressState(sState.initial);
        return true;
      }else{
        progressState(sState.failure);
        return false;
      }


    } catch (e) {
      print('Lỗi $e');
      progressState(sState.failure);
      Get.snackbar('Thất bại', 'Server bận, thử lại sau!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: 600,
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }
  Future loadProvinces() async {
    try {
     await apiRepositoryInterface.getProvinces().then((value) => provinces.addAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }


  Future loadSpecialties() async {
    try {
      await apiRepositoryInterface.getSpecialties().then((value) =>  specialties.assignAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  void changeValueService(Service service, List<Service> serviceList) {
    final List<Service> updatedListService = serviceList.map((e) {
      return e.id == service.id ? service : e;
    }).toList();
    serviceList.assignAll(updatedListService);
  }

  void changeValueSkill(Skill skill, List<Skill> skillList) {
    final List<Skill> updatedListSkill = skillList.map((e) {
      return e.id == skill.id ? skill : e;
    }).toList();
    skillList.assignAll(updatedListSkill);
  }

  void selectedServices() {
    servicesSelected.clear();
    final List<Service> updatedServices =
    services.where((e) => e.isValue == true).toList();
    servicesSelected.assignAll(updatedServices);
  }

  void selectedSkills() {
    skillsSelected.clear();
    final List<Skill> updatedSkills =
    skills.where((e) => e.isValue == true).toList();
    skillsSelected.assignAll(updatedSkills);
  }

  Future loadServices() async{
    await apiRepositoryInterface.getServices().then((value){
      value.forEach((element) {
        servicesSelected.forEach((e){
          if(e.id == element.id){
            element.isValue = true;
            return;
          }
        });
      });
      services.assignAll(value);
    });


  }

  void getSkills() async {
    await apiRepositoryInterface.getSkills().then((value){
      value.forEach((element) {
        skillsSelected.forEach((e){
          if(e.id == element.id){
            element.isValue = true;
            return;
          }
        });
      });
      skills.assignAll(value);
    });

  }

  Future loadLevel() async{
    try{
     await apiRepositoryInterface.getLevels().then((value) => levels.assignAll(value));
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }
  

  @override
  void onReady() {
    loadLevel();
    super.onReady();
  }
}
