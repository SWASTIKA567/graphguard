import 'package:get/get.dart';
import '../modules/splash/splash_view.dart';
import '../modules/auth/login_view.dart';
import '../modules/repo/repo_view.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/dashboard/dashboard_controller.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: "/splash", page: () => SplashView()),
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(name: "/repos", page: () => RepoListScreen()),
    GetPage(
      name: "/dashboard",
      page: () => DashboardScreen(),
      binding: BindingsBuilder(() {
        Get.put(DashboardController());
      }),
    ),
  ];
}
