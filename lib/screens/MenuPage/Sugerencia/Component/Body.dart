import 'dart:math';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';

class SugerenciaPage extends StatefulWidget {
  Function callback,callbackloading,callbackfull;
  SugerenciaPage({Key key,this.idPadre,this.Username,this.email,this.callback,this.callbackloading,this.callbackfull,})
      : super(key: key);
  final String Username,email;
  final int idPadre;
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => SugerenciaPage(),
    );
  }
  @override
  _SugerenciaPageState createState() => _SugerenciaPageState();
}

class _SugerenciaPageState extends State<SugerenciaPage> {
  ScrollController _controller;
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false,circular=false;
  TextEditingController username = new TextEditingController();
  TextEditingController Sugerencia = new TextEditingController();
  TextEditingController email = new TextEditingController();
  RegExp NameOlastNRegExp =new RegExp(r'^[A-Z]?[a-z]+(\s[A-Z]?[a-z]+)?$');
  RegExp emailRegExp =new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  double backgroundHeight = 180.0;
  @override
  void initState() {
    super.initState();
  }
  void callbackloading() {
    setState(() {
      this.circular = true;
    });
  }

  void callbackfull() {
    setState(() {
      this.circular = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ModalProgressHUD(
          color: Colors.grey[600],
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          inAsyncCall: circular,
          child: _body()),
    );
  }
  Widget _body() {
    username.text=this.widget.Username;
    email.text=this.widget.email;
    return new ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
                child: TextFormField(
                  enabled: _enabled,
                  controller: username,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                          width: 1.0),
                    ),
                    labelText: Strings.LabelRegistroNombre,
                    labelStyle: appTheme().textTheme.title,
                    hintStyle:  appTheme().textTheme.title,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor llenar los espacios';
                    }else if (!NameOlastNRegExp.hasMatch(value)){
                      return 'Por favor ingresar caracteres alfabeticos y sin espacios';
                    }
                    return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
                child: TextFormField(
                  enabled: _enabled,
                  controller: email,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                          width: 1.0),
                    ),
                    labelText: Strings.LabelEmail,
                    labelStyle: appTheme().textTheme.title,
                    hintStyle:  appTheme().textTheme.title,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor llenar los espacios';
                    }else if (!emailRegExp.hasMatch(value)){
                      return 'Por favor ingresar caracteres alfabeticos y sin espacios';
                    }
                    return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50.0,10.0,50.0,10.0),
                child: TextFormField(
                  controller: Sugerencia,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                          width: 1.0),
                    ),
                    labelText: Strings.LabelSugerencia,
                    labelStyle: appTheme().textTheme.title,
                    hintStyle:  appTheme().textTheme.title,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor llenar los espacios';
                    }
                    return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
            ],
          ),
        ),
        Center(
          child:
          RaisedButton(
            onPressed: () async{
              if(_formKey.currentState.validate())
              {
                callbackloading();
                var respuesta= await RestDatasource().save_sugerencia(this.widget.idPadre,"modelo prueba",Sugerencia.text);
                callbackfull();
                if(respuesta.statusCode==200 || respuesta.statusCode==201){
                  _showSuccessGuardar();
                }else{
                  _showDialogDontSave();
                }
              }
            },
            child: Text(Strings.Solicitud),
            color: Colors.teal,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          ),
        )
      ],
    );
  }
  void _showSuccessGuardar() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Enviado"),
          content: new Text("Se ha enviado la sugerencia satisfactoriamente"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogDontSave() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Ha ocurrido un problema al enviar la sugerencia, por favor intente mas tarde."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}