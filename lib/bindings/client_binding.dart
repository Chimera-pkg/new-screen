import 'package:get/get.dart';
import 'package:skribex_app/controllers/client_controller.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientController());
  }
}
