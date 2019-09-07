import 'dart:async';
import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Shared_Preferences.dart';
import 'package:flutter_app/services/Var_Shared.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    //setupLocator();
    var storageService = locator<Var_shared>();
    _timer = Timer(const Duration(seconds: 5), (storageService.getuser!=null) ? _onShowHome : _onShowLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onShowLogin() {
    if(mounted){
      Navigator.of(context).pushReplacement(Login.route());
    }
  }
  void _onShowHome(){
    if(mounted){
      Navigator.of(context).pushReplacement(Home.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[600],
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.0,),
          Flexible(
            flex: 2,
            child: SafeArea(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Image.asset('assets/splash.jpg'),
              ),
            ),
          ),
          Text(
            'Bienvenido',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Flexible(
            flex: 2,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}