import 'dart:convert';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

String AVATAR_CURRENT = '';

class LoginController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  LoginController({
    this.localRepositoryInterface,
    this.apiRepositoryInterface,
  });
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  var loginState = sState.initial.obs;

  void login() async {
    final username = usernameTextController.text;
    final password = passwordTextController.text;
    try {
      loginState(sState.loading);
      final response = await apiRepositoryInterface.login(
        LoginRequest(username: username, password: password),
      );
      print('codeLogin ${response.statusCode}');
      if (response.statusCode == 200) {
        loginState(sState.initial);
        var jsonObject = jsonDecode(response.body);
        TOKEN = jsonObject['token'];
        var accountJs = jsonObject['account'];
        Account account = Account.fromJson(accountJs);
        AVATAR_CURRENT = account.avatarUrl;
        print('token: $TOKEN');
        await localRepositoryInterface.saveToken(TOKEN);
        await localRepositoryInterface.saveAccount(account);
        CURRENT_ID = account.id;
        if(account.role.id == 1)
          Get.offAllNamed(Routes.admin);
        else
          Get.offAllNamed(Routes.home);
        Get.snackbar('Thành công', 'Đăng nhập thành công',
              maxWidth: 600,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP);

      }
      if (response.statusCode == 400) {
        var js = jsonDecode(response.body);
        loginState(sState.initial);
        Get.snackbar(
            'Lỗi',js['message'],
            maxWidth: 600,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
      else{
        loginState(sState.initial);
        Get.snackbar('Lỗi','Server bận!!! Thử lại sau',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            maxWidth: 600,
            snackPosition: SnackPosition.TOP);
      }
    } on Exception catch (e) {
      loginState(sState.initial);
      print('lỗi: ${e.toString()}');
      Get.snackbar(
          'Lỗi','Sever bận! Thử lại sau!',
          maxWidth: 600,
          barBlur: 2,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }
}
