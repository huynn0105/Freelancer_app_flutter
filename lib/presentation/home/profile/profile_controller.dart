import 'dart:convert';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class ProfileController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  ProfileController(
      {this.apiRepositoryInterface});


  RxString imageURL = ''.obs;
  RxList<Service> services = <Service>[].obs;
  RxList<Service> servicesSelected = <Service>[].obs;
  var progressState = sState.initial.obs;
  RxList<Skill> skills = <Skill>[].obs;
  RxList<Skill> skillsSelected = <Skill>[].obs;
  RxList<Level> levels = <Level>[].obs;


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

  Future uploadAvatar(ImageSource imageSource) async {
    try {
      var pickedFile = await ImagePicker().getImage(source: imageSource);
      isChange(false);
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      print('path: ${pickedFile.path}');
      if (pickedFile != null) {
        var result = await apiRepositoryInterface.uploadAvatar(
          ImageRequest(
            name: pickedFile.path.split("/").last,
            imageBase64: base64Image,
          ),
        );
        if (result != null) {
          imageURL.value = result;
          isChange(true);
        }

      } else {
        Get.snackbar('Lỗi', 'Tệp không được chọn',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
        isChange(false);
      }
    } catch (e) {
      print('lỗi ${e.toString()}');
      isChange(false);
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

  Future getServices() async{
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

  Future getLevel() async{
    try{
      final result = await apiRepositoryInterface.getLevels();
      levels.assignAll(result);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }
  

  @override
  void onReady() {
    getLevel();
    super.onReady();
  }
}
