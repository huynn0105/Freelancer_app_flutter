import 'dart:convert';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapacityProfileController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  CapacityProfileController({this.apiRepositoryInterface});

  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlDescription = TextEditingController();
  TextEditingController ctrlUrlWeb = TextEditingController();
  var progressState = sState.initial.obs;
  RxList<Service> services = <Service>[].obs;
  RxList<Service> servicesSelected = <Service>[].obs;
  RxList<CapacityProfile> capacityProfiles = <CapacityProfile>[].obs;
  RxString base64img = ''.obs;
  RxString nameImage = ''.obs;

  void changeValueService(Service service, List<Service> serviceList) {
    final List<Service> updatedListService = serviceList.map((e) {
      return e.id == service.id ? service : e;
    }).toList();
    serviceList.assignAll(updatedListService);
  }

  void selectedServices() {
    servicesSelected.clear();
    final List<Service> updatedServices =
        services.where((e) => e.isValue == true).toList();
    servicesSelected.assignAll(updatedServices);
  }

  Future getServices() async {
    final result = await apiRepositoryInterface.getServices();
    result.forEach((element) {
      servicesSelected.forEach((e) {
        if (e.id == element.id) {
          element.isValue = true;
          return;
        }
      });
    });
    services.assignAll(result);
  }

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

  void postCapacityProfile()  {
    try{
      progressState(sState.loading);
       apiRepositoryInterface.postCapacityProfile(
        CapacityProfile(
          name: ctrlName.text,
          description: ctrlDescription.text,
          urlweb: ctrlUrlWeb.text,
          imageName: nameImage.value,
          imageBase64: base64img.value,
          services: servicesSelected
        )
      );
      progressState(sState.initial);
      initValue();
    }catch(e){
      print('lỗi ${e.toString()}');
      progressState(sState.failure);
    }
  }

  void putCapacityProfile(int id)  {
    try{
      progressState(sState.loading);
       apiRepositoryInterface.putCapacityProfile(id,
          CapacityProfile(
              name: ctrlName.text,
              description: ctrlDescription.text,
              urlweb: ctrlUrlWeb.text,
              imageName: nameImage.value,
              imageBase64: base64img.value,
              services: servicesSelected
          )
      );
      progressState(sState.initial);
      initValue();
    }catch(e){
      print('lỗi ${e.toString()}');
      progressState(sState.failure);
    }
  }

  Future getCapacityProfiles(int freelancerId) async {
    try{
      progressState(sState.loading);
      final result = await apiRepositoryInterface.getCapacityProfiles(freelancerId);
      capacityProfiles.assignAll(result);
      progressState(sState.initial);
    }catch(e){
      progressState(sState.failure);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  void initValue(){
    ctrlDescription.text='';
    ctrlUrlWeb.text = '';
    ctrlName.text = '';
    base64img.value = '';
    nameImage.value = '';
    servicesSelected.clear();
  }
}
