import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:tp_app/models/map_place.dart';

import 'custom_scroll_view.dart';
import 'search/map_search_delegate.dart';

class MapboxPage extends StatefulWidget {
  MapboxPage({Key key}) : super(key: key);
  static const String routeName = "/mapBoxPage";

  @override
  _MapboxPageState createState() => _MapboxPageState();
}

class _MapboxPageState extends State<MapboxPage> {
  MapboxMapController mapController;
  List<String> items = List();
  List<MapPlace> locationList = List();
  Symbol _selectedSymbol;

  @override
  void initState() {
    items.add("wtf");
    items.add("wtsf");
    items.add("wtff");
    items.add("wfdtf");
    items.add("wweztf");
    items.add("wfstf");
    items.add("wtqf");
    super.initState();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onStyleLoaded() {
    this.mapController.addSymbol(
          SymbolOptions(
              geometry: LatLng(1.345465, 103.933515), iconImage: "triangle-15"),
        );
    // addImageFromAsset("assetImage", "assets/custom-icon.png");
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    mapController.updateSymbol(_selectedSymbol, changes);
  }

  /// Adds an asset image to the currently displayed style
  // Future<void> addImageFromAsset(String name, String assetName) async {
  //   final ByteData bytes = await rootBundle.load(assetName);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   return mapController.addImage(name, list);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            Scaffold(
              body: MapboxMap(
                onStyleLoadedCallback: _onStyleLoaded,
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                    target: LatLng(1.345465, 103.933515), zoom: 18),
                myLocationEnabled: true,
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
        floatingActionButton: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('map_places').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FloatingActionButton(
                onPressed: () async {
                  final DocumentSnapshot selected =
                      await showSearch<DocumentSnapshot>(
                    context: context,
                    delegate: new MapSearchDelegate(snapshot.data.documents),
                  );

                  if (selected != null) {
                    GeoPoint location = selected['location'];
                    mapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(location.latitude, location.longitude),
                      zoom: 17.0,
                    )));
                    this.mapController.addSymbol(
                          SymbolOptions(
                              geometry:
                                  LatLng(location.latitude, location.longitude),
                              iconImage: "circle-15"),
                        );
                  }
                },
                child: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                backgroundColor: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }
}
