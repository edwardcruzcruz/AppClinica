import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';

class Sugerencia extends StatefulWidget {
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
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false;
  TextEditingController username = new TextEditingController();
  TextEditingController Sugerencia = new TextEditingController();
  TextEditingController email = new TextEditingController();
  RegExp NameOlastNRegExp =new RegExp(r'^[A-Z]?[a-z]+(\s[A-Z]?[a-z]+)?$');
  RegExp emailRegExp =new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  @override
  Widget build(BuildContext context) {
    username.text= storageService.getCuentaActual;
    email.text=storageService.getEmail;
    return  new Column(
      children: <Widget>[
        Container(
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
                  child: new Text(storageService.getCuentaActual,style: appTheme().textTheme.display2,),
                  alignment: Alignment(-0.80, 0),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),),
                Align(
                  child: Text(Strings.CuerpoTituloPaginaSugerencia,style: appTheme().textTheme.display3,),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: new ListView(
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

                  onPressed: () {if(_formKey.currentState.validate()){_showSuccessGuardar();}},
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
          ),
        ),
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
}