import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';

class Historial extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Historial(),
    );
  }

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return  new Container(
      height: 100.0,
      decoration: new BoxDecoration(

          gradient: new LinearGradient(
            colors: [
              Color(0xFF00a18d),
              Color(0xFF00d6bc),
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
          borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 120.0))
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Align(
              child: Text(Strings.CuerpoTituloBienvenido,style: appTheme().textTheme.display1,),
              alignment: Alignment(-0.80, 0),
            ),
            Align(
              child: new Text(storageService.getEmail.split("@")[0],style: appTheme().textTheme.display2,),
              alignment: Alignment(-0.80, 0),
            ),
            Padding(padding: EdgeInsets.only(bottom: 6),),
            Align(
              child: Text(Strings.CuerpoTituloPaginaHitorial,style: appTheme().textTheme.display3,),
            ),
          ],
        ),
      ),
    );
  }
}