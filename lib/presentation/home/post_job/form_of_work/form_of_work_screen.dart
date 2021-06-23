import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/post_job/job_location/job_location_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/type_of_work/type_of_work_screen.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';

class FormOfWorkScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Đăng việc',
          ),
        ),
        body: Obx(
          () => controller.formOfWorks.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hình thức làm việc',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.formOfWorks.length,
                          itemBuilder: (context, index) {
                            var formOfWork = controller.formOfWorks[index];
                            return ItemWork(
                                title: formOfWork.name,
                                onTap: () {
                                  controller.formId.value = formOfWork.id;
                                  controller.getProvinces();
                                  Get.to(() => JobLocationScreen(id: 1,controller: controller,));
                                });
                          })
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
