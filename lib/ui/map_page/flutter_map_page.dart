import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class FlutterMapPage extends StatefulWidget {
  FlutterMapPage({Key key}) : super(key: key);
  static const String routeName = "/flutterMapPage";

  @override
  _MapboxPageState createState() => _MapboxPageState();
}

class _MapboxPageState extends State<FlutterMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("hello"),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(1.34482278, 103.93359462),
            zoom: 18.0,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/yuehern/ckbjwcvx806wj1ir108a97tde/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoieXVlaGVybiIsImEiOiJjanIzcDd6czIxMDlkNDNybHQ0NnV5dmt5In0.2nLiY5zO6NFEqME_p8cyPw',
                'id': 'mapbox.mapbox-streets-v8',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(1.34482278, 103.93359462),
                  builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
