import 'package:flutter/material.dart';

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
          _buildStat('Distance', elapsedDistanceStream, Icons.directions_run),
          _buildStat(
              'Time', elapsedTimeStream, Icons.access_time), // Pass the stream
          ElevatedButton(
            onPressed: onStartStopPressed,
            child: const Text('Stop Tracking'),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, dynamic value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue, // Highlighted color for icons
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // Highlighted color for labels
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
                    : _formatDistance(snapshot.data as double),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return const Text('Loading...');
            }
          },
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
