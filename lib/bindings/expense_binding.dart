import 'package:get/get.dart';
import 'package:skribex_app/controllers/expense_controller.dart';

class ExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpenseController());
  }
}
