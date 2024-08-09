import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
// import 'package:skribex_app/file_ori_backup/configvariables.dart';
import 'package:geolocator/geolocator.dart';

import '../custom_widgets/map_bottom_section.dart';
import 'home.dart';

class MapTrackV1 extends StatefulWidget {
  const MapTrackV1({super.key});
  @override
  State<MapTrackV1> createState() => _MapPageState();
}

class _MapPageState extends State<MapTrackV1> {
  final Location _location = Location();
  static const defaultZoom = 15.0;
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  List<LatLng> polylinePoints = [];
  //static const _defaultLatLng = LatLng(33.155373, -96.818733);
  static const _defaultLatLng = LatLng(37.38890729, -122.15994434);
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
  void initState() {
    super.initState();
    // Initialize StreamController
    elapsedTimeStreamController = StreamController<int>.broadcast();
    elapsedDistanceStreamController = StreamController<double>.broadcast();
    // Initialize Stream
    elapsedTimeStream = elapsedTimeStreamController.stream;
    elapsedDistanceStream = elapsedDistanceStreamController.stream;
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          Expanded(
            child: currentPos == null
                ? const Center(
                    child: Text("Your map is loading, stay tuned..."))
                : GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      googleMapController.complete(controller);
                      if (currentPos != null) {
                        print(
                            "Initial position set to default ---- : $_defaultLatLng");
                        cameraToPosition(_defaultLatLng!);
                        print(
                            "Initial position set to default ***** : $_defaultLatLng");
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: _defaultLatLng!,
                      zoom: defaultZoom,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("_sourceLocation"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        position: _defaultLatLng,
                      ),
                      Marker(
                        markerId: MarkerId("_currentLocation"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                        position: currentPos!,
                      ),
                    },
                    polylines: {
                      Polyline(
                          polylineId: const PolylineId("route"),
                          color: Colors.greenAccent,
                          width: 10,
                          points: polylinePoints)
                    },
                  ),
          ),
          // Footer
          // Bottom Section
          BottomSection(
            //totalDistance: totalDistance,
            elapsedDistanceStream: elapsedDistanceStream,
            //elapsedTimeInSeconds: elapsedTimeInSeconds,
            elapsedTimeStream: elapsedTimeStream,
            isTrackingActive: isTrackingActive,
            onStartStopPressed: () {
              // Toggle tracking state
              setState(() {
                isTrackingActive = !isTrackingActive;
              });
              if (isTrackingActive) {
                // Start tracking
                startTracking();
              } else {
                // Stop tracking
                stopTracking();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Cancel the location subscription when the widget is disposed
    locationSubscription.cancel();
    // Close StreamController when the widget is disposed
    elapsedTimeStreamController.close();
    elapsedDistanceStreamController.close();
    super.dispose();
  }

  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await googleMapController.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: pos, zoom: defaultZoom);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  void startTracking() {
    // Add logic to start tracking
    print("Start Tracking");
  }

  void stopTracking() {
    // Clean up map-related objects
    cleanUpMap();
    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    print("Closing Maps, going to home page.");
  }

  /*Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(GOOGLE_MAPS_API_KEY, origin, destination)
  }*/

  Future<void> getLocationUpdates() async {
    print("location");
    bool featureEnabled;
    PermissionStatus permissionStatus;

    featureEnabled = await _location.serviceEnabled();
    if (featureEnabled) {
      print("Location feature is enabled");
      featureEnabled = await _location.requestService();
    } else {
      print("Location feature is not enabled");
      return;
    }

    permissionStatus = await _location.hasPermission();
    print(permissionStatus);
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
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
        _location.onLocationChanged.listen((LocationData currentLocation) {
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
            totalDistance += distanceInMeters;
            if (!elapsedDistanceStreamController.isClosed) {
              elapsedDistanceStreamController.add(totalDistance);
            }

            // Calculate elapsed time
            if (startTime == null) {
              startTime = DateTime.now();
            } else {
              DateTime currentTime = DateTime.now();
              Duration elapsed = currentTime.difference(startTime!);
              elapsedTimeInSeconds = elapsed.inSeconds;
              // Update the UI using the stream
              if (!elapsedTimeStreamController.isClosed) {
                elapsedTimeStreamController.add(elapsedTimeInSeconds);
              }
            }

            // Do something with distanceInMeters (e.g., update UI or store the total distance)
            print("Distance travelled: $distanceInMeters meters");
            print("Total distance travelled: $totalDistance meters");
          }
          if (currentPos == null) {
            print("Setting current position to default: $_defaultLatLng");
            currentPos = _defaultLatLng;
          } else {
            print(
                "Setting current position to location update: $currentLocation");
            currentPos =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
          }

          lastPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );

          print(currentPos);
          polylinePoints.add(currentPos!);
          cameraToPosition(currentPos!);
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
      locationSubscription.cancel();
    }));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'skribeX',
        style: TextStyle(
            color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.lightBlueAccent,
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

  void cleanUpMap() {
    // Add logic to clean up map-related objects
    // For example, cancel location updates and clear polylinePoints
    _location.onLocationChanged.drain();
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
