import 'dart:async';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/ft_course_search_bloc.dart';

class CourseSearchDelegate extends SearchDelegate {
  final FtCourseSearchBloc ftCourseSearchBloc;

  CourseSearchDelegate({this.ftCourseSearchBloc});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    this.ftCourseSearchBloc.add(FtCourseSearchEvent(query));
    return BlocBuilder(
      bloc: this.ftCourseSearchBloc,
      builder: (BuildContext context, FtCourseSearchState state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.hasError) {
          return Container(
            child: Text('error'),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.courses[index].courseName),
            );
          },
          itemCount: state.courses.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final debouncer = Debouncer<String>(Duration(milliseconds: 1000));
    debouncer.value = query;
    debouncer.values.listen((event) {
      print(event);
      this.ftCourseSearchBloc.add(FtCourseSearchEvent(event));
    });

    return BlocBuilder(
      bloc: this.ftCourseSearchBloc,
      builder: (BuildContext context, FtCourseSearchState state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.hasError) {
          return Container(
            child: Text('error'),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.courses[index].courseName),
            );
          },
          itemCount: state.courses.length,
        );
      },
    );
  }
}
