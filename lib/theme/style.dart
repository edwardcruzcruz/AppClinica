import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primaryColor: Colors.white,
    accentColor: Color.fromRGBO(68, 66,66, 100),
    hintColor: Color.fromRGBO(135, 134,138, 100),
    dividerColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.black,

    buttonColor:Color.fromRGBO(19, 206,148, 100),
    textSelectionColor: Color.fromRGBO(9,125, 124, 100),
    cardColor: Color.fromRGBO(19, 206, 177, 100),
    textTheme: TextTheme(title: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),)
  );
}