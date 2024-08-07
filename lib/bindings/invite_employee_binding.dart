import 'package:get/get.dart';
import 'package:skribex_app/controllers/invite_employee_controller.dart';

class InviteEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InviteEmployeeController());
  }
}
