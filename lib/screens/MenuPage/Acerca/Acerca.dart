import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/screens/MenuPage/Acerca/Component/Body.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter_app/models/RedSocial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Acerca extends StatefulWidget {
  Acerca({Key key}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Acerca(),
    );
  }

  @override
  _AcercaState createState() => _AcercaState();
}

class _AcercaState extends State<Acerca>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaNoticias),
        /*ListView(
          padding: EdgeInsets.all(8.0),
          children: _listViewData
              .map((data) => ListTile(
            leading: Icon(Icons.person),
            title: Text(data),
            subtitle: Text("a subtitle here"),
          ))
              .toList(),
        ),*/
        Expanded(
          child: AcercaPage(),
        )
      ],
    );
  }
}