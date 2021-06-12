import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  AdminController({this.apiRepositoryInterface, this.localRepositoryInterface});

  RxList<Specialty> specialties = <Specialty>[].obs;

  RxList<Skill> skills = <Skill>[].obs;

  RxInt indexSelected = 0.obs;

  var progressState = sState.loading.obs;

  RxList<Job> jobs = <Job>[].obs;

  Rx<Job> job = Job().obs;

  RxList<Service> services = <Service>[].obs;



  RxList<Account> freelancers = <Account>[].obs;
  Rx<Account> freelancer = Account().obs;

  final ctrlName = TextEditingController();
  final ctrlSubName = TextEditingController();

  RxList<Service> servicesSelected = <Service>[].obs;
  RxList<Specialty> specialtiesSelected = <Specialty>[].obs;

  RxString base64img = ''.obs;
  RxString nameImage = ''.obs;

  Future uploadImage() async {
    try {
      var pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        base64img(base64Encode(bytes));
        nameImage(pickedFile.path.split("/").last);
      }
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future loadServices() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getServices().then((value){
        services.assignAll(value);
        if(servicesSelected.isNotEmpty){
          value.forEach((element) {
            specialtiesSelected.forEach((e) {
              if (e.id == element.id) {
                element.isValue = true;
                return;
              }
            });
          });
        }
        return progressState(sState.initial);
      });

    } catch (e) {
      print('lỗi ${e.toString()}');
      progressState(sState.initial);
    }
  }

  void updateIndexSelected(int index) {
    print(indexSelected.value);
    indexSelected(index);
  }

  Future loadJobFromId(jobId) async {
    try {
      await apiRepositoryInterface.getJobFromId(jobId).then((value) {
        job(value);
        return job.value;
      });
    } catch (e) {
      print('Lỗi $e');
    }
  }

  Future loadJobs() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getJobs().then((value){
        jobs.assignAll(value);
        progressState(sState.initial);
      });
    } catch (e) {
      progressState(sState.failure);
      print('Lỗi $e');
    }
  }

  Future loadSpecialties() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getSpecialties().then((value){
        specialties.assignAll(value);
        progressState(sState.initial);
        value.forEach((element) {
          servicesSelected.forEach((e) {
            if (e.id == element.id) {
              element.isValue = true;
              return;
            }
          });
        });
      });

    } catch (e) {
      progressState(sState.initial);
      print('lỗi ${e.toString()}');
    }
  }

  void sendSpecialty() async {
    try {
      await apiRepositoryInterface.postSpecialty(
          ctrlName.text, nameImage.value, base64img.value, servicesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future sendService() async {
    try {
      await apiRepositoryInterface.postService(
          ctrlName.text, specialtiesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future sendSkill() async {
    try {
      await apiRepositoryInterface.postSkill(
          ctrlName.text);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future updateSkill(int id) async {
    try {
      await apiRepositoryInterface.putSkill(id,
          ctrlName.text);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }


  Future updateService(int id) async {
    try {
      await apiRepositoryInterface.putService(id,
          ctrlName.text,specialtiesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future updateSpecialty(int id) async {
    try {
      await apiRepositoryInterface.putSpecialty(id, ctrlName.text,
          nameImage.value, base64img.value, servicesSelected);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }

  void changeValueService(Service service) {
    final List<Service> updatedSkill = services.map((e) {
      return e.id == service.id ? service : e;
    }).toList();
    services.assignAll(updatedSkill);
  }

  void changeValueSpecialty(Specialty specialty) {
    final List<Specialty> updatedSpecialty = specialties.map((e) {
      return e.id == specialty.id ? specialty : e;
    }).toList();
    specialties.assignAll(updatedSpecialty);
  }

  void selectedList(List listSelected, List list) {
    listSelected.clear();
    final List updatedServices = list.where((e) => e.isValue == true).toList();
    listSelected.assignAll(updatedServices);
  }

  Future loadFreelancers() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getAccounts().then((value){
        if (value != null) {
          freelancers.assignAll(value);
        }
        progressState(sState.initial);
      });

    } catch (e) {
      progressState(sState.failure);
    }
  }

  Future loadFreelancerFromId(int freelancerId) async {
    try {
      return await apiRepositoryInterface.getAccountFromId(freelancerId);
    } catch (e) {
      print('lỗi: ${e.toString()}');
    }
  }

  Future loadSkills() async {
    progressState(sState.loading);
    try {
      await apiRepositoryInterface.getSkills().then((value){
        skills.assignAll(value);
        progressState(sState.initial);
      });
    } catch (e) {
      print('lỗi ${e.toString()}');
      progressState(sState.failure);
    }
  }
}
