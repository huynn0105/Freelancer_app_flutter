import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/forget_password/forget_password_screen.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'login_controller.dart';

const logoSize = 45.0;

class LoginScreen extends GetWidget<LoginController> {
  void login() async {
    if (formKey.currentState.validate()) {
       controller.login();
    } else {
      Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
          maxWidth: 600,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          barBlur: 200
      );
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
      backgroundColor: Colors.blueGrey.shade50,
      body: Stack(
        children: [
          Responsive(
              mobile: Card(
                margin: EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Expanded(child: SizedBox.shrink()),
                    Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          child: buildLoginPanel(),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: RoundedButton(
                          onTap: login,
                          child: Text(
                            'Đăng nhâp',
                            style: TEXT_STYLE_PRIMARY.copyWith(
                                color: Colors.white),
                          ),
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
              desktop: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 470,
                      height: 400,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                          ),
                          Positioned(
                              top: 140,
                              child: SizedBox(
                                  width: 400,
                                  height: 270,
                                  child: Text(
                                'Tuyển Freelancer và cộng tác viên hàng đầu',
                                style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),
                              ))),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                      child: Container(
                          width: 420,
                          height: 400,
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                FormLogin(
                                    formKey: formKey,
                                    controller: controller,
                                    passwordValidator: passwordValidator,
                                    usernameTextController:
                                        controller.usernameTextController,
                                    passwordTextController:
                                        controller.passwordTextController),
                                SizedBox(height: kDefaultPadding),
                                RoundedButton(
                                  onTap: login,
                                  child: Text(
                                    'Đăng nhâp',
                                    style: TEXT_STYLE_PRIMARY.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: kDefaultPadding),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.register);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          kDefaultPadding / 2),
                                      child: Text(
                                        'Tạo tài khoản mới',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ))
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Banner(),
          FormLogin(
            formKey: formKey,
            controller: controller,
            passwordValidator: passwordValidator,
            usernameTextController: controller.usernameTextController,
            passwordTextController: controller.passwordTextController,
          ),
        ],
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key key,
    @required this.formKey,
    @required this.controller,
    @required this.passwordValidator,
    @required this.usernameTextController,
    @required this.passwordTextController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final LoginController controller;
  final MultiValidator passwordValidator;
  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            controller: usernameTextController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Yêu cầu nhập mật khẩu'),
              EmailValidator(errorText: 'Sai định dang email'),
            ]),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                ),
                hintText: 'Email'),
          ),
          SizedBox(height: kDefaultPadding),
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
            controller: passwordTextController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                ),
                hintText: 'Mật khẩu'),
          ),
          SizedBox(height: kDefaultPadding),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.to(() => ForgetPassword()),
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
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
    });
  }
}
