import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skribex_app/amplifyconfiguration.dart';
import 'package:skribex_app/models/auth_model.dart';
import 'package:skribex_app/routes/app_routes.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // register
  final TextEditingController emailRegisterTextController =
      TextEditingController();
  final TextEditingController companyEmailRegisterTextController =
      TextEditingController();
  final TextEditingController usernameRegisterTextController =
      TextEditingController();
  final TextEditingController passwordRegisterTextController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterTextController =
      TextEditingController();
  final TextEditingController verifyCodeRegisterTextController =
      TextEditingController();
  // login
  final TextEditingController usernameLoginTextController =
      TextEditingController();
  final TextEditingController passwordLoginTextController =
      TextEditingController();

  final isObsecured = true.obs;
  final isObsecuredPasswordRegister = true.obs;
  final isObsecuredConfirmPasswordRegister = true.obs;
  late final TabController tabController;
  final isLoading = false.obs;
  final AuthModel _authModel = AuthModel();

  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    _configureAmplify();
  }

  @override
  void onClose() {
    // usernameLoginTextController.dispose();
    // emailRegisterTextController.dispose();
    // usernameRegisterTextController.dispose();
    // passwordRegisterTextController.dispose();
    // verifyCodeRegisterTextController.dispose();
    // usernameLoginTextController.dispose();
    // passwordLoginTextController.dispose();
    // tabController.dispose();
    super.onClose();
  }

  Future<void> _configureAmplify() async {
    try {
      // Add Auth plugin to Amplify
      await Amplify.addPlugin(AmplifyAuthCognito());
      // Load the configuration
      await Amplify.configure(amplifyconfig);
      print("Amplify configured");
    } catch (e) {
      print("Could not configure Amplify: $e");
    }
  }

  Future<void> onLogin(String username, String password) async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();

    try {
      if (username == "company" || username == "Company") {
        await prefs.setString('token', "company");
        Get.snackbar(
          'Login Success !',
          'Welcome to Company Account',
          backgroundColor: Colors.green,
          colorText: colorWhite,
          icon: const Icon(
            Icons.check,
            color: colorWhite,
          ),
        );
        isLoading.value = false;

        Get.toNamed(RouteName.selecAccount);
        return;
      }

      var input = <String, dynamic>{
        'username': username,
        'password': password,
      };
      // final res = await _authModel.signIn(input);
      await _authModel.signIn(input);

      Get.snackbar(
        'Login Success !',
        'Welcome',
        backgroundColor: Colors.green,
        colorText: colorWhite,
        icon: const Icon(
          Icons.check,
          color: colorWhite,
        ),
      );
      await prefs.setString('token', "individual");
      isLoading.value = false;
      Get.offAllNamed(RouteName.navigation);
    } on AuthException catch (e) {
      if (e.message == "A user is already signed in.") {
        await Amplify.Auth.signOut();
        print('Signed out the current user session.');

        Get.snackbar(
          'Login Success !',
          'Welcome',
          backgroundColor: Colors.green,
          colorText: colorWhite,
          icon: const Icon(
            Icons.check,
            color: colorWhite,
          ),
        );
        isLoading.value = false;
        Get.offAllNamed(RouteName.navigation);
      }
      Get.snackbar(
        'Sign In Failed',
        "",
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
    }
    isLoading.value = false;
  }

  Future<void> onSignup() async {
    isLoading.value = true;
    try {
      var input = <String, dynamic>{
        'email': emailRegisterTextController.text,
        'username': usernameRegisterTextController.text,
        'password': passwordRegisterTextController.text,
      };
      await _authModel.signUp(input);
      Get.snackbar(
        'Sign Up Success',
        "",
        backgroundColor: Colors.green,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
      Get.toNamed(RouteName.confirmRegister);
      isLoading.value = false;
    } on AuthException catch (e) {
      if (e.message.toString() == "User already exists") {
        Get.toNamed(RouteName.confirmRegister);
      }

      Get.snackbar(
        'Failed SignUp',
        "",
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'Failed SignUp',
        "",
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
      isLoading.value = false;
    }
  }

  Future<String?> googleSignIn() async {
    try {
      final result = await _authModel.googleSignIn();
      if (result.isSignedIn) {
        print("Google sign-in is complete");
        // Navigasi ke halaman homepage
        Get.offNamed(RouteName.navigation);
        return null; // Successful sign-in
      } else {
        print("Google sign-in failed");
        return 'Google Sign-In failed';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }

  void verifyConfirmation() async {
    var input = <String, dynamic>{
      'username': usernameRegisterTextController.text,
      'password': passwordRegisterTextController.text,
      'code': verifyCodeRegisterTextController.text
    };
    try {
      final res = await _authModel.verifyConfirmation(input);

      if (res.isSignUpComplete) {
        onLogin(input['username'], input['password']);
      } else {
        Get.snackbar(
          'Failed Verification',
          "",
          backgroundColor: Colors.red,
          colorText: colorWhite,
          icon: const Icon(
            Icons.cancel,
            color: colorWhite,
          ),
        );
      }
    } on AuthException catch (e) {
      Get.snackbar(
        'Failed Verification',
        e.message,
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
    }
  }

  Future<void> resendCode() async {
    final username = usernameRegisterTextController.text;
    try {
      final res = await _authModel.resendCode(username);
      Get.snackbar(
        'Resend Code Success',
        "",
        backgroundColor: Colors.green,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
    } on AuthException catch (e) {
      Get.snackbar(
        'Failed Resend Code',
        e.message,
        backgroundColor: Colors.red,
        colorText: colorWhite,
        icon: const Icon(
          Icons.cancel,
          color: colorWhite,
        ),
      );
    }
  }
}
