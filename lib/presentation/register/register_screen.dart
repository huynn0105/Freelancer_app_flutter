import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/responsive.dart';
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

    void register()  {
      if (formKey.currentState.validate())
        controller.register();
       else
        Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
            maxWidth: 600,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);

    }

    return Stack(
      children: [
        Scaffold(
          appBar: Responsive.isMobile(context) ? AppBar(
          ) : null,
          backgroundColor: Colors.blueGrey.shade50,
          body: Responsive(
              mobile: Card(
            margin: EdgeInsets.all(0.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FormRegister(formKey: formKey, controller: controller, passwordValidator: passwordValidator),
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
              desktop: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                                'Đăng ký để tuyển Freelancer và đăng công việc',
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
                      height: 700,
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FormRegister(formKey: formKey, controller: controller, passwordValidator: passwordValidator),
                            SizedBox(height: kDefaultPadding),
                            RoundedButton(
                              onTap: register,
                              child: Text(
                                'Đăng Ký',
                                style: TEXT_STYLE_PRIMARY.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: kDefaultPadding),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              padding: EdgeInsets.only(bottom: 20, top: 10),
                              child: TextButton(
                                onPressed: () => Get.toNamed(Routes.login),
                                child: Text(
                                  "Bạn đã có tài khoản? Đăng nhập ngay!",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2661FA)),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
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

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key key,
    @required this.formKey,
    @required this.controller,
    @required this.passwordValidator,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final RegisterController controller;
  final MultiValidator passwordValidator;

  @override
  Widget build(BuildContext context) {
    return Form(
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
            'Họ và tên',
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
            'Số tiện thoại',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            controller: controller.phoneTextController,
            keyboardType: TextInputType.number,
            validator: MultiValidator([
              MinLengthValidator(1,
                  errorText: 'Không được bỏ trống'),
              MaxLengthValidator(10, errorText: 'Sai định dạng số điện thoại')
            ]),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                ),hintText: 'Số điện thoại'),
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
          // Obx(
          //       () => Row(
          //     children: [
          //       Flexible(
          //         fit: FlexFit.loose,
          //         child: RadioListTile(
          //           title: Text('Freelancer'),
          //           onChanged: (value) {
          //             controller.roleSelected.value = value;
          //           },
          //           value: 2,
          //           groupValue: controller.roleSelected.value,
          //         ),
          //       ),
          //       Flexible(
          //         fit: FlexFit.loose,
          //         child: RadioListTile(
          //           title: Text('Nhà tuyển dụng'),
          //           onChanged: (value) {
          //             controller.roleSelected.value = value;
          //           },
          //           value: 3,
          //           groupValue: controller.roleSelected.value,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
