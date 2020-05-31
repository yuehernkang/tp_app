import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapboxPage extends StatefulWidget {
  MapboxPage({Key key}) : super(key: key);
  static const String routeName = "/mapBoxPage";

  @override
  _MapboxPageState createState() => _MapboxPageState();
}

//class _MapboxPageState extends State<MapboxPage> {
//  @override
//  Widget build(BuildContext context) {
//    return FlutterMap(
//      options: new MapOptions(
//        center: new LatLng(1.345465, 103.933515),
//        zoom: 2.0,
//      ),
//      layers: [
//        new TileLayerOptions(
//          urlTemplate:"https://api.mapbox.com/v4/"
//              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
//          additionalOptions: {
//            'accessToken': 'pk.eyJ1IjoieXVlaGVybiIsImEiOiJjanIzcDd6czIxMDlkNDNybHQ0NnV5dmt5In0.2nLiY5zO6NFEqME_p8cyPw',
//            'id': 'mapbox.mapbox-streets-v8',
//          },
//        ),
//      ],
//    );
//  }
//}
class _MapboxPageState extends State<MapboxPage> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
            target: LatLng(1.345465, 103.933515), zoom: 18),
        myLocationEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                const CameraPosition(
                  target: LatLng(1.34600481, 103.93059009),
                  zoom: 17.0,
                )));

        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
      ),
    );
  }
}
