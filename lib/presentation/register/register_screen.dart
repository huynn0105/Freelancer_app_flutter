import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';

import 'register_controller.dart';


class RegisterScreen extends StatefulWidget {


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var controller =  Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'Yêu cầu nhập mật khẩu'),
      MinLengthValidator(6, errorText: 'Mật khẩu phải nhiều hơn 6 ký tự'),
    ]);



    void register() async {
      if (formKey.currentState.validate()) {
        final bool result = await controller.register();
        if (result) {
          Get.snackbar('Thành công', 'Đăng ký thành công',
              snackPosition: SnackPosition.BOTTOM);
          Get.offAllNamed(Routes.home);
        } else {
          Get.snackbar('Lỗi',controller.message.value,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP);
        }
      } else {
        Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
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
                          keyboardType: TextInputType.emailAddress,
                          validator: MultiValidator([
                            EmailValidator(errorText: 'Địa chỉ email không hợp lệ'),
                            RequiredValidator(errorText: 'Yêu cầu nhập email'),
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
                          obscureText: true,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
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
                          obscureText: true,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) => MatchValidator(
                                  errorText: 'Mật khẩu không chính xác')
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
                                  value: 2,
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
                                  value: 3,
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
                      child: Text('Đăng ký',style: TEXT_STYLE_PRIMARY.copyWith(color: Colors.white),),
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
          ),
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
      ],
    );
  }
}
