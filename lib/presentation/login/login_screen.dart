import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/forget_password/forget_password_screen.dart';
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

const logoSize = 45.0;

class LoginScreen extends GetWidget<LoginController> {
  void login() async {
    if (formKey.currentState.validate()) {
      final bool result = await controller.login();
      if (result) {
        Get.snackbar('Success', 'Login Success',
            snackPosition: SnackPosition.TOP);
        Get.offAllNamed(Routes.home);
      } else {
        Get.snackbar(
          'Error',controller.message.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
      }
    } else {
      Get.snackbar('Error', 'Kiểm tra lại thông tin',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: !isMobile(context) ? double.infinity/2 : double.infinity,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Stack(
                        children: [
                          Align(
                            child: Image.asset(
                              'assets/images/logo.png',
                              color: Theme.of(context).accentColor,
                              width: 120,
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      );
                    })),
                Expanded(
                    flex: 6,
                    child: SingleChildScrollView(
                      child: buildLoginPanel(),
                    )),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: RoundedButton(
                      onTap: login,
                      buttonName: "Đăng nhập",
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.register);
                    },
                    child: Text(
                      "Bạn chưa có tài khoản? Đăng ký ngay!",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Obx(() {
              if (controller.loginState.value == sState.loading) {
                return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          )
        ],
      ),
    );
  }

  Widget buildLoginPanel() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Đăng Nhập',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    controller: controller.usernameTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                        ),
                        hintText: 'username'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextFormField(
              obscureText: true,
              validator: passwordValidator,
              controller: controller.passwordTextController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                  ),
                  hintText: 'password'),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                return Get.to(ForgetPassword());
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Quên mật khẩu?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
