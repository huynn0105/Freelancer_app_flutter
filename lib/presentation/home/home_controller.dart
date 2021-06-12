import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  HomeController({this.apiRepositoryInterface, this.localRepositoryInterface});

  RxString imageURL = ''.obs;
  var progressState = sState.initial.obs;
  Rx<Account> account = Account().obs;
  RxInt indexSelected = 0.obs;
  RxList<Skill> skillsFreelancer = <Skill>[].obs;
  RxString level = ''.obs;
  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;
  RxBool accountOnReady = true.obs;
  List<RxList<Job>> jobsRenter = <RxList<Job>>[<Job>[].obs,<Job>[].obs,<Job>[].obs,<Job>[].obs];

  List<RxList<JobOffer>> jobsFreelancer = <RxList<JobOffer>>[<JobOffer>[].obs,<JobOffer>[].obs,<JobOffer>[].obs,<JobOffer>[].obs];
  var tabSelectedRenter = 0.obs;
  var tabSelectedFreelancer = 0.obs;

  @override
  void onReady() async {
    await loadAccountLocal();
    accountOnReady(account.value.onReady);
    loadJobsRenter(tabSelectedRenter.value);
    loadJobsFreelancer(tabSelectedFreelancer.value);
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadAccountFromToken() async {
    try {
      progressState(sState.loading);
     await apiRepositoryInterface.getAccountFromToken().then((value){
        progressState(sState.initial);
        if (value != null) {
          account(value);
        } else if (value == null) {
          print('lỗi: user null');
         logOut().then((value) => Get.offAllNamed(Routes.login));
        }
      });

    } catch (e) {
      print('lỗi: user ${e.toString()}');
      progressState(sState.initial);
      logOut().then((value) => Get.offAllNamed(Routes.login));
    }
  }

  Future loadAccountLocal() async {
    progressState(sState.loading);
    await localRepositoryInterface.getAccount().then(
      (value) {
        account(value);
      },
    );
    progressState(sState.initial);
  }

  void updateIndexSelected(int index) {
    indexSelected(index);
  }

  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }

  void getCapacityProfiles(int freelancerId) async {
    try {
          await apiRepositoryInterface.getCapacityProfiles(freelancerId).then((value) => capacityProfiles.assignAll(value));
    } catch (e) {
      print('lỗi:  ${e.toString()}');
    }
  }

  void deleteCapacityProfile(int capacityProfileId) async {
    try {

          await apiRepositoryInterface.deleteCapacityProfile(capacityProfileId);
    } catch (e) {
      print('lỗi:  ${e.toString()}');
    }
  }

  Future uploadAvatar(ImageSource imageSource) async {
    try {
      var pickedFile = await ImagePicker().getImage(source: imageSource);
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
        }
      } else {
        Get.snackbar('Lỗi', 'Tệp không được chọn',
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
  }

  void loadJobsRenter(int selected) async {
    progressState(sState.loading);
    var result;
    switch (selected) {
      case 0:
        result = await apiRepositoryInterface.getJobRenters(account.value.id);
        break;
      case 1:
        result = await apiRepositoryInterface.getJobRentersInProgress(account.value.id);
        break;
      case 2:
        result =
            await apiRepositoryInterface.getJobRentersWaiting(account.value.id);
        break;
      case 3:
        result =
            await apiRepositoryInterface.getJobRentersPast(account.value.id);
        break;
      default:
        result = await apiRepositoryInterface.getJobRenters(account.value.id);
        break;
    }

      try {
        jobsRenter[selected].assignAll(result);
        progressState(sState.initial);
      } catch (e) {
        print('lỗi ${e.toString()}');
        progressState(sState.initial);
      }

  }

  void loadJobsFreelancer(int selected) async {
    List<JobOffer> result;
    progressState(sState.loading);
    switch (selected) {
      case 0:
        result = await apiRepositoryInterface.getJobFreelancers(account.value.id);
        break;
      case 1:
        result = await apiRepositoryInterface.getJobFreelancersInProgress(account.value.id);
        break;
      case 2:
        result =
        await apiRepositoryInterface.getOfferHistories(account.value.id);
        break;
      case 3:
        result =
        await apiRepositoryInterface.getJobFreelancersPast(account.value.id);
        break;
      default:
        result = await apiRepositoryInterface.getJobFreelancers(account.value.id);
        break;
    }

      try {
        jobsFreelancer[selected].assignAll(result);
        progressState(sState.initial);
      } catch (e) {
        print('lỗi ${e.toString()}');
        progressState(sState.initial);
      }


  }

  void sendOnReady() async{
    try{
      await apiRepositoryInterface.putOnReady(account.value.id);
    }catch(e){
      print('lỗi ${e.toString()}');
    }
  }

}
