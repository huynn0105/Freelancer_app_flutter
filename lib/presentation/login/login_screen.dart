import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/forget_password/forget_password_screen.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'login_controller.dart';

const logoSize = 45.0;

class LoginScreen extends GetWidget<LoginController> {

  void login() async {
    if (formKey.currentState.validate()) {
      await controller.login();

    } else {
      Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Yêu cầu nhập mật khẩu'),
    MinLengthValidator(6, errorText: 'Mật khẩu phải có ít nhất 6 ký tự'),
  ]);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: SizedBox.shrink()),
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
                    child: Text('Đăng nhâp',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),),
                  )),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),

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
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  Center(
                    child: Text(
                      'Chào mừng đến với',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 180,
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              );
            }),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Email đăng nhập',
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
                        hintText: 'Email'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Mật khẩu',
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
                  hintText: 'Mật khẩu'),
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
