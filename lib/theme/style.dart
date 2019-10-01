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
    accentColor: Colors.orange,
    hintColor: HexColor("#87868a"),
    dividerColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    buttonColor:Color.fromRGBO(19, 206,148, 100),
    cardColor: Color.fromRGBO(19, 206, 177, 100),
    textTheme: TextTheme(title: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic),)
  );
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}