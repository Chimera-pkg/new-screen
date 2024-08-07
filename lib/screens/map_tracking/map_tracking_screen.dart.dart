import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skribex_app/controllers/map_tracking_controller.dart';
import 'package:skribex_app/utils/constant/themes.dart';
import 'package:skribex_app/widgets/map_bottom_section.dart';

class MapTrackScreen extends StatefulWidget {
  const MapTrackScreen({super.key});
  @override
  State<MapTrackScreen> createState() => _MapPageState();
}

class _MapPageState extends State<MapTrackScreen> {
  final mapTrackingController = Get.find<MapTrackingController>();

  @override
  void initState() {
    super.initState();
    // mapTrackingController.getLocationUpdates();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: appBar(),
      body: Column(
        children: [
          Expanded(
            child: mapTrackingController.currentPos == null
                ? const Center(
                    child: Text("Your map is loading, stay tuned..."))
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      mapTrackingController.googleMapController
                          .complete(controller);
                      if (mapTrackingController.currentPos != null) {
                        print(
                            "Initial position set to default ---- : ${mapTrackingController.defaultLatLng}");
                        mapTrackingController.cameraToPosition(
                            mapTrackingController.defaultLatLng!);
                        print(
                            "Initial position set to default ***** : ${mapTrackingController.defaultLatLng}");
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: mapTrackingController.defaultLatLng!,
                      zoom: mapTrackingController.defaultZoom,
                    ),
                    markers: {
                      if (mapTrackingController.startingPosition != null)
                        Marker(
                            markerId: MarkerId("_sourceLocation"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen),
                            position: mapTrackingController.startingPosition!),
                      if (mapTrackingController.currentPos != null)
                        Marker(
                          markerId: MarkerId("_currentLocation"),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                          position: mapTrackingController.currentPos!,
                        ),
                    },
                    polylines: {
                      Polyline(
                          polylineId: const PolylineId("route"),
                          color: Colors.greenAccent,
                          width: 10,
                          points: mapTrackingController.polylinePoints)
                    },
                  ),
          ),
          // Footer
          // Bottom Section
          BottomSection(
            //totalDistance: totalDistance,
            elapsedDistanceStream: mapTrackingController.elapsedDistanceStream,
            //elapsedTimeInSeconds: elapsedTimeInSeconds,
            elapsedTimeStream: mapTrackingController.elapsedTimeStream,
            isTrackingActive: mapTrackingController.isTrackingActive,
            onStartStopPressed: () {
              // Toggle tracking state
              setState(() {
                mapTrackingController.isTrackingActive =
                    !mapTrackingController.isTrackingActive;
              });
              if (mapTrackingController.isTrackingActive) {
                // Start tracking
                startTracking();
              } else {
                // Stop tracking
                mapTrackingController.stopTracking();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTracking() {
    // Add logic to start tracking
    print("Start Tracking");
  }

  /*Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(GOOGLE_MAPS_API_KEY, origin, destination)
  }*/

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'skribeX',
        style: TextStyle(
            color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      // backgroundColor: Colors.lightBlueAccent,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
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
    );
  }

  Future<void> getLocationUpdates() async {
    print("location");
    bool featureEnabled;
    PermissionStatus permissionStatus;

    featureEnabled = await mapTrackingController.location.serviceEnabled();
    if (featureEnabled) {
      print("Location feature is enabled");
      featureEnabled = await mapTrackingController.location.requestService();
    } else {
      print("Location feature is not enabled");
      return;
    }

    permissionStatus = await mapTrackingController.location.hasPermission();
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus =
          await mapTrackingController.location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        print("Permission not granted, returning");
        return;
      }
    }
    print(permissionStatus);

    LatLng? lastPosition;
    // Check if the widget is mounted before calling setState
    bool isMounted = true;

    // Assign the subscription to the locationSubscription variable
    mapTrackingController.locationSubscription = mapTrackingController
        .location.onLocationChanged
        .listen((LocationData currentLocation) {
      print("listening");
      if (!isMounted) {
        // Do not continue if the widget is not mounted
        return;
      }
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        print(
            "Received location update: ${currentLocation.latitude}, ${currentLocation.longitude}");

        setState(() {
          print("current position is updating.");
          if (lastPosition != null) {
            double distanceInMeters = Geolocator.distanceBetween(
              lastPosition!.latitude,
              lastPosition!.longitude,
              currentLocation.latitude!,
              currentLocation.longitude!,
            );

            // Update the total distance
            mapTrackingController.totalDistance += distanceInMeters;
            if (!mapTrackingController
                .elapsedDistanceStreamController.isClosed) {
              mapTrackingController.elapsedDistanceStreamController
                  .add(mapTrackingController.totalDistance);
            }

            // Calculate elapsed time
            if (mapTrackingController.startTime == null) {
              mapTrackingController.startTime = DateTime.now();
            } else {
              DateTime currentTime = DateTime.now();
              Duration elapsed =
                  currentTime.difference(mapTrackingController.startTime!);
              mapTrackingController.elapsedTimeInSeconds = elapsed.inSeconds;
              // Update the UI using the stream
              if (!mapTrackingController.elapsedTimeStreamController.isClosed) {
                mapTrackingController.elapsedTimeStreamController
                    .add(mapTrackingController.elapsedTimeInSeconds);
              }
            }

            // Do something with distanceInMeters (e.g., update UI or store the total distance)
            print("Distance travelled: $distanceInMeters meters");
            print(
                "Total distance travelled: ${mapTrackingController.totalDistance} meters");
          }
          if (mapTrackingController.currentPos == null) {
            print(
                "Setting current position to default: ${mapTrackingController.defaultLatLng}");
            mapTrackingController.currentPos =
                mapTrackingController.defaultLatLng;
          } else {
            print(
                "Setting current position to location update: $currentLocation");
            mapTrackingController.currentPos =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          }

          lastPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );

          print(mapTrackingController.currentPos);
          mapTrackingController.polylinePoints
              .add(mapTrackingController.currentPos!);
          mapTrackingController
              .cameraToPosition(mapTrackingController.currentPos!);
        });
      } else {
        print(
            "This is in else statement. At this moment the currentLocation lat and lng are NULL");
      }
    });

    // Add a listener to the widget's lifecycle to set isMounted accordingly
    WidgetsBinding.instance?.addObserver(_MapLifecycleObserver(onDisposed: () {
      isMounted = false;
      // Cancel the location subscription when the widget is disposed
      mapTrackingController.locationSubscription.cancel();
    }));
  }
}

class _MapLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onDisposed;

  _MapLifecycleObserver({required this.onDisposed});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      onDisposed();
    }
  }
}
