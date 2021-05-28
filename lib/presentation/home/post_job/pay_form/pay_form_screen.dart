import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
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
          'Hình thức trả lương',
        ),
      ),
      body: Obx(
        ()=> controller.payForms.isNotEmpty ? Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ngân sách dự kiến chi cho công việc này',
                style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 24),
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
