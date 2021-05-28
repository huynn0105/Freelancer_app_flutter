import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

import 'package:get/get.dart';

const logoSize = 45.0;

class ForgetPassword extends StatelessWidget {
  // void login() async {
  //   if (formKey.currentState.validate()) {
  //     final bool result = await controller.login();
  //     if (result) {
  //       Get.snackbar('Success', 'Login Success',
  //           snackPosition: SnackPosition.TOP);
  //     } else {
  //       Get.snackbar(
  //           'Error',controller.message.value,
  //           snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white
  //       );
  //     }
  //   } else {
  //     Get.snackbar('Error', 'Kiểm tra lại thông tin',
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.vpn_key,
                  size: 40,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  "Nhập email đã đăng ký",
                  style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.blue),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: 'Email vừa nhập không hợp lệ'),
                    RequiredValidator(errorText: 'Yêu cầu nhập email'),
                  ]),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      hintText: 'Email'),
                ),
                SizedBox(
                  height: 50,
                ),
                RoundedButton(
                  onTap: () {},
                  child: Text(
                    'Gửi yêu cầu',
                    style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          // Positioned.fill(
          //   child: Obx(() {
          //     if (controller.loginState.value == LoginState.loading) {
          //       return Container(
          //         color: Colors.black26,
          //         child: Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   }),
          // )
        ],
      ),
    );
  }
}
