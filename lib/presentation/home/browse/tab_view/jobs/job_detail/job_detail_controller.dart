import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/offer_request.dart';
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
    progressState(sState.loading);
    var result = await apiRepositoryInterface.getJobFromId(jobId);
    job(result);
    progressState(sState.initial);
  }

  void sendOffer() async{
    await apiRepositoryInterface.postOfferHistories(OfferRequest(
        jobId: job.value.id,
        description: descriptionController.text,
        expectedDay: int.parse(expectedDayController.text),
        freelancerId: 1,
        offerPrice: int.parse(offerPriceController.text),
        todoList: todoListController.text
    ));
  }

  @override
  void onReady() {
    loadJob();
    super.onReady();
  }
}