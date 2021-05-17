import 'package:freelance_app/presentation/home/home_binding.dart';
import 'package:freelance_app/presentation/home/home_screen.dart';
import 'package:freelance_app/presentation/login/login_binding.dart';
import 'package:freelance_app/presentation/login/login_screen.dart';
import 'package:freelance_app/presentation/register/register_binding.dart';
import 'package:freelance_app/presentation/register/register_screen.dart';
import 'package:freelance_app/presentation/splash/splash.dart';
import 'package:freelance_app/presentation/splash/splash_binding.dart';
import 'package:get/get.dart';

import '../../main_binding.dart';
class Routes {
  static final String splash = '/splash';
  static final String login = '/login';
  static final String home = '/home';
  static final String register = '/register';
}

class Pages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        bindings: [MainBinding(), SplashBinding()]
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}