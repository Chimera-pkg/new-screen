// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:skribex_app/controllers/mapTracking_controller.dart';
// import 'package:skribex_app/widgets/map_bottom_section.dart';

// class MapTrackScreen extends StatelessWidget {
//   MapTrackScreen({super.key});
//   final mapTrackingController = Get.find<MapTrackingController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: GetBuilder<MapTrackingController>(
//               init: MapTrackingController(),
//               builder: (mapTrackingController) {
//                 return mapTrackingController.currentPos == null
//                     ? Center(child: Text("Your map is loading, stay tuned..."))
//                     : GoogleMap(
//                         onMapCreated: (GoogleMapController controller) {
//                           mapTrackingController.googleMapController
//                               .complete(controller);
//                           if (mapTrackingController.currentPos != null) {
//                             print(
//                                 "Initial position set to default ---- : ${mapTrackingController.defaultLatLng}");
//                             mapTrackingController.cameraToPosition(
//                                 mapTrackingController.defaultLatLng!);
//                             print(
//                                 "Initial position set to default ***** : ${mapTrackingController.defaultLatLng}");
//                           }
//                         },
//                         initialCameraPosition: CameraPosition(
//                           target: mapTrackingController.defaultLatLng!,
//                           zoom: mapTrackingController.defaultZoom,
//                         ),
//                         onCameraMove: (CameraPosition position) {
//                           mapTrackingController.updateZoom(position
//                               .zoom); // Perbarui nilai zoom saat pengguna mengubahnya
//                         },
//                         markers: {
//                           Marker(
//                             markerId: MarkerId("_sourceLocation"),
//                             icon: BitmapDescriptor.defaultMarkerWithHue(
//                                 BitmapDescriptor.hueGreen),
//                             position: mapTrackingController.startingPosition ??
//                                 mapTrackingController.defaultLatLng,
//                           ),
//                           Marker(
//                             markerId: MarkerId("_currentLocation"),
//                             icon: BitmapDescriptor.defaultMarkerWithHue(
//                                 BitmapDescriptor.hueBlue),
//                             position: mapTrackingController.currentPos!,
//                           ),
//                         },
//                         polylines: {
//                           Polyline(
//                               polylineId: const PolylineId("route"),
//                               color: Colors.red,
//                               width: 10,
//                               points: mapTrackingController.polylinePoints)
//                         },
//                       );
//               },
//             ),
//           ),
//           // Footer
//           // Bottom Section
//           BottomSection(
//             //totalDistance: totalDistance,
//             elapsedDistanceStream: mapTrackingController.elapsedDistanceStream,
//             //elapsedTimeInSeconds: elapsedTimeInSeconds,
//             elapsedTimeStream: mapTrackingController.elapsedTimeStream,
//             isTrackingActive: mapTrackingController.isTrackingActive,
//             onStartStopPressed: () {
//               // Toggle tracking state
//               mapTrackingController.isTrackingActive =
//                   !mapTrackingController.isTrackingActive;
//               if (mapTrackingController.isTrackingActive) {
//                 // Start tracking
//                 startTracking();
//               } else {
//                 // Stop tracking
//                 mapTrackingController.stopTracking();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void startTracking() {
//     print("Start Tracking");
//   }

//   AppBar appBar() {
//     return AppBar(
//       title: const Text(
//         'skribeX',
//         style: TextStyle(
//             color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       elevation: 0.0,
//       centerTitle: true,
//     );
//   }
// }
