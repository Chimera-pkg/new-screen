import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skribex_app/file_ori_backup/pages/map_track_v1.dart';

import '../models/skribe_model.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<SkribeModel> skribeModels = [];

  void getSkribes() {
    skribeModels = SkribeModel.getSkirbes();
  }

  @override
  Widget build(BuildContext context) {
    getSkribes();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.amber[300],
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 40,
        ),
        skribesSection(),
        const SizedBox(
          height: 40,
        ),
        const SignOutButton(),
      ]),
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
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
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
        MaterialPageRoute(builder: (context) => const MapTrackV1()),
      );
    } else {}
  }
}
