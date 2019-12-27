import 'dart:async';
import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';


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
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/splash-01.png',fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}