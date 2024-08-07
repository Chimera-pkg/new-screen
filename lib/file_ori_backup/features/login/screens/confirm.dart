import 'dart:ui';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';


class ConfirmScreen extends StatefulWidget {
  final SignupData data;
  const ConfirmScreen({super.key, required this.data});
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _verifyConfirmation(BuildContext context, SignupData signupData, String confirmationCode) async {
    SignUpResult res;
    try {
      print(signupData.name);
      print(confirmationCode);
      res = await Amplify.Auth.confirmSignUp(username: signupData.name!, confirmationCode: confirmationCode);
      print('SignUp Result: ${res.isSignUpComplete}');
      print("1st mount");
      if (res.isSignUpComplete) { //mounted is already available in the state.
        print("signup complete");
        final user = await Amplify.Auth.signIn(username: signupData.name!, password: signupData.password);
        if(mounted) { //check again after the async call
          if(user.isSignedIn) {
            Navigator.pushReplacementNamed(context, '/signupsuccess');
          }
        }
      }
      else {
        _showError(context, 'Sign up is not complete. Please follow the instructions sent to your email.');
      }

    }
    on AuthException catch (e) {
      if (mounted) {
        _showError(context, e.message);
      }
    }
  }

  void _showError(BuildContext context, String errorMessage) {
      if (mounted) {
        final snackBar = SnackBar(content: Text(errorMessage, style: const TextStyle(fontSize: 15)), backgroundColor: Colors.redAccent,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _resendCode(BuildContext context, SignupData signupdata) async {
    try {
      print(signupdata.name);
      final res1 = await Amplify.Auth.resendSignUpCode(username: signupdata.name!);
      print(res1.codeDeliveryDetails.destination.toString());
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Confirmation code resent. Check you email box", style: TextStyle(fontSize: 15)),
                backgroundColor: Colors.greenAccent,
          )
        );
      }
    } on AuthException catch (e)
    {
      if (mounted) {
        _showError(context, '${e.message} - ${e.recoverySuggestion}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center (
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Enter confirmation code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                        )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    MaterialButton(
                      onPressed: _isEnabled ? () {
                        _verifyConfirmation(context, widget.data, _controller.text);
                      } : null,
                      elevation: 4,
                      color: Theme.of(context).primaryColor,
                      disabledColor: Colors.deepPurple.shade300,
                      child: const Text (
                        "VERIFY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    MaterialButton(onPressed: () {
                      _resendCode(context, widget.data);
                    },
                      child: const Text(
                        "Resend code",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
