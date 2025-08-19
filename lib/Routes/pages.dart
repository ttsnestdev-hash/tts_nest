import 'package:get/get.dart';

import '../UI/AddTask/Component/add_task_screen.dart';
import '../UI/Dashboard/Component/dashboard_screen.dart';
import '../UI/Home/Component/home_screen.dart';
import '../UI/Login/Component/login_screen.dart';
import 'Routes.dart';


class Pages {
  static final pages = [
    GetPage(name: Routes.logInScreen, page: () => const LoginScreen(), popGesture: false),
    GetPage(name: Routes.homeScreen, page: () => const DashboardHome(), popGesture: false),
    GetPage(name: Routes.dashboardScreen, page: () => const DashboardScreen(), popGesture: false),
    GetPage(name: Routes.newTaskScreen, page: () => const AddTaskScreen(), popGesture: false),

  ];
}
