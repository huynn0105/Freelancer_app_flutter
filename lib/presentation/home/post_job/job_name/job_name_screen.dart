import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/service_freelancer/service_freelancer_screen.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:get/get.dart';

class JobNameScreen extends StatelessWidget {
  final controller = Get.find<PostJobController>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var enable = false;
  JobNameScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Job',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              formKey.currentState.validate()
                  ? Get.to(() => ServiceFreelancer())
                  : null;
            },
            child: Text(
              'Next',
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
                "Great! Let's give your job a name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InputText(
                hint: 'e.g I need a designer for my cafe webs...',
                controller: controller.nameTextController,
                maxLength: 50,
                validator: MinLengthValidator(10,
                    errorText: 'Pleases enter at least 10 characters,'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
