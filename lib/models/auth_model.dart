import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthModel {
  Future<SignInResult> signIn(Map<String, dynamic> loginData) async {
    return await Amplify.Auth.signIn(
        username: loginData['username'], password: loginData['password']);
  }

  Future<SignUpResult> signUp(Map<String, dynamic> signupData) async {
    return await Amplify.Auth.signUp(
      username: signupData['username'],
      password: signupData['password'],
      options: SignUpOptions(
          userAttributes: {CognitoUserAttributeKey.email: signupData['email']}),
    );
  }

  Future<SignUpResult> verifyConfirmation(
      Map<String, dynamic> verifyData) async {
    return await Amplify.Auth.confirmSignUp(
        username: verifyData['username'], confirmationCode: verifyData['code']);
  }

  Future<ResendSignUpCodeResult> resendCode(String username) async {
    return await Amplify.Auth.resendSignUpCode(username: username);
  }

  Future<ResetPasswordResult> resetPassword(String email) async {
    return await Amplify.Auth.resetPassword(username: email);
  }

  Future<ResetPasswordResult> confirmResetPassword(
      Map<String, dynamic> confirmData) async {
    print(
        "nama ${confirmData['username']} ${confirmData['new_password']} ${confirmData['confim_code']}");
    return await Amplify.Auth.confirmResetPassword(
        username: confirmData['username'],
        newPassword: confirmData['new_password'],
        confirmationCode: confirmData['confim_code']);
  }

  Future<SignInResult> googleSignIn() async {
    return await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
  }
}
