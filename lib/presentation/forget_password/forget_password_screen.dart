import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Icon(Icons.vpn_key,size: 40,color: Colors.blue,),
                SizedBox(height: 30,),
                Text("Please enter your registered email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.blue),),
                SizedBox(height: 30,),
                TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: 'Enter a valid email address'),
                    RequiredValidator(errorText: 'Email is required'),
                  ]),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      hintText: 'Email'),
                ),
                SizedBox(height: 50,),
                RoundedButton(onTap: (){}, buttonName: 'Reset password'),
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
