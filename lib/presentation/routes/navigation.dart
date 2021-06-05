import 'package:freelance_app/main_binding.dart';
import 'package:freelance_app/presentation/admin/admin_binding.dart';
import 'package:freelance_app/presentation/admin/admin_screen.dart';
import 'package:freelance_app/presentation/admin/screens/dashboard/dashboard_screen.dart';
import 'package:freelance_app/presentation/admin/screens/manage_job/manage_job.dart';
import 'package:freelance_app/presentation/home/home_binding.dart';
import 'package:freelance_app/presentation/home/home_screen.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/add_credit.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/payment_method/add_momo.dart';
import 'package:freelance_app/presentation/login/login_binding.dart';
import 'package:freelance_app/presentation/login/login_screen.dart';
import 'package:freelance_app/presentation/register/register_binding.dart';
import 'package:freelance_app/presentation/register/register_screen.dart';
import 'package:freelance_app/presentation/splash/splash.dart';
import 'package:freelance_app/presentation/splash/splash_binding.dart';
import 'package:get/get.dart';


class Routes {
  static final String splash = '/splash';
  static final String login = '/login';
  static final String home = '/home';
  static final String register = '/register';
  static final String admin = '/admin';
  static final String dashboard = '/dashboard';
  static final String manageJob = '/manage_job';


}

class Pages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        bindings: [MainBinding(), SplashBinding()]
    ),
    GetPage(
        name: Routes.admin,
        page: () => AdminScreen(),
        bindings: [AdminBinding()],
      children: [
        GetPage(
            name: Routes.dashboard,
            page: () => DashboardScreen(),
        ),
        GetPage(
          name: Routes.manageJob,
          page: () => ManageJob(),
        ),
      ]
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
      children: [
        GetPage(
          name: '/add_credit',
          page: () => AddCredit(),
        ),
        GetPage(
          name: '/add_momo',
          page: () => AddMoMo(),
        ),
      ]
    ),

  ];
}