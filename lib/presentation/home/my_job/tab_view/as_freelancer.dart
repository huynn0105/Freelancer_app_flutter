import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/dashboard/widget/project.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
class AsFreelancerScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        backgroundColor: Colors.grey[50],
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          child: controller.account.value.jobRenters.isNotEmpty ? ListView.builder(
              itemCount: controller.account.value.jobRenters.length,
              itemBuilder: (context,index){
                return MyJobCard(
                  job: controller.account.value.jobRenters[index],
                );
              }) : Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
