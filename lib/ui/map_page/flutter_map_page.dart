import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'custom_scroll_view.dart';
import 'search/map_search_delegate.dart';

//1.34852767,103.9284714
//1.34690025,103.92753818
//1.34131782, 103.93414403
//1.34529714, 103.93581999
List<Marker> markers = [];

class FlutterMapPage extends StatefulWidget {
  FlutterMapPage({Key key}) : super(key: key);
  static const String routeName = "/flutterMapPage";

  @override
  _MapboxPageState createState() => _MapboxPageState();
}

class _MapboxPageState extends State<FlutterMapPage> {
  MapController mapController;
  static LatLng one = LatLng(1.34852767, 103.9284714);
  static LatLng two = LatLng(1.34690025, 103.92753818);
  static LatLng three = LatLng(1.34131782, 103.93414403);
  static LatLng four = LatLng(1.34529714, 103.93581999);
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    markers.clear();
    return SafeArea(
      child: Scaffold(
          appBar: FloatAppBar(mapController: mapController),
          resizeToAvoidBottomPadding: false,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: <Widget>[
              FlutterMap(
                mapController: mapController,
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
                    markers: markers,
                  ),
                ],
              ),
              SnappingSheet(
                  snapPositions: [
                    SnapPosition(
                        positionFactor: 0.20,
                        snappingCurve: Curves.ease,
                        snappingDuration: Duration(milliseconds: 500)),
                    SnapPosition(
                        positionFactor: 0.9,
                        snappingCurve: Curves.ease,
                        snappingDuration: Duration(milliseconds: 750)),
                    SnapPosition(
                        positionFactor: 0.01,
                        snappingCurve: Curves.ease,
                        snappingDuration: Duration(milliseconds: 500)),
                  ],
                  sheetBelow: SnappingSheetContent(
                      child: SingleChildScrollView(
                        child: CustomScrollViewContent(),
                      ),
                      heightBehavior: SnappingSheetHeight.fit()),
                  grabbing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Card(
                        elevation: 12.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: FutureBuilder(
                              future: Firestore.instance
                                  .collection("map_places_list")
                                  .getDocuments(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(height: 12),
                                    CustomDraggingHandle(),
                                    SizedBox(height: 16),
                                    CustomExploreTemasekPolytechnic(
                                      snapshot: snapshot,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ))),
            ],
          )),
    );
  }
}

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  final MapController mapController;

  FloatAppBar({this.mapController});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          right: 15,
          left: 15,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream:
                        Firestore.instance.collection('map_places').snapshots(),
                    builder: (context, snapshot) {
                      return Expanded(
                        child: TextField(
                          onTap: () async {
                            final DocumentSnapshot selected =
                                await showSearch<DocumentSnapshot>(
                              context: context,
                              delegate: new MapSearchDelegate(
                                  snapshot.data.documents),
                            );

                            if (selected != null) {
                              markers.clear();
                              GeoPoint location = selected['location'];
                              mapController.move(
                                  LatLng(location.latitude, location.longitude),
                                  18);
                              markers.add(new Marker(
                                width: 80.0,
                                height: 80.0,
                                point: new LatLng(
                                    location.latitude, location.longitude),
                                builder: (ctx) => new Container(
                                  child: new FlutterLogo(),
                                ),
                              ));
                            }
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search..."),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
