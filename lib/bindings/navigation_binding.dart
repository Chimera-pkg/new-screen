import 'package:get/get.dart';
import 'package:skribex_app/controllers/expense_controller.dart';
import 'package:skribex_app/controllers/home_controller.dart';
import 'package:skribex_app/controllers/auth_controller.dart';
import 'package:skribex_app/controllers/navigation_controller.dart';
import 'package:skribex_app/controllers/profile_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ExpenseController>(() => ExpenseController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
