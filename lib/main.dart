import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

import 'constant.dart';
import 'domain/services/http_service.dart';
import 'main_binding.dart';

void main() {
    if(kIsWeb)
      DOMAIN = 'localhost:5001';
    else
      DOMAIN = '10.0.2.2:5001';

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
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0),
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
