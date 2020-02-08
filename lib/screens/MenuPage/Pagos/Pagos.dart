import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/screens/PagosPage/AgregarTarjeta.dart';
import 'package:flutter_app/screens/PagosPage/Carrito.dart';
import 'package:flutter_app/theme/style.dart';

class Pagos2 extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Pagos2(),
    );
  }

  @override
  _PagosState2 createState() => _PagosState2();
}

class _PagosState2 extends State<Pagos2>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaCarrito),
        new Expanded(

          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(1.0,1.0,1.0,1.0),
              ),
              Expanded(
                child: AgregarTarjeta(),
              ),
            ],
          ),
        )
      ],
    );
  }
}