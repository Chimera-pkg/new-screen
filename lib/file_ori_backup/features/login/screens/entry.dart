import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
// import 'package:skribex_app/amplifyconfiguration.dart';

import '../../../logging/log_printer.dart';
import '../widgets/login.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});
  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool _amplifyConfigured = false;
  late final PrettyLogger logger;
  @override
  void initState() {
    super.initState();
    logger = PrettyLogger();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!Amplify.isConfigured) {
      final auth = AmplifyAuthCognito();
      try {
        Amplify.addPlugins([auth]);
        // await Amplify.configure(amplifyconfig);
        logger.info("Amplify configured for the first time");
      } on AmplifyAlreadyConfiguredException catch (e) {
        logger.error(e);
      }
    } else {
      logger.info("Amplify was already configured");
    }

    setState(() {
      _amplifyConfigured = true; // Set to true regardless
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: _amplifyConfigured
            ? const Login()
            : const CircularProgressIndicator(),
      ),
    );
  }
}
