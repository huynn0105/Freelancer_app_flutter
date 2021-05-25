import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_detail/post_job_detail_screen.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
class SalaryMoneyScreen extends GetWidget<PostJobController> {

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Job',
        ),
        actions: [
          TextButton(
            onPressed: () {
              formKey.currentState.validate()
                  ? Get.to(() => PostJobDetailScreen())
                  : null;
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 18, color: Colors.blue),
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
              Text('Salary',style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 24),),
              SizedBox(height: 20,),
              TextFormField(
                controller: controller.floorPriceTextController,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsFormatter()],
                style: TextStyle(
                  fontSize: 20,
                ),
                validator: MinLengthValidator(1,
                    errorText: 'Pleases enter'),
                decoration: InputDecoration(
                  hintText: 'From...',
                  suffixIcon: Padding(padding: EdgeInsets.all(15), child: Text('VNĐ',style: TextStyle(color: Colors.black54),)),

                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.cellingPriceTextController,
                inputFormatters: [ThousandsFormatter()],
                validator: MinLengthValidator(1,
                    errorText: 'Pleases enter'),
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: 'To...',
                  suffixIcon: Padding(padding: EdgeInsets.all(15), child: Text('VNĐ',style: TextStyle(color: Colors.black54),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
