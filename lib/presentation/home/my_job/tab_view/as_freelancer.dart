import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/dashboard/widget/project.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
class AsFreelancerScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Tất cả", "Đang làm", "Đã hoàn thành", "Đã huỷ"];
    return Obx(
      ()=> Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding/2,),
              FlutterToggleTab(
                // width in percent
                borderRadius: 10,
                height: 30,
                initialIndex: 0,
                selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                unSelectedTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                labels: _listTextTabToggle,
                selectedLabelIndex: (index) {

                },
                isScroll: false,
              ),
              Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: controller.account.value.jobRenters.isNotEmpty ? ListView.builder(
                    itemCount: controller.account.value.jobRenters.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return MyJobCard(
                        job: controller.account.value.jobRenters[index],
                      );
                    }) : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
