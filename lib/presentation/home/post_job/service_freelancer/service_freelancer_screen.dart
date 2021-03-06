import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/presentation/home/post_job/job_description/job_description_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';

class ServiceFreelancer extends StatelessWidget {
  final controller = Get.find<PostJobController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Đăng việc',
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Text(
                'Chọn dịch vụ phù hợp với yêu cầu tuyển freelancer của bạn nhất',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: controller.services.length,
                    itemBuilder: (context, index) {
                      Service service = controller.services[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.serviceId.value = service.id;
                              controller.serviceTextController.text = service.name;
                              Get.to(() => JobDescriptionScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
                              child: Row(
                                children: [
                                  Text(
                                    service.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                     Icon(Icons.keyboard_arrow_right,color: Colors.blue,),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
