import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
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


  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlPhoneNumber = TextEditingController();
  TextEditingController ctrlTile = TextEditingController();
  TextEditingController ctrlWebsite = TextEditingController();
  TextEditingController ctrlDescription = TextEditingController();
  TextEditingController ctrlSpecialty = TextEditingController();
  RxInt specialtyId = 0.obs;
  RxBool isReady = true.obs;
  RxBool isChange = false.obs;
  RxInt formOfWorkId = 0.obs;
  RxInt levelId = 0.obs;


    void uploadProfile(int id)  {
    try {
      progressState(sState.loading);
      var freelancerSkills =  skillsSelected.where((e) => e.isValue == true).toList();
      var freelancerServices =  servicesSelected.where((e) => e.isValue == true).toList();
       apiRepositoryInterface.putAccount(
          id,
          AccountRequest(
            name: ctrlName.text,
            roleId: 2,
            phone: ctrlPhoneNumber.text,
            tile: ctrlTile.text,
            description: ctrlDescription.text,
            website: ctrlWebsite.text,
            specialtyId: specialtyId.value,
            levelId: levelId.value,
            onReady: isReady.value,
            formOfWorkId: formOfWorkId.value,
            skills: freelancerSkills,
            services: freelancerServices,
          ));
      progressState(sState.initial);
    } catch (e) {
      print('Lỗi $e');
      progressState(sState.failure);
    }
  }

  Future loadFormOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getFormOfWorks();
      formOfWorks.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadSpecialties() async {
    try {
      specialties.clear();
      final result = await apiRepositoryInterface.getSpecialties();
      specialties.assignAll(result);
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
    List<Service> result = await apiRepositoryInterface.getServices();
     result.forEach((element) {
      servicesSelected.forEach((e){
        if(e.id == element.id){
          element.isValue = true;
          return;
        }
      });
    });
    services.assignAll(result);

  }

  void getSkills() async {
    final result = await apiRepositoryInterface.getSkills();
    result.forEach((element) {
      skillsSelected.forEach((e){
        if(e.id == element.id){
          element.isValue = true;
          return;
        }
      });
    });
    skills.assignAll(result);
  }

  Future loadLevel() async{
    try{
      final result = await apiRepositoryInterface.getLevels();
      levels.assignAll(result);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }
  

  @override
  void onReady() {
    loadLevel();
    loadFormOfWorks();
    super.onReady();
  }
}
