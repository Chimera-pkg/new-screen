import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class BottomSection extends StatelessWidget {
  BottomSection({
    Key? key,
    //required this.totalDistance,
    required this.elapsedDistanceStream,
    //required this.elapsedTimeInSeconds,
    required this.elapsedTimeStream,
    required bool isTrackingActive,
    required this.onStartStopPressed,
  }) : super(key: key);

  //double totalDistance;
  //int elapsedTimeInSeconds;
  final Stream<int> elapsedTimeStream;
  final Stream<double> elapsedDistanceStream;
  final VoidCallback onStartStopPressed;

  @override
  Widget build(BuildContext context) {
    //print("totalDistance in BottomSection : $totalDistance");
    //print("elapsedTimeInSeconds in BottomSection: $elapsedTimeInSeconds");
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStat('Distance', elapsedDistanceStream,
              "assets/icons/distance_tracking.svg"),
          _buildStat('Time', elapsedTimeStream,
              "assets/icons/time_tracking.svg"), // Pass the stream
          InkWell(
            onTap: onStartStopPressed,
            child: Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                  color: colorNavy, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: const Text(
                'Stop Tracking',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colorWhite),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStat(String label, dynamic value, String iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: ,
      children: [
        SvgPicture.asset(
          iconPath,
          height: 24,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            StreamBuilder<dynamic>(
              stream: value,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    label == 'Time'
                        ? _formatTime(snapshot.data as int)
                        : _formatDistance(snapshot.data.toDouble()),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    return [duration.inHours, duration.inMinutes % 60, duration.inSeconds % 60]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  String _formatDistance(double meters) {
    const double metersInOneMile = 1609.34;
    final double miles = meters / metersInOneMile;
    return '${miles.toStringAsFixed(2)} miles';
  }
}
