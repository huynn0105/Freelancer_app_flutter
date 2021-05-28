import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/home/post_job/job_skills/job_skills_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/post_job_detail.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobDescriptionScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();
  final dateTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        bottom: MyLinearProgressIndicator(
          value: 0.2,
        ),
        title: Text(
          'Thông tin đầy đủ về yêu cầu tuyển dụng',
        ),

        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                controller.getSkills();
                Get.to(() => JobSkillsScreen(id: 1));
              }
            },
            child: Text(
              'Tiếp theo',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Nội dung chi tiết, và các đầu việc cần Freelancer thực hiện (càng chi tiết, freelancer càng có đầy đủ thông tin để gửi báo giá chính xác hơn)",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputText(
                    maxLines: 10,
                    controller: controller.descriptionTextController,
                    maxLength: 1000,
                    validator: MinLengthValidator(20,
                        errorText: 'Vui lòng nhập ít nhất 20 ký tự')),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Hạn chót nhận hồ sơ',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context, controller);
                      },
                      style: TextStyle(fontSize: 18),
                      controller: controller.deadlineTextController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blue,
                        ),
                        suffixStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                        suffixText: 'Chọn ngày',
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> selectDate(
    BuildContext context, PostJobController controller) async {
  final df = new DateFormat('dd-MM-yyyy');
  final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.today.value,
      firstDate: DateTime(2021),
      lastDate: DateTime(2050));
  if (pickedDate != null &&
      pickedDate != controller.today.value &&
      pickedDate.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
    controller.today.value = pickedDate.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    controller.deadlineTextController.text = df.format(controller.today.value);
  }
}
