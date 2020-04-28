import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TPFullTimeBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.heart),
          title: Text('Favourites'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Courses'),
        ),
      ],
    );
  }
}
