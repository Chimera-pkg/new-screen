import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
// import 'package:skribex_app/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<HomePage> {
  late AuthUser _user;

  @override
  void initState() {
    super.initState();

    Amplify.Auth.getCurrentUser().then((user) {
      print(user);
      setState(() {
        _user = user;
      });
    }).catchError((AuthException exp) {
      print(exp.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUpSuccess"),
        backgroundColor: Colors.blueAccent,
        actions: [
          MaterialButton(
            onPressed: () {
              print("Signing out.");
              Amplify.Auth.signOut().then(
                  (_) => {Navigator.pushReplacementNamed(context, "/login")});
              print("signed out.");
            },
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null)
              const Text("Loading")
            else ...[
              Text("Hello", style: Theme.of(context).textTheme.displayMedium),
              Text(_user.userId),
              Text(_user.username)
            ],
          ],
        ),
      ),
    );
  }
}
