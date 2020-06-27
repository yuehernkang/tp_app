import 'package:cloud_firestore/cloud_firestore.dart';

class MapPlace{
  String name, description;
  GeoPoint location;

  MapPlace({this.name, this.description, this.location});

  factory MapPlace.fromSnapshot(DocumentSnapshot snapshot){
    return MapPlace(
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      location: snapshot.data['location']
    );
  }
}