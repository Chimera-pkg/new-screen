import 'dart:ui';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';


class ConfirmResetScreen extends StatefulWidget {
  final LoginData data;
  const ConfirmResetScreen({super.key, required this.data});
  @override
  State<ConfirmResetScreen> createState() => _ConfirmResetScreenState();
}

class _ConfirmResetScreenState extends State<ConfirmResetScreen> {
  final _controller = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isEnabled = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword(BuildContext context, dynamic signupData, String confirmationCode, String password) async {
    ResetPasswordResult res;
    try {
      print(signupData.name);
      print(confirmationCode);
      res = await Amplify.Auth.confirmResetPassword(username: signupData.name!, newPassword: password, confirmationCode: confirmationCode);
      print('Reset Result: ${res.isPasswordReset}');
      if (res.isPasswordReset) {
        print("Reset password complete");
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Password reset completed successfully, Please login",
                    style: TextStyle(fontSize: 15),
                  )
              )
          );
        }
        Navigator.of(context).pushReplacementNamed("/login");
      }
      else {
        _showError(context, 'Password reset is not complete.');
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
                        controller: _newPasswordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: "Enter new password",
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40))
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                              },
                              child: Icon (
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
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
                          _resetPassword(context, widget.data, _controller.text, _newPasswordController.text);
                        } : null,
                        elevation: 4,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.deepPurple.shade300,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text (
                          "RESET",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
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
