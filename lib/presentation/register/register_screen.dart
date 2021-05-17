import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

const logoSize = 45.0;

class RegisterScreen extends GetWidget<RegisterController> {
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(7, errorText: 'password must be at least 7 digits long'),
  ]);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void register() async {
    if (formKey.currentState.validate()) {
      final bool result = await controller.register();
      if (result) {
        Get.snackbar('Success', 'Register Success ',
            snackPosition: SnackPosition.BOTTOM);
        Get.offAllNamed(Routes.home);
      } else {
        Get.snackbar('Error',controller.message.value,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);

      }
    } else {
      Get.snackbar('Error', 'Kiểm tra lại thông tin',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: controller.usernameTextController,
                        validator: MinLengthValidator(1,
                            errorText: 'Không được bỏ trống'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                            hintText: 'Nguyễn Văn A'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        controller: controller.emailTextController,
                        validator: MultiValidator([
                          EmailValidator(errorText: 'Enter a valid email address'),
                          RequiredValidator(errorText: 'Email is required'),
                        ]),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            hintText: 'Email đăng nhập'),
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
                        controller: controller.passwordTextController,
                        validator: passwordValidator,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            hintText: 'Mật khẩu'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Xác nhận mật khẩu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        validator: (val) => MatchValidator(
                                errorText: 'passwords do not match')
                            .validateMatch(
                                val, controller.passwordTextController.text),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            hintText: 'Mật khẩu'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tôi muốn đăng ký làm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: RadioListTile(
                                title: Text('Freelancer'),
                                onChanged: (value) {
                                  controller.roleSelected.value = value;
                                },
                                value: 1,
                                groupValue: controller.roleSelected.value,
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: RadioListTile(
                                title: Text('Nhà tuyển dụng'),
                                onChanged: (value) {
                                  controller.roleSelected.value = value;
                                },
                                value: 2,
                                groupValue: controller.roleSelected.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RoundedButton(
                    onTap: register,
                    buttonName: "Đăng ký",
                  )),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    "Bạn đã có tài khoản? Đăng nhập ngay!",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Obx(() {
              if (controller.registerState.value == sState.loading) {
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
        ]),
      ),
    );
  }
}
