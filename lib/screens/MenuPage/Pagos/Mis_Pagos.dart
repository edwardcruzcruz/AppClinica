import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/screens/PagosPage/Carrito.dart';
import 'package:flutter_app/theme/style.dart';

class Pagos extends StatefulWidget {

  Function callback,callbackloading,callbackfull;
  Pagos({Key key,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Pagos(),
    );
  }

  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos>{
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
                child: Carrito( callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull),
              ),
            ],
          ),
        )
      ],
    );


  }
}