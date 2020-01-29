import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/screens/MenuPage/HistorialPage/Component/Body.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/models/CitaCompleta.dart';

class Historial extends StatefulWidget {
  Historial({Key key}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Historial(),
    );
  }

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial>{
  final temp=DateTime.now();

  var storageService = locator<Var_shared>();
  //Future<List<Receta>> future;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  new Column (
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaHitorial),
        new Expanded(
          child: new Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //alignment: Alignment(50, 0),
                        margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
                        child: Text("Paciente: "+storageService.getCuentaActual,style: appTheme().textTheme.subhead,)
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: HistorialPage(),
              )
            ],
          ),
        ),
      ],
    );
  }
}