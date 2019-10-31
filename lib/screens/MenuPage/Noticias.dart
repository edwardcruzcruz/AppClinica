import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import './Listado.dart';
class Noticias extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Noticias(),
    );
  }

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias>{
  //Widget listado=Listado(titulo: "lol");
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
    new Container(
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
              child: Text(Strings.CuerpoTituloPaginaNoticias,style: appTheme().textTheme.display3,),
            )
            //,_lista()
          ],

        ),

      ),

    ),
        new Expanded(

          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(1.0,1.0,1.0,1.0),
              ),
              Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              Expanded(
                child: Listado(tipo: "tipo"),
              ),
            ],
          ),
        )
      ],
    );


  }
}
