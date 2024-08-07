import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const users =  {
  'sri@gmail.com': '12345',
  'srik@gmail.com': '123',
};


class LoginOld extends StatefulWidget {
  const LoginOld({super.key});
  @override
  State<LoginOld> createState() => _LoginStateOld();
}

class _LoginStateOld extends State<LoginOld> {
  late LoginData _loginData;
  late SignupData _signupData;
  late bool _isSignedIn = false;
  Duration get loginTime => const Duration(milliseconds: 2250);
  bool _isGoogleSignedIn = false;

  Future<String?> _onLogin(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}, email: ${data.toString()}');
    print(_isSignedIn);
    try {
      // Check if a user is already signed in
      //final session = await Amplify.Auth.fetchAuthSession();
      final res = await Amplify.Auth.signIn(username: data.name, password: data.password);
      _isSignedIn = res.isSignedIn;
      print(_isSignedIn);
    } on AuthException catch (e) {
      print(e);
      //return e.message;
      if(e.message == "A user is already signed in."){
        await Amplify.Auth.signOut();
        print('Signed out the current user session.');
        return "Signed out the current user session, sign in again.";
      }
      return e.message;
    }
  }

  Future<String?> _onSignup(SignupData data) async {
    // Check if the data is null and return an appropriate error message
    if (data.name == null || data.name!.isEmpty) {
      return 'Username cannot be empty';
    }
    if (data.password == null || data.password!.isEmpty) {
      return 'Password cannot be empty';
    }

    try {
      final result = await Amplify.Auth.signUp(
        username: data.name!, // Use the non-nullable assertion operator (!)
        password: data.password!, // Use the non-nullable assertion operator (!)
        options: SignUpOptions(
          userAttributes: {CognitoUserAttributeKey.email: data.name!},
        ),
      );
      _signupData = data;
    } on AuthException catch (e) {
      // Return the exception message
      print(e);
      return e.message;
    }
  }

  Future<String?> _onRecoverPassword(BuildContext context, String email) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);
      print(res);
      if(res.nextStep.updateStep == AuthResetPasswordStep.confirmResetPasswordWithCode) {
        print("Confirm reset password with code");
        Navigator.of(context).pushReplacementNamed("/confirm-reset", arguments: LoginData(name: email, password: ""),
        );
      }

      //AuthResetPasswordStep.confirmResetPasswordWithCode confirmResetPasswordWithCode
    } on AuthException catch (e) {
      print(e);
      return e.message;
    }
  }
  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }

  Future<String?> _googleSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      _isSignedIn = result.isSignedIn;
      if (_isSignedIn) {
        print("google sign is complete");
        // User signed in successfully, you can do additional tasks here
      } else {
        // Handle Google Sign-In failure
        print("google sign in failed");
        return 'Google Sign-In failed';
      }
    } catch (error) {
      // Handle any errors that may occur during the sign-in process
      return 'An error occurred: $error';
    }
    return null; // Return null to indicate successful login
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: "SkribeX Login",
      //logo: const AssetImage("assets/icons/transparent_logo.png"),
      onLogin: _onLogin,
      onRecoverPassword: (String email) => _onRecoverPassword(context, email),
      onSignup: _onSignup,
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
        titleStyle: const TextStyle(
          // Set your custom style for the title
          color: Colors.amber, // Choose the color to fit your theme
          fontSize: 35, // Adjust the font size as needed
          fontWeight: FontWeight.bold, // Choose the font weight
          letterSpacing: 5, // Adjust letter spacing as desired
        ),
      ),
      onSubmitAnimationCompleted: () {
        if (_isSignedIn) {
          Navigator.of(context).pushReplacementNamed('/signupsuccess');
        } else if (_signupData != null) { // Check if _signupData is initialized
          Navigator.of(context).pushReplacementNamed('/confirm', arguments: _signupData);
        }
      },
      loginProviders: <LoginProvider>[
      LoginProvider(
                  icon: FontAwesomeIcons.google,
                    label: 'Google',
                    callback: _googleSignIn
      ),
      ]
    );
  }
}
