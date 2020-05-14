import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tp_app/models/course.dart';
import 'package:tp_app/ui/full_time_courses/search_course/repository/search_repository.dart';

part 'ft_course_search_event.dart';
part 'ft_course_search_state.dart';

class FtCourseSearchBloc
    extends Bloc<FtCourseSearchEvent, FtCourseSearchState> {
  final SearchRepository searchRepository;

  FtCourseSearchBloc(this.searchRepository);
  @override
  FtCourseSearchState get initialState => FtCourseSearchState.initial();

  @override
  Stream<FtCourseSearchState> mapEventToState(
    FtCourseSearchEvent event,
  ) async* {
    if (event.query != "") {
      yield FtCourseSearchState.loading();
      try {
        List<Course> courses = await searchRepository.queryAgolia(event.query);
        yield FtCourseSearchState.success(courses);
      } catch (_) {
        yield FtCourseSearchState.error();
      }
    }
    else{
      List<Course> courses = List();

      yield FtCourseSearchState.success(courses);

    }
  }
}
