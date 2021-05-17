import 'dart:convert';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/account_request.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  ProfileController(
      {this.apiRepositoryInterface, this.localRepositoryInterface});

  var isLoading = false.obs;
  RxString imageURL = ''.obs;
  RxList<Service> services = <Service>[].obs;
  RxList<Service> servicesSelected = <Service>[].obs;

  RxList<Skill> skills = <Skill>[].obs;
  RxList<Skill> skillsSelected = <Skill>[].obs;
  RxList<Level> levels = <Level>[].obs;


  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlPhoneNumber = TextEditingController();
  TextEditingController ctrlTile = TextEditingController();
  TextEditingController ctrlWebsite = TextEditingController();
  TextEditingController ctrlDescription = TextEditingController();
  TextEditingController ctrlSpecializeId = TextEditingController();
  RxInt specialtyId = 0.obs;
  RxBool isReady = true.obs;
  RxBool isChange = false.obs;
  RxInt formOnWorkId = 0.obs;
  RxInt levelId = 0.obs;


  Future<void> uploadProfile(int id) async {
    try {
      await apiRepositoryInterface.putAccount(
          id,
          AccountRequest(
            name: ctrlName.text,
            description: ctrlDescription.text,
            onReady: isReady.value,
            formOnWorkId: formOnWorkId.value,
            levelId: levelId.value,
            phone: ctrlPhoneNumber.text,
            roleId: 2,
            website: ctrlWebsite.text,
            services: servicesSelected,
            skills: skillsSelected,
            speccializeid: specialtyId.value,
            tile: ctrlTile.text,
          ));
    } catch (e) {
      print('Lỗi $e');
    }
  }

  Future uploadAvatar(ImageSource imageSource) async {
    try {
      var pickedFile = await ImagePicker().getImage(source: imageSource);
      isLoading(true);
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);
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
        Get.snackbar('Failed', 'Image not selected',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } catch (e) {
      print('lỗi ${e.toString()}');
      isLoading(false);

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
    services.clear();
    final result = await apiRepositoryInterface.getServices();
    services.assignAll(result);
  }

  Future getSkills() async {
    skills.clear();
    final result = await apiRepositoryInterface.getSkills();
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
