import 'dart:math';

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
          'Ngân sách dự kiến',
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                if (int.parse(controller.floorPriceTextController.value.text
                        .replaceAll(',', '')) >
                    int.parse(controller.cellingPriceTextController.value.text
                        .replaceAll(',', ''))) {
                  Get.snackbar('Lỗi', 'Khoảng tiền bị sai!!!',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      maxWidth: 600,
                      colorText: Colors.white);
                } else
                  Get.to(() => PostJobDetailScreen());
              }
            },
            child: Text(
              'Tiếp theo',
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
              Text(
                'Số tiền tối đa tôi có thể trả trong khoảng',
                style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.floorPriceTextController,
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsFormatter()],
                style: TextStyle(
                  fontSize: 20,
                ),
                validator: MultiValidator([
                  MinLengthValidator(1, errorText: 'Vui lòng nhập'),
                  RangeValidatorss(),
                ]),
                decoration: InputDecoration(
                  hintText: 'Từ...',
                  suffixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'VNĐ',
                        style: TextStyle(color: Colors.black54),
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controller.cellingPriceTextController,
                inputFormatters: [ThousandsFormatter()],
                validator: MultiValidator([
                  MinLengthValidator(1, errorText: 'Vui lòng nhập'),
                  RangeValidatorss(),
                ]),
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: 'Đến...',
                  suffixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'VNĐ',
                        style: TextStyle(color: Colors.black54),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RangeValidatorss extends RangeValidator {
  @override
  String get errorText => 'Số tiền nhỏ nhất là 200.000';

  @override
  bool isValid(String value) {
    try {
      final numericValue = num.parse(value.replaceAll(',', ''));
      return (numericValue >= 200000);
    } catch (_) {
      return false;
    }
  }
}
