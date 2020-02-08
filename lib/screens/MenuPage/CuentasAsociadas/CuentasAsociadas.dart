import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/Component/Body.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/GestionarCuentaAsociada/ModifcarCuenta.dart';
import 'package:flutter_app/screens/MenuPage/Noticias/Noticias.dart';
import 'package:flutter_app/theme/style.dart';

class CuentasAsociadas extends StatefulWidget {
  Function callback,callbackloading,callbackfull;
  CuentasAsociadas({Key key,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => CuentasAsociadas(),
    );
  }

  @override
  _CuentasAsociadasState createState() => _CuentasAsociadasState();
}

class _CuentasAsociadasState extends State<CuentasAsociadas>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaCuentasAsociadas),
        new Expanded(
          child: CuentasBodyPage(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,)
        )
      ],
    );
  }
}