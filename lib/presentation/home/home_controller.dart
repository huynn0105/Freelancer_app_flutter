import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/job_offer.dart';
import 'package:freelance_app/domain/models/rating.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/image_request.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/login/login_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;
  final LocalRepositoryInterface localRepositoryInterface;

  HomeController({this.apiRepositoryInterface, this.localRepositoryInterface});
  RxInt balance = 0.obs;
  RxString imageURL = ''.obs;
  var progressState = sState.initial.obs;
  Rx<Account> account = Account().obs;
  RxInt indexSelected = 0.obs;
  RxList<Skill> skillsFreelancer = <Skill>[].obs;
  RxString level = ''.obs;
  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;
  RxBool accountOnReady = true.obs;
  List<RxList<Job>> jobsRenter = <RxList<Job>>[<Job>[].obs,<Job>[].obs,<Job>[].obs,<Job>[].obs];
  RxList<JobOffer> offers = <JobOffer>[].obs;
  RxList<Rating> ratings = <Rating>[].obs;

  List<RxList<dynamic>> jobsFreelancer = <RxList<dynamic>>[<Job>[].obs,<Job>[].obs,<JobOffer>[].obs,<Job>[].obs];
  var tabSelectedRenter = 0.obs;
  var tabSelectedFreelancer = 0.obs;

  @override
  void onReady() async {
    await loadAccountLocal();
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
          AVATAR_CURRENT = value.avatarUrl;
          accountOnReady(account.value.onReady);
          balance(account.value.balance);
        } else if (value == null) {
          print('l???i: user null');
         logOut().then((value) => Get.offAllNamed(Routes.login));
        }
      });

    } catch (e) {
      print('l???i: user ${e.toString()}');
      progressState(sState.initial);
      logOut().then((value) => Get.offAllNamed(Routes.login));
    }
  }

  Future loadAccountLocal() async {
    progressState(sState.loading);
    await localRepositoryInterface.getAccount().then(
      (value) {
        if(value!=null){
          account(value);
          accountOnReady(account.value.onReady);
          balance(account.value.balance);
        }

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

  Future getCapacityProfiles(int freelancerId) async {
    try {
          await apiRepositoryInterface.getCapacityProfiles(freelancerId).then((value){
            if(value!=null)
              capacityProfiles.assignAll(value);
          });
    } catch (e) {
      print('l???i:  ${e.toString()}');
    }
  }

  Future deleteCapacityProfile(CapacityProfile capacityProfile) async{
    try{
      await apiRepositoryInterface.deleteCapacityProfile(capacityProfile.id).then((value){
        if(value){
          Get.snackbar('Th??nh c??ng', 'Xo?? h??? s?? n??ng l???c th??nh c??ng',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            maxWidth: 600,
            colorText: Colors.white,);
        }else{
          Get.snackbar('L???i','Server l???i! Th??? l???i sau',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              maxWidth: 600,
              snackPosition: SnackPosition.TOP);
        }
          loadAccountFromToken().then((value) => Get.offAndToNamed(Routes.home));
      });
    }catch(e){
      print('l???i: $e');
    }
  }

  Future uploadAvatar(ImageSource imageSource) async {
    try {
      var pickedFile = await ImagePicker().getImage(source: imageSource);
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      var name = '';
      print('path: ${pickedFile.path}');
      if (pickedFile != null) {
        if (kIsWeb){
          name = pickedFile.path.split("/").last.replaceAll('-', '_')+'.jpg';
        }else{
          name = pickedFile.path.split("/").last;
        }
        var result = await apiRepositoryInterface.uploadAvatar(
          ImageRequest(
            name: name,
            imageBase64: base64Image,
          ),
        );
        if (result != null) {
          imageURL.value = result;
        }
      } else {
        Get.snackbar('L???i', 'T???p kh??ng ???????c ch???n',
            maxWidth: 600,
            margin: EdgeInsets.only(top: 5, left: 10, right: 10));
      }
    } catch (e) {
      print('l???i ${e.toString()}');
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
        print('l???i ${e.toString()}');
        progressState(sState.initial);
      }

  }

  Future loadOfferHistories()async{
    try{
      await apiRepositoryInterface.getOfferHistories(CURRENT_ID).then((value) => offers.assignAll(value));
    }catch(e){
      print('l???i $e');
    }
  }

  void loadJobsFreelancer(int selected) async {
    List<dynamic> result;
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
        await apiRepositoryInterface.getOfferHistoriesWaiting(account.value.id);
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
        print('l???i ${e.toString()}');
        progressState(sState.initial);
      }
  }

  void sendOnReady() async{
    try{
      await apiRepositoryInterface.putOnReady(account.value.id);
    }catch(e){
      print('l???i ${e.toString()}');
    }
  }
  
  Future deposit(int money)async{
    try{
      await apiRepositoryInterface.putDeposit(money).then((value){
        if(value==200){
          account.value.balance+=200;
        }
      });
    }catch(e){
      print('l???i $e');
    }
  }
  
  Future loadRatingFormId(int freelancerId)async{
    try{
      apiRepositoryInterface.getRatingsFreelancerId(freelancerId).then((value) => ratings.assignAll(value));
    }catch(e){
      print('l???i: $e');
    }
  }





}
