import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:skribex_app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkToken();
    super.onInit();
  }

  Future<void> checkToken() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {},
    );

    try {
      AuthSession session = await Amplify.Auth.fetchAuthSession();
      print("check session ${session.isSignedIn}");
      if (session.isSignedIn) {
        Get.offAllNamed(RouteName.navigation);
      } else {
        Get.offAllNamed(RouteName.login);
      }
    } catch (e) {
      print("Error fetching auth session: $e");
      Get.offAllNamed(RouteName.login);
    }
  }
}
