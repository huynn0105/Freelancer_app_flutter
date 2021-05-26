import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';


class JobsController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;
   JobsController({this.apiRepositoryInterface});


  var progressState = sState.loading.obs;
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController expectedDayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController todoListController = TextEditingController();

  RxList<Job> jobs = <Job>[].obs;


  void loadJobs() async {
    progressState(sState.loading);
    try{
      var result = await apiRepositoryInterface.getJobs();
      jobs.assignAll(result);
      progressState(sState.initial);
    }catch(e){
      progressState(sState.failure);
    }
  }

  // void sendOffer() async{
  //   await apiRepositoryInterface.postOfferHistories(OfferRequest(
  //       jobId: job.value.id,
  //       description: descriptionController.text,
  //       expectedDay: int.parse(expectedDayController.text),
  //       freelancerId: 1,
  //       offerPrice: int.parse(offerPriceController.text),
  //       todoList: todoListController.text
  //   ));
  // }

  @override
  void onReady() {
    loadJobs();
    super.onReady();
  }
}