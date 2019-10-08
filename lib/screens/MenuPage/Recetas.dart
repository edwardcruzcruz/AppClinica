import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';

class Recetas extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Recetas(),
    );
  }

  @override
  _RecetasState createState() => _RecetasState();
}

class _RecetasState extends State<Recetas>{
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
            Padding(padding: EdgeInsets.only(bottom: 10),),
            Align(
              child: Text(Strings.CuerpoTituloPaginaRecetas,style: appTheme().textTheme.display3,),
            ),
          ],
        ),
      ),
    );
  }
}