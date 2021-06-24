import 'dart:convert';

import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/register_request.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/login/login_controller.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';



class RegisterController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  RegisterController({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  var registerState = sState.initial.obs;

  var roleSelected = 2.obs;

  RxString message = ''.obs;

  void register() async {
    final name = usernameTextController.text;
    final email = emailTextController.text;
    final phone = phoneTextController.text;
    final password = passwordTextController.text;

    try {
      registerState(sState.loading);
      var response = await apiRepositoryInterface.register(RegisterRequest(
          name: name,
          email: email,
          phone: phone,
          password: password));
      if (response.statusCode == 200) {
        registerState(sState.initial);
        var jsonObject = jsonDecode(response.body);
        TOKEN = jsonObject['token'];
        Account account = Account.fromJson(jsonObject['account']);
        AVATAR_CURRENT = account.avatarUrl;
        await localRepositoryInterface.saveToken(TOKEN);
        await localRepositoryInterface.saveAccount(account);
        CURRENT_ID = account.id;
        print('token: $TOKEN');
        if(account.role.id==1)
          Get.offAllNamed(Routes.admin);
        else
          Get.offAllNamed(Routes.home);

        Get.snackbar('Thành công', 'Đăng ký thành công',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            maxWidth: 600,
              snackPosition: SnackPosition.TOP);
      }
      else if(response.statusCode == 400) {
        registerState(sState.initial);
        var js = jsonDecode(response.body);
        message(js['message']);
        Get.snackbar('Lỗi',js['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);
      }else{
        registerState(sState.initial);
        Get.snackbar('Lỗi','Server bận!!! Thử lại sau',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);
      }

    } catch (e) {
      registerState(sState.initial);
      print("Lỗi: ${e.toString()}");
      Get.snackbar('Lỗi','Server bận!!! Thử lại sau',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          maxWidth: 600,
          snackPosition: SnackPosition.TOP);
    }
  }
}
