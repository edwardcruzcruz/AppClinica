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

    buttonColor:Color(0xFF00817c),
    textSelectionColor: Color.fromRGBO(9,125, 124, 100),
    cardColor: Color.fromRGBO(19, 206, 177, 100),
    textTheme: TextTheme(
      button: TextStyle(fontSize: 20.0,fontFamily: 'Myriad Pro',color: Colors.white),
      title: TextStyle(fontSize: 12.0,fontFamily: 'Myriad Pro',color: Color(0xFF87868a)),
      subtitle: TextStyle(fontSize: 12.0,fontFamily: 'Myriad Pro',color: Color(0xFF097d7c)),
      body1: TextStyle(fontSize: 13.0,fontFamily: 'Myriad Pro',color: Color.fromRGBO(68, 66,66, 100)),
      body2: TextStyle(fontSize: 13.0,fontFamily: 'Myriad Pro',color: Color(0xFF097d7c)),
    )
  );
}