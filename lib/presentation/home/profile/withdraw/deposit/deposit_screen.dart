import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../responsive.dart';

class Deposit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ctrlBalance = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var controller = Get.find<HomeController>();
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nạp tiền'),
        ),
        body: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: InputText(
                  label: 'Số lượng',
                  controller: ctrlBalance,
                  inputFormatters: [ThousandsFormatter()],
                  keyboardType: TextInputType.number,
                  validator:
                      RequiredValidator(errorText: 'Yêu cầu nhập mật khẩu'),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              RoundedButton(
                  onTap: () {
                    if (formKey.currentState.validate()) {
                      controller
                          .deposit(
                              int.parse(ctrlBalance.text.replaceAll(',', '')))
                          .then((value) {
                        controller.balance +=
                            int.parse(ctrlBalance.text.replaceAll(',', ''));
                        Get.back();
                        Get.snackbar('Thành công',
                            'Nạp thành công ${ctrlBalance.text} VNĐ vào tài khoản',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            maxWidth: 600,
                            snackPosition: SnackPosition.TOP);
                      });
                    }
                  },
                  child: Text('Nạp tiền')),
            ],
          ),
        ),
      ),
    );
  }
}
