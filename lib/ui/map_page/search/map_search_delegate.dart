import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MapSearchDelegate extends SearchDelegate<DocumentSnapshot> {
  final List<DocumentSnapshot> documents;

  MapSearchDelegate(this.documents);
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

  Widget buildSuggestions(BuildContext context) {
    List<DocumentSnapshot> items = documents.where((snapshot) {
      return (snapshot['name'] as String).toUpperCase().contains(query.toUpperCase()) ||
          snapshot['description'].contains(query.toUpperCase());
    }).toList()
      ..sort((a, b) {
        if (a['name'] == query.toUpperCase()) return -1;
        if (b['name'] == query.toUpperCase()) return 1;

        return 0;
      });

    return new ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return new ListTile(
          title: new Text(items[index]['name']),
          onTap: () {
            close(context, items[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
