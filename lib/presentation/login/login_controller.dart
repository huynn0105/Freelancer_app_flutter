import 'dart:convert';

import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/login_request.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/register/register_controller.dart';
import 'package:get/get.dart';



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
  RxString message = ''.obs;

  Future<bool> login() async {
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
        print('token: $TOKEN');
        await localRepositoryInterface.saveToken(TOKEN);
        return true;
      }
      if (response.statusCode == 400) {
        var js = jsonDecode(response.body);
        message.value = js['message'];
        return false;
      }
      else{
        loginState(sState.initial);
        return false;
      }

    } on Exception catch (_) {
      loginState(sState.initial);
      return false;
    }
  }
}
