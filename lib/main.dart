import 'package:flutter/material.dart';
import 'package:flutter_app/screens/splash.dart';
import 'package:flutter_app/services/Shared_Preferences.dart';


Future<void> main() async{
  try {
    await setupLocator();
    runApp(MyApp());
  } catch(error) {
    print('Locator setup has failed');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // Todas sus apliaciones deben de estar dentro de Material App para poder
    // hacer uso de las facilidades de Material Design puede omitirce esto pero
    // no podran hacer uso de estos widgets de material.dart
    setupLocator();
    return MaterialApp(
      title: 'AppClinica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), //  Tema Claro
//      theme: ThemeData.dark(), // Tema Obscuro
      home: Splash(),
    );
  }
}
