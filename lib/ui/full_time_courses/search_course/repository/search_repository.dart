import 'package:algolia/algolia.dart';
import 'package:tp_app/models/course.dart';

class SearchRepository {
  static final Algolia algolia = Algolia.init(
    applicationId: 'XVRTA8E4T1',
    apiKey: '0fdf05b6dc737d0f893b0136174644ae',
  );

  Future<List<Course>> queryAgolia(String querydata) async {
    List<Course> courseData = List();
    AlgoliaQuery query =
        algolia.instance.index('prod_courses').search(querydata);

    // Get Result/Objects
    AlgoliaQuerySnapshot snap = await query.getObjects();

    snap.hits.forEach((element)=> courseData.add(Course.fromJson(element.data)));
    // Checking if has [AlgoliaQuerySnapshot]
    print('Hits count: ${snap.nbHits}');
    // print('${snap.hits.map((e) => print(e.data))}');
    // print('${snap.hits.for}');
    // return Course.fromJson(snap.hits.asMap());
    return courseData;
  }
}
