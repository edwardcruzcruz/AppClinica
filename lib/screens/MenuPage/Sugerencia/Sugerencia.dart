import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/screens/MenuPage/Sugerencia/Component/Body.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

class Sugerencia extends StatefulWidget {
  Function callback,callbackloading,callbackfull;
  Sugerencia({Key key,this.callback,this.callbackloading,this.callbackfull,}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Sugerencia(),
    );
  }

  @override
  _SugerenciaState createState() => _SugerenciaState();
}

class _SugerenciaState extends State<Sugerencia>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaNoticias),
        Expanded(
          child: SugerenciaPage(email: storageService.getEmail,idPadre: storageService.getIdPadre,Username: storageService.getCuentaMaster,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,)
        ),
      ],
    );
  }
}