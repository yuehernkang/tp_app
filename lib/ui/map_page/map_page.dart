import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'custom_scroll_view.dart';

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
  Set<Polygon> _polygons = {};
  List<LatLng> polygonLatlngs = List<LatLng>();
  BitmapDescriptor myIcon;
  Location location;
  String googleAPIKey = 'AIzaSyCo35OuMWo6FPVIRVxAaQK0GamMhK7U4Og';
  PolylinePoints polylinePoints;
  LocationData currentLocation;
  LocationData destinationLocation;
  String _mapStyle;

  //1.341251, 103.934042
  //1.349025, 103.927803
  //1.345485, 103.935755
  //1.346361, 103.928061
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkPermissions() {
    location.hasPermission().then((value) {
      if (value == PermissionStatus.denied) {
        print("permission denied");
        location.requestPermission();
      }
    });
  }

  Future<bool> checkIfInTP(LatLng currentLocation) async {
    return await GoogleMapPolyUtil.containsLocation(
        polygon: polygonLatlngs, point: currentLocation);
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });

    location = new Location();
    polylinePoints = PolylinePoints();
    checkPermissions();
    location.onLocationChanged.listen((LocationData cLoc) {
      checkIfInTP(LatLng(cLoc.latitude, cLoc.longitude))
          .then((value) => print(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    polygonLatlngs.add(LatLng(1.341251, 103.934042));
    polygonLatlngs.add(LatLng(1.345485, 103.935755));

    polygonLatlngs.add(LatLng(1.349025, 103.927803));
    polygonLatlngs.add(LatLng(1.346361, 103.928061));

    _polygons.add(Polygon(
        polygonId: PolygonId("TP"),
        points: polygonLatlngs,
        strokeWidth: 2,
        strokeColor: Colors.yellow,
        fillColor: Colors.yellow.withOpacity(0.01)));

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
      markerId: MarkerId("library"),
      position: LatLng(1.345080, 103.932599),
      infoWindow: InfoWindow(
        title: 'library',
        snippet: 'Great place to study!',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    _markers.add(Marker(
      markerId: MarkerId("McDonalds"),
      position: LatLng(1.345124, 103.931652),
      infoWindow: InfoWindow(
        title: 'McDonalds',
        snippet: 'Great place for nice burgers!',
      ),
      icon: myIcon,
    ));

    return SafeArea(
      child: new Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: GoogleMap(
                compassEnabled: true,
                buildingsEnabled: true,
                myLocationEnabled: true,
                indoorViewEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: MapPage._kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.setMapStyle(_mapStyle);
                },
                markers: _markers,
                polylines: {},
                polygons: _polygons,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.30,
              minChildSize: 0.15,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SafeArea(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: CustomScrollViewContent()),
                );
              },
            ),
          ],
        ),
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
