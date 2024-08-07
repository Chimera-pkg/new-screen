import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skribex_app/routes/app_routes.dart';

class MapTrackingController extends GetxController {
  final Location location = Location();
  var defaultZoom = 15.0;
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  List<LatLng> polylinePoints = [];
  //static const _defaultLatLng = LatLng(33.155373, -96.818733);
  final defaultLatLng = LatLng(37.38890729, -122.15994434);
  LatLng? startingPosition;
  DateTime? startTime;

  LatLng? currentPos;
  double totalDistance = 0.0;
  int elapsedTimeInSeconds = 0;
  bool isTrackingActive = true;
  // Add StreamController for elapsedTimeInSeconds
  late final StreamController<int> elapsedTimeStreamController;
  late final Stream<int> elapsedTimeStream;
  late final StreamController<double> elapsedDistanceStreamController;
  late final Stream<double> elapsedDistanceStream;
  late StreamSubscription<LocationData> locationSubscription;

  @override
  void onInit() {
    print("Sign In Sign Up Screen is Start");
    super.onInit();
    elapsedTimeStreamController = StreamController<int>.broadcast();
    elapsedDistanceStreamController = StreamController<double>.broadcast();
    // Initialize Stream
    elapsedTimeStream = elapsedTimeStreamController.stream;
    elapsedDistanceStream = elapsedDistanceStreamController.stream;
    getLocationUpdates();
  }

  @override
  void onClose() {
    // tabController.dispose();
    locationSubscription.cancel();
    // Close StreamController when the widget is disposed
    elapsedTimeStreamController.close();
    elapsedDistanceStreamController.close();
    super.onClose();
  }

  void cleanUpMap() {
    // Add logic to clean up map-related objects
    // For example, cancel location updates and clear polylinePoints
    location.onLocationChanged.drain();
    polylinePoints.clear();
    currentPos = null;
    // Reset total distance and elapsed time
    totalDistance = 0.0;
    elapsedTimeInSeconds = 0;

    // Close elapsed distance stream controller only if it is not closed already
    if (!elapsedDistanceStreamController.isClosed) {
      elapsedDistanceStreamController.close();
    }

    // Close elapsed time stream controller only if it is not closed already
    if (!elapsedTimeStreamController.isClosed) {
      elapsedTimeStreamController.close();
    }

    // Set relevant objects to null or empty
    polylinePoints.clear();
    currentPos = null;
  }

  void stopTracking() {
    // Clean up map-related objects
    cleanUpMap();
    // Navigate to the home page
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
    print("Closing Maps, going to home page.");
    Get.offAllNamed(RouteName.navigation);
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: pos, zoom: defaultZoom);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

    update();
  }

  void updateZoom(double zoom) {
    defaultZoom = zoom;
  }

  Future<void> getLocationUpdates() async {
    print("location");
    bool featureEnabled;
    PermissionStatus permissionStatus;

    featureEnabled = await location.serviceEnabled();
    if (featureEnabled) {
      print("Location feature is enabled");
      featureEnabled = await location.requestService();
    } else {
      print("Location feature is not enabled");
      return;
    }

    permissionStatus = await location.hasPermission();
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
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
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      print("listening");
      if (!isMounted) {
        // Do not continue if the widget is not mounted
        return;
      }
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        print(
            "Received location update: ${currentLocation.latitude}, ${currentLocation.longitude}");

        // setState(() {
        print("current position is updating.");
        if (lastPosition != null) {
          double distanceInMeters = Geolocator.distanceBetween(
            lastPosition!.latitude,
            lastPosition!.longitude,
            currentLocation.latitude!,
            currentLocation.longitude!,
          );

          // Update the total distance
          totalDistance += distanceInMeters;
          update();
          if (!elapsedDistanceStreamController.isClosed) {
            elapsedDistanceStreamController.add(totalDistance);
            update();
          }

          // Calculate elapsed time
          if (startTime == null) {
            startTime = DateTime.now();
            update();
          } else {
            DateTime currentTime = DateTime.now();
            Duration elapsed = currentTime.difference(startTime!);
            elapsedTimeInSeconds = elapsed.inSeconds;
            // Update the UI using the stream
            if (!elapsedTimeStreamController.isClosed) {
              elapsedTimeStreamController.add(elapsedTimeInSeconds);
            }
            update();
          }

          // Do something with distanceInMeters (e.g., update UI or store the total distance)
          print("Distance travelled: $distanceInMeters meters");
          print("Total distance travelled: ${totalDistance} meters");
        }
        if (currentPos == null) {
          // print("Setting current position to default: ${defaultLatLng}");
          // currentPos = defaultLatLng;
          currentPos =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          update();
        } else {
          print(
              "Setting current position to location update: $currentLocation");
          currentPos =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          if (startingPosition == null) {
            startingPosition = currentPos!;
          }
          update();
        }

        lastPosition = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );

        print(currentPos);
        if (startingPosition != null) {
          polylinePoints.add(currentPos!);
        }
        cameraToPosition(currentPos!);
        update();
        // });
      } else {
        print(
            "This is in else statement. At this moment the currentLocation lat and lng are NULL");
      }
      update();
    });

    // Add a listener to the widget's lifecycle to set isMounted accordingly
    WidgetsBinding.instance?.addObserver(_MapLifecycleObserver(onDisposed: () {
      isMounted = false;
      // Cancel the location subscription when the widget is disposed
      locationSubscription.cancel();
    }));

    update();
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
