part of 'ft_course_search_bloc.dart';

class FtCourseSearchState {
  final bool isLoading;
  final List<Course> courses;
  final bool hasError;

  FtCourseSearchState({this.isLoading, this.courses, this.hasError});

  factory FtCourseSearchState.initial() {
    return FtCourseSearchState(
      courses: [],
      isLoading: false,
      hasError: false
    );
  }

  factory FtCourseSearchState.loading(){
    return FtCourseSearchState(
      courses: [],
      isLoading: true,
      hasError: false
    );
  }

  factory FtCourseSearchState.success(List<Course> courses){
    return FtCourseSearchState(
      courses: courses,
      isLoading: false,
      hasError: false
    );
  }

    factory FtCourseSearchState.error(){
    return FtCourseSearchState(
      courses: [],
      isLoading: false,
      hasError: true,
    );
  }
}

