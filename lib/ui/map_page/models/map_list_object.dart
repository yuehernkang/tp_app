import 'package:cloud_firestore/cloud_firestore.dart';

class MapListObject{
  String name, description;
  GeoPoint location;

  MapListObject({this.name, this.description, this.location});

  factory MapListObject.fromSnapshot(DocumentSnapshot snapshot){
    return MapListObject(
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      location: snapshot.data['location']
    );
  }
}