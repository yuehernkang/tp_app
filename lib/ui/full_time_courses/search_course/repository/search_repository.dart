import 'package:tp_app/models/course.dart';

class SearchRepository {
  // static final Algolia algolia = Algolia.init(
  //   applicationId: 'XVRTA8E4T1',
  //   apiKey: '0fdf05b6dc737d0f893b0136174644ae',
  // );

  // Future<List<Course>> queryAgolia(String querydata) async {
  //   List<Course> courseData = List();
  //   AlgoliaQuery query =
  //       algolia.instance.index('prod_courses').search(querydata);

  //   AlgoliaQuerySnapshot snap = await query.getObjects();

  //   snap.hits.forEach((element)=> courseData.add(Course.fromJson(element.data)));
  //   print('Hits count: ${snap.nbHits}');
  //   return courseData;
  // }
}
