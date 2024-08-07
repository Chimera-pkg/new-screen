import '../data/models/auth_model.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginController {
  final AuthModel _authModel = AuthModel();

  Future<String?> onLogin(LoginData data, Function(bool) onSignInResult) async {
    try {
      final res = await _authModel.signIn(data.name, data.password);
      onSignInResult(res.isSignedIn);
      return res.isSignedIn ? null : "Login failed";
    } on AuthException catch (e) {
      if (e.message == "A user is already signed in.") {
        await Amplify.Auth.signOut();
        print('Signed out the current user session.');
        return "Signed out the current user session, sign in again.";
      }
      return e.toString();
    }
  }

  Future<String?> onSignup(SignupData data) async {
    try {
      await _authModel.signUp(data);
      return null; // No error
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> onRecoverPassword(String email) async {
    try {
      await _authModel.resetPassword(email);
      return "Reset link sent to email";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> googleSignIn() async {
    try {
      final result = await _authModel.googleSignIn();
      if (result.isSignedIn) {
        print("Google sign-in is complete");
        return null; // Successful sign-in
      } else {
        print("Google sign-in failed");
        return 'Google Sign-In failed';
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }
}
