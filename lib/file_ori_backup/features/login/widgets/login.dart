import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final LoginController _loginController;
  late bool _isSignedIn = false;
  SignupData? _signupData;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
  }

  void _updateSignInState(bool isSignedIn) {
    setState(() {
      _isSignedIn = isSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SkribeX Login',
      onLogin: (data) => _loginController.onLogin(data, _updateSignInState),
      onSignup: (data) {
        _signupData = data; // Set _signupData upon signup
        return _loginController.onSignup(data);
      },
      onRecoverPassword: _loginController.onRecoverPassword,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            final result = await _loginController.googleSignIn();
            if (result != null) {
              _isSignedIn = false;
              return result; // Display error message if any
            }
            _isSignedIn = true;
            return null; // Successful sign-in
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        if (_isSignedIn) {
          Navigator.of(context).pushReplacementNamed('/signupsuccess');
          //Navigator.of(context).pushReplacementNamed('/home');
        } else if (_signupData != null) {
          Navigator.of(context)
              .pushReplacementNamed('/confirm', arguments: _signupData);
        }
      },
      // ... other configurations ...
    );
  }
}
