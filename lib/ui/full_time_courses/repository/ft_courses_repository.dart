import 'package:cloud_firestore/cloud_firestore.dart';

class FtCoursesRepository{
  final Firestore _firestore;

  FtCoursesRepository(this._firestore);

  // Future<DocumentSnapshot> queryForCourse(String documentID){
  //   return _firestore.collection('courses').
  // }
}