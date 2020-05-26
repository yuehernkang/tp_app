import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);
  static const String routeName = "/mapPage";

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.345534, 103.932822),
    zoom: 18,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  BitmapDescriptor myIcon;
  Location location;
  String googleAPIKey = 'AIzaSyCo35OuMWo6FPVIRVxAaQK0GamMhK7U4Og';
  PolylinePoints polylinePoints;
  LocationData currentLocation;
  LocationData destinationLocation;

  @override
  void initState() {
    super.initState();
    location = new Location();
    polylinePoints = PolylinePoints();
    location.onLocationChanged.listen((LocationData cLoc) {
      print(cLoc.latitude);
     });
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
      markerId: MarkerId("subway"),
      position: LatLng(1.344928, 103.932481),
      infoWindow: InfoWindow(
        title: 'Subway',
        snippet: 'Great place for nice sandwiches!',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    _markers.add(Marker(
      markerId: MarkerId("McDonalds"),
      position: LatLng(1.345124, 103.931652),
      infoWindow: InfoWindow(
        title: 'Subway',
        snippet: 'Great place for nice sandwiches!',
      ),
      icon: myIcon,
    ));
    return new Scaffold(
      body: GoogleMap(
        buildingsEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: MapPage._kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        polylines: {},
      ),
    );
  }

  // void setPolylines() async {
  //   List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPIKey,
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       destinationLocation.latitude,
  //       destinationLocation.longitude);

  //   if (result.isNotEmpty) {
  //     result.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });

  //     setState(() {
  //       _polylines.add(Polyline(
  //           width: 2, // set the width of the polylines
  //           polylineId: PolylineId("poly"),
  //           color: Color.fromARGB(255, 40, 122, 198),
  //           points: polylineCoordinates));
  //     });
  //   }
  // }

//     void updatePinOnMap() async {
//     // create a new CameraPosition instance
//     // every time the location changes, so the camera
//     // follows the pin as it moves with an animation
//     CameraPosition cPosition = CameraPosition(
//       zoom: CAMERA_ZOOM,
//       tilt: CAMERA_TILT,
//       bearing: CAMERA_BEARING,
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//     );
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//     // do this inside the setState() so Flutter gets notified
//     // that a widget update is due
//     setState(() {
//       // updated position
//       var pinPosition =
//           LatLng(currentLocation.latitude, currentLocation.longitude);

//       sourcePinInfo.location = pinPosition;

//       // the trick is to remove the marker (by id)
//       // and add it again at the updated location
//       _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           onTap: () {
//             setState(() {
//               currentlySelectedPin = sourcePinInfo;
//               pinPillPosition = 0;
//             });
//           },
//           position: pinPosition, // updated position
//           icon: sourceIcon));
//     });
//   }
// }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(MapPage._kLake));
//   }
}
