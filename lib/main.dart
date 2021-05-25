import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

import 'constant.dart';
import 'main_binding.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: Routes.splash,
      initialBinding: MainBinding(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,

        primaryIconTheme:
            Theme.of(context).primaryIconTheme.copyWith(color: Colors.black),
        primaryTextTheme:
            Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.black),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
