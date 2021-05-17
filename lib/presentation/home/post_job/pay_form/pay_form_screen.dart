import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/salary_money/salary_money_screen.dart';
import 'package:freelance_app/presentation/home/post_job/type_of_work/type_of_work_screen.dart';

import 'package:get/get.dart';

class PayFormScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,

      ),
      body: Obx(
        ()=> controller.payForms.isNotEmpty ? Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hình thức trả lương',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.payForms.length,
                itemBuilder: (context, index) {
                  var payForm = controller.payForms[index];
                  return ItemWork(
                    title: payForm.name,
                    onTap: () {
                      controller.payFormId.value = payForm.id;
                      Get.to(() => SalaryMoneyScreen());
                    },
                  );
                },
              )
            ],
          ),
        ) : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
