import 'dart:convert';

import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/repositories/local_storage_repository.dart';
import 'package:freelance_app/domain/requests/register_request.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum sState { loading, initial }

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
  final passwordTextController = TextEditingController();

  var registerState = sState.initial.obs;

  var roleSelected = 1.obs;

  RxString message = ''.obs;

  Future<bool> register() async {
    final name = usernameTextController.text;
    final email = emailTextController.text;
    final password = passwordTextController.text;

    try {
      registerState(sState.loading);
      Response response = await apiRepositoryInterface.register(RegisterRequest(
          name: name,
          email: email,
          password: password,
          role: roleSelected.value));
      if (response.statusCode == 200) {
        registerState(sState.initial);
        var jsonObject = jsonDecode(response.body);
        var token = jsonObject['token'];
        await localRepositoryInterface.saveToken(token);
        return true;
      }
      if (response.statusCode == 400) {
        registerState(sState.initial);
        var js = jsonDecode(response.body);
        message(js['message']);
        return false;
      }else{
        registerState(sState.initial);
        return false;
      }

    } catch (e) {
      registerState(sState.initial);
      print("Lỗi: ${e.toString()}");
      return false;
    }
  }
}
