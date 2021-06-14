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
import 'package:freelance_app/presentation/home/post_job/successful/successful_screen.dart';
import 'package:get/get.dart';

class PostJobController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  PostJobController({this.apiRepositoryInterface});

  var deadline = DateTime.now().obs;
  RxList<Specialty> specialties = <Specialty>[].obs;
  RxList<Service> services = <Service>[].obs;
  RxList<Skill> skills = <Skill>[].obs;
  RxList<TypeOfWork> typeOfWorks = <TypeOfWork>[].obs;
  RxList<FormOfWork> formOfWorks = <FormOfWork>[].obs;
  RxList<PayForm> payForms = <PayForm>[].obs;
  RxList<Province> provinces = <Province>[Province(provinceId: null,name: 'Toàn quốc')].obs;
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

  Future postJob() async {
    try {
      progressState(sState.loading);
       await apiRepositoryInterface.postJob(PostJobRequest(
        name: nameTextController.text,
        details: descriptionTextController.text,
        typeId: typeId.value,
        formId: formId.value,
        workatId: workAtId.value,
        deadline: deadline.value,
        floorprice: int.parse(floorPriceTextController.text.replaceAll(',', '')),
        cellingprice: int.parse(cellingPriceTextController.text.replaceAll(',', '')),
        isPrivate: isPrivate.value ? 1 : 0,
        specialtyId: specialtyId.value,
        serviceId: serviceId.value,
        provinceId: provinceId.value,
        payformId: payFormId.value,
        skills: skillsSelected,
      )).then((value){
        progressState(sState.initial);
        if(value){
          Get.offAll(() => SuccessfulScreen());
          nameTextController.text = '';
          descriptionTextController.text = '';
          floorPriceTextController.text = '';
          cellingPriceTextController.text = '';
        }else
          Get.snackbar('Lỗi', '',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              maxWidth: 600,
              snackPosition: SnackPosition.TOP);
      });

    } catch (e) {
      print("Lỗi: ${e.toString()}");
      progressState(sState.initial);
      Get.snackbar('Lỗi', '',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: 600,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  void onInit() async {
    await loadSpecialties();
    deadlineTextController.text =
        '${deadline.value.day}/${deadline.value.month}/${deadline.value.year}';
    super.onInit();
  }

  @override
  void onReady() {
    getFormOfWorks();
    super.onReady();
  }

  Future loadSpecialties() async {
    try { await apiRepositoryInterface.getSpecialties().then((value) => specialties.assignAll(value));
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getSpecialtyServices(int specialtyId) async {
    try {

          await apiRepositoryInterface.getSpecialtyServices(specialtyId).then((value) => services.assignAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getSkills() async {
    try {
      await apiRepositoryInterface.getSkills().then((value) => skills.assignAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getTypeOfWorks() async {
    try {
       await apiRepositoryInterface.getTypeOfWorks().then((value) => typeOfWorks.assignAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getFormOfWorks() async {
    try {
      await apiRepositoryInterface.getFormOfWorks().then((value) =>  formOfWorks.assignAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getPayForms() async {
    try {
     await apiRepositoryInterface.getPayForms().then((value) => payForms.assignAll(value));

    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  Future getProvinces() async {
    try {
      await apiRepositoryInterface.getProvinces().then((value) => provinces.addAll(value));

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
