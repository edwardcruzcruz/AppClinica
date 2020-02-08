import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/screens/PagosPage/AgregarTarjeta.dart';
import 'package:flutter_app/theme/style.dart';
import '../Citas/Listado.dart';
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
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaNoticias),
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
