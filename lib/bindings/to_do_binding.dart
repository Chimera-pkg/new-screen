import 'package:get/get.dart';
import 'package:skribex_app/controllers/to_do_controller.dart';

class ToDoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ToDoController());
  }
}
