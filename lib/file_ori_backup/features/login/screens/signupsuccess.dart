import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
// import 'package:skribex_app/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skribex_app/file_ori_backup/features/login/screens/map_track.dart';
import 'package:skribex_app/file_ori_backup/models/skribe_model.dart';

class SignUpSuccess extends StatefulWidget {
  const SignUpSuccess({super.key});
  @override
  State<SignUpSuccess> createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  late AuthUser _user;
  List<SkribeModel> skribeModels = [];

  @override
  void initState() {
    super.initState();
    skribeModels = SkribeModel.getSkirbes();

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
      appBar: appBar(),
      /*body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_user == null)
              const Text("Loading")
            else
              ...[
                  Text("Hello", style: Theme.of(context).textTheme.displayMedium
                ),
                Text(_user.userId),
                Text(_user.username)
              ],
          ],
        ),
      ),*/
      body: skribesSection(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'skribeX',
        style: TextStyle(
            color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.teal,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/left.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("Signing out.");
            Amplify.Auth.signOut().then(
                (_) => {Navigator.pushReplacementNamed(context, "/login")});
            print("signed out.");
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/logout_icon.svg',
              height: 20,
              width: 20,
            ),
          ),
        )
      ],
    );
  }

  Column skribesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Choose Your Skribe',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            )),
        const SizedBox(height: 20), // Space between text and the boxes
        SizedBox(
          height: 150,
          child: ListView.separated(
            itemCount: skribeModels.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 26,
              right: 26,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => {
                        // print(skribeModels[index].name);
                        execSkribeModel(context, skribeModels[index].name)
                      },
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: skribeModels[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Colors.orangeAccent,
                              shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                SvgPicture.asset(skribeModels[index].iconPath),
                          ),
                        ),
                        Text(
                          skribeModels[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 14),
                        )
                      ],
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }

  execSkribeModel(BuildContext context, String name) {
    print(name);
    if (name == "Mileage") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MapTrack()),
      );
    } else {}
  }
}
