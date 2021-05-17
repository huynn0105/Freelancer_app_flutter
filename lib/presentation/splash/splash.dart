import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends GetWidget<SplashController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/images/a.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Delivery App",
              style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
