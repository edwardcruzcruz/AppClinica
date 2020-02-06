
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/components/DateTime/flutter_datetime_picker.dart';
import 'package:flutter_app/models/Carrito.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento1.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/DateTime/flutter_datetime_picker.dart';
import 'package:flutter_app/models/RegisterUser.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_app/theme/style.dart';

class AgregarTarjeta extends StatefulWidget{
//Listado(tipo, titulo);
  Function callback,callbackloading,callbackfull;

  AgregarTarjeta({Key key,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => AgregarTarjeta(),
    );
  }


  @override
  _AgregarTarjetaState createState() => _AgregarTarjetaState();
}

class _AgregarTarjetaState extends State<AgregarTarjeta> {
  ScrollController _controller;
  Future<User> future;
  var storageService = locator<Var_shared>();
  bool _saving = false;//to circular progress bar
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '1';

  TextEditingController nophone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  RegExp NameOlastNRegExp =
  new RegExp(r'^[A-Z]?[a-z]+(\s[A-Z]?[a-z]+)?$');
  RegExp PhoneRegExp =
  new RegExp(r'^(?:[+0]9)?[0-9]{10}$');

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    future = RestDatasource().getUser(this.storageService.getIdPadre);
  }

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
                child: tabla()
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget tabla() {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context,
            AsyncSnapshot<User> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text("No hay datos iniciales del usuario",
                    textAlign: TextAlign.center,
                    style: appTheme()
                        .textTheme
                        .display4); //'Error: ${snapshot.error}'
              print("hola mundo");
              this.nophone.text=snapshot.data.Telefono;
              this.email.text=snapshot.data.Correo;
              return
                Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,30,0,0),
                      ),
                      new Expanded(
                          child: new ListView(
                            children: <Widget>[
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                      child: TextFormField(
                                        controller: nophone,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: appTheme().buttonColor,
                                                width: 1.0),
                                          ),
                                          labelText: Strings.LabelRegistroTelefono,
                                          labelStyle: appTheme().textTheme.title,
                                          errorStyle: appTheme().textTheme.overline,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Por favor llenar los espacios';
                                          }else if (!PhoneRegExp.hasMatch(value)){
                                            return 'Por favor ingresar número de teléfono válido';
                                          }
                                          return null;
                                        },
                                      ),
                                      //decoration: underlineTextField(),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                      child: TextFormField(
                                        controller: email,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: appTheme().buttonColor,
                                                width: 1.0),
                                          ),
                                          labelText: Strings.LabelEmail,
                                          labelStyle: appTheme().textTheme.title,
                                          errorStyle: appTheme().textTheme.overline,
                                        ),
                                        validator: (text) {
                                          if (text.length == 0) {
                                            return "Este campo correo es requerido";
                                          } else if (!emailRegExp.hasMatch(text)) {
                                            return "El formato para correo no es correcto";
                                          }
                                          return null;
                                        },
                                      ),
                                      //decoration: underlineTextField(),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ]
                );
          }
          return null;
        });

  }

}

