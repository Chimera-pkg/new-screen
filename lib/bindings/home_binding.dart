import 'package:get/get.dart';
import 'package:skribex_app/controllers/expense_controller.dart';
import 'package:skribex_app/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
