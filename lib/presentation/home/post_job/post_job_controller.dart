import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/pay_form.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/post_job_request.dart';
import 'package:get/get.dart';

class PostJobController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  PostJobController({this.apiRepositoryInterface});

  var today = DateTime.now().obs;
  RxList<Specialty> specialties = <Specialty>[].obs;
  RxList<Service> services = <Service>[].obs;
  RxList<Skill> skills = <Skill>[].obs;
  RxList<TypeOfWork> typeOfWorks = <TypeOfWork>[].obs;
  RxList<FormOfWork> formOfWorks = <FormOfWork>[].obs;
  RxList<PayForm> payForms = <PayForm>[].obs;
  RxList<Province> provinces = <Province>[].obs;
  var progressState = sState.initial.obs;
  RxList<Skill> skillsSelected = <Skill>[].obs;
  RxInt specialtyId = 0.obs;
  RxInt typeId = 0.obs;
  RxInt formId = 0.obs;
  RxInt workAtId = 0.obs;
  RxInt payFormId = 0.obs;

  RxInt serviceId = 0.obs;
  RxBool isPrivate = false.obs;
  RxString provinceId = ''.obs;

  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final floorPriceTextController = TextEditingController();
  final cellingPriceTextController = TextEditingController();
  final specialtyTextController = TextEditingController();
  final serviceTextController = TextEditingController();
  final deadlineTextController = TextEditingController();
  final locationTextController = TextEditingController();

  Future<bool> postJob() async {
    try {
      progressState(sState.loading);
      final response = await apiRepositoryInterface.postJob(PostJobRequest(
        name: nameTextController.text,
        details: descriptionTextController.text,
        typeId: typeId.value,
        formId: formId.value,
        workatId: workAtId.value,
        deadline: today.value,
        floorprice: int.parse(floorPriceTextController.text),
        cellingprice: int.parse(cellingPriceTextController.text),
        isPrivate: isPrivate.value ? 1 : 0,
        specialtyId: specialtyId.value,
        serviceId: serviceId.value,
        provinceId: provinceId.value,
        payformId: payFormId.value,
        skills: skillsSelected,
      ));
      progressState(sState.initial);
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      print("Lỗi: ${e.toString()}");
      progressState(sState.initial);
      return false;
    }
  }

  @override
  void onInit() async {
    await loadSpecialties();
    deadlineTextController.text =
        '${today.value.day}/${today.value.month}/${today.value.year}';
    super.onInit();
  }

  @override
  void onReady() {
    getFormOfWorks();
    super.onReady();
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

  Future getSpecialtyServices(int specialtyId) async {
    try {
      final result =
          await apiRepositoryInterface.getSpecialtyServices(specialtyId);
      services.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getSkills() async {
    try {
      skills.clear();
      final result = await apiRepositoryInterface.getSkills();
      skills.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getTypeOfWorks() async {
    try {
      typeOfWorks.clear();
      final result = await apiRepositoryInterface.getTypeOfWorks();
      typeOfWorks.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getFormOfWorks() async {
    try {
      final result = await apiRepositoryInterface.getFormOfWorks();
      formOfWorks.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getPayForms() async {
    try {
      final result = await apiRepositoryInterface.getPayForms();
      payForms.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getProvinces() async {
    try {
      final result = await apiRepositoryInterface.getProvinces();
      provinces.assignAll(result);
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  void changeValue(Skill skill, List<Skill> skillList) {
    final List<Skill> updatedSkill = skillList.map((e) {
      return e.id == skill.id ? skill : e;
    }).toList();
    skillList.assignAll(updatedSkill);
  }

  void skillSelected() {
    skillsSelected.clear();
    final List<Skill> updatedSkill =
        skills.where((e) => e.isValue == true).toList();
    skillsSelected.assignAll(updatedSkill);
  }
}
