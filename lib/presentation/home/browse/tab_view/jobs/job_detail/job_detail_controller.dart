import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class JobDetailController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;
  final int jobId;


  JobDetailController({this.apiRepositoryInterface,this.jobId});
  var progressState = sState.loading.obs;
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController expectedDayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController todoListController = TextEditingController();

  Rx<Job> job = Job().obs;

  void loadJob() async {
    try {
      progressState(sState.loading);
      await apiRepositoryInterface.getJobFromId(jobId).then((value) {
        if(value!=null){
          job(value);
          progressState(sState.initial);
        }else
          progressState(sState.failure);
      });
    }catch(e){
      print('lỗi: $e');
      progressState(sState.failure);
    }

  }

  void sendOffer() async{
    try{
      await apiRepositoryInterface.postOfferHistories(OfferRequest(
          jobId: job.value.id,
          freelancerId: CURRENT_ID,
          offerPrice: int.parse(offerPriceController.text.replaceAll(',','')),
          expectedDay: expectedDayController.text + 'Ngày',
          description: descriptionController.text,
          todoList: todoListController.text
      )).then((value){
        if (value) {
          Get.offAllNamed(Routes.home);
          Get.snackbar('Thành công', 'Gửi chào giá thành công',
              backgroundColor: Colors.green,
              colorText: Colors.white,
              maxWidth: 600,
              snackPosition: SnackPosition.TOP);

        } else {
          Get.snackbar('Thất bại!', 'Thử lại sau!',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              maxWidth: 600,
              snackPosition: SnackPosition.TOP);
        }
      });
    }catch(e){
      print('lỗi: $e');
      Get.snackbar('Thất bại!', 'Thử lại sau!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: 600,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  void onReady() {
    loadJob();
    super.onReady();
  }
}