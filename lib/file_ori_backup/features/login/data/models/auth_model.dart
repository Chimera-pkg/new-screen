import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthModel {
  Future<SignInResult> signIn(String username, String password) async {
    return await Amplify.Auth.signIn(username: username, password: password);
  }

  Future<SignUpResult> signUp(SignupData signupData) async {
    return await Amplify.Auth.signUp(
      username: signupData.name!,
      password: signupData.password!,
      options: SignUpOptions(
          userAttributes: {CognitoUserAttributeKey.email: signupData.name!}),
    );
  }

  Future<ResetPasswordResult> resetPassword(String email) async {
    return await Amplify.Auth.resetPassword(username: email);
  }

  Future<SignInResult> googleSignIn() async {
    return await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
  }
}
