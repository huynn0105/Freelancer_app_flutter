import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/service_freelancer/service_freelancer_screen.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';

class JobNameScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var enable = false;
  JobNameScreen({
    Key key,
  }) : super(key: key);

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
          actions: [
            TextButton(
              onPressed: () {
                if(formKey.currentState.validate())
                  Get.to(() => ServiceFreelancer());
              },
              child: Text(
                'Tiếp theo',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Đặt tên cụ thể cho công việc cần tuyển",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InputText(
                  hint: 'VD: Thiết kế App bán hàng cao cấp',
                  controller: controller.nameTextController,
                  maxLength: 100,
                  validator: MinLengthValidator(10,
                      errorText: 'Nhập ít nhất 10 ký tự'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
