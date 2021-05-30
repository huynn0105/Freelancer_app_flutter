import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/level.dart';
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


  HomeController({this.apiRepositoryInterface,this.localRepositoryInterface});
  RxString imageURL = ''.obs;
  var progressState = sState.initial.obs;
  Rx<Account> account = Account().obs;
  RxInt indexSelected = 0.obs;
  RxList<Skill> skillsFreelancer = <Skill>[].obs;
  RxString level = ''.obs;
  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;

  @override
  void onReady()  {
    loadAccountLocal();
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadAccountFromToken() async {
   try {
     progressState(sState.loading);
     var user = await apiRepositoryInterface.getAccountFromToken();
     progressState(sState.initial);
     if(user!=null){
       account(user);
     }else if(user == null){
       print('lỗi: user null');
       await apiRepositoryInterface.logout();
       await localRepositoryInterface.clearData();
       Get.offAllNamed(Routes.login);
     }
   }catch(e){
     print('lỗi: user ${e.toString()}');
     progressState(sState.initial);
     await apiRepositoryInterface.logout();
     await localRepositoryInterface.clearData();
     Get.offAllNamed(Routes.login);
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
    print(indexSelected.value);
    indexSelected(index);
  }

  Future<void> logOut() async {
    await apiRepositoryInterface.logout();
    await localRepositoryInterface.clearData();
  }

  void getCapacityProfiles(int freelancerId) async {
    try{
      final result = await apiRepositoryInterface.getCapacityProfiles(freelancerId);
      capacityProfiles.assignAll(result);
    }catch(e){
      print('lỗi:  ${e.toString()}');
    }
  }

  void deleteCapacityProfile(int capacityProfileId) async{
    try{
      final result = await apiRepositoryInterface.deleteCapacityProfile(capacityProfileId);
    }catch(e){
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
}