  import 'package:flutter/material.dart';


ThemeData buildTheme(Brightness brightness) {
    return brightness == Brightness.dark
        ? ThemeData.dark().copyWith(
            cardColor: Colors.grey,
            accentColor: Colors.grey,
            primaryColor: Colors.grey,
            primaryTextTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                subtitle: TextStyle(fontSize: 16, color: Colors.white),),
            iconTheme: IconThemeData(color: Colors.red),
            buttonColor: Colors.white,
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                  fontFamily: 'Roboto',
                ),
            backgroundColor: Colors.black)
        : ThemeData.light().copyWith(
            cardColor: Colors.white,
            accentColor: Colors.red,
            primaryColor: Colors.red,
            primaryTextTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.normal),
                subtitle: TextStyle(fontSize: 16, color: Colors.white)),
            iconTheme: IconThemeData(color: Colors.red),
            buttonColor: Colors.grey,
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                  fontFamily: 'Roboto',
                ),
            backgroundColor: Colors.white);
  }