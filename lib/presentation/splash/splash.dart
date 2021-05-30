import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
