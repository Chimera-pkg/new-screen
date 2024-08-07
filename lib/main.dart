import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skribex_app/amplifyconfiguration.dart';
import 'package:skribex_app/routes/app_pages.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();

  runApp(const MyApp());
}

Future<void> _configureAmplify() async {
  try {
    Amplify.addPlugin(AmplifyAuthCognito());
    // Amplify.addPlugin(AmplifyStorageS3());
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print("Error configuring Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'Nike Application',

          theme: ThemeData(
            fontFamily: 'Nunito',
            primarySwatch: Colors.purple,
          ),
          debugShowCheckedModeBanner: false,
          // initialRoute: AppPages.initial,
          getPages: AppPages.pages,
          initialRoute: AppPages.initial,
        );
      },
    );
  }
}

// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_authenticator/amplify_authenticator.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';

// import 'amplifyconfiguration.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }

//   void _configureAmplify() async {
//     try {
//       await Amplify.addPlugin(AmplifyAuthCognito());
//       await Amplify.configure(amplifyconfig);
//       safePrint('Successfully configured');
//     } on Exception catch (e) {
//       safePrint('Error configuring Amplify: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Authenticator(
//       child: MaterialApp(
//         builder: Authenticator.builder(),
//         home: const Scaffold(
//           body: Center(
//             child: Text('You are logged in!'),
//           ),
//         ),
//       ),
//     );
//   }
// }
