import 'package:get/get.dart';
import 'package:skribex_app/controllers/map_tracking_controller.dart';

class MapTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapTrackingController());
  }
}
