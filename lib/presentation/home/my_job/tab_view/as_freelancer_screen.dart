import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/dashboard/widget/project.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:get/get.dart';
class AsFreelancerScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    var _listTextTabToggle = ["Đã nhận", "Đang nhận", "Chào giá", "Đã qua"];
    return Obx(
      ()=> Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kDefaultPadding/2,),
              FlutterToggleTab(
                borderRadius: 10,
                height: 30,
                initialIndex: controller.tabSelectedFreelancer.value,
                isScroll: false,
                selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
                selectedIndex: controller.tabSelectedFreelancer.value,
                selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                unSelectedTextStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                labels: _listTextTabToggle,
                selectedLabelIndex: (int) {
                  controller.tabSelectedFreelancer(int);
                  if (controller.jobsFreelancer[int].isEmpty)
                    controller.loadJobsFreelancer(int);
                },
              ),
              Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: controller.progressState.value == sState.initial
                    ? controller.jobsFreelancer[controller.tabSelectedFreelancer.value].isNotEmpty
                    ? ListView.builder(
                    itemCount: controller.jobsFreelancer[controller.tabSelectedFreelancer.value].length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return MyJobCard(
                        jobOffer: controller.jobsFreelancer[controller.tabSelectedFreelancer.value][index],
                      );
                    }) : Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/postjob.jpg',
                        height: 250,
                      ),
                      Text(
                        'Bạn chưa có việc nào!',
                        style: TextStyle(fontSize: 18),
                      ),
                      ElevatedButton(
                        child: Text('Tìm việc ngay'),
                        onPressed: () {
                          controller.updateIndexSelected(1);
                        },
                      )
                    ],
                  ),
                ) : Padding(
              padding: const EdgeInsets.only(top: 100),
          child: Center(child: CircularProgressIndicator(),),
        )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
