import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/services/Rest_Services.dart';

class Registro extends StatefulWidget{

  static Route<dynamic> route(){
    return MaterialPageRoute(
      builder: (context)=> Registro(),
    );
  }

  @override
  _RegistroState createState() =>  _RegistroState();
}



class _RegistroState extends State<Registro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passController1 = new TextEditingController();
  TextEditingController passController2= new TextEditingController();
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              color: Colors.black,
              onPressed:(){
                Navigator.of(context).pushReplacement(Login.route());
              }
          )
        ],
      ),
      body: tabla(),
      persistentFooterButtons: <Widget>[
        ButtonBar(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 80),
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      textColor: Colors.white,
                      child: Text("Registrar"),
                      padding: const EdgeInsets.all(10.0),
                      onPressed: () async{
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // Process data.
                        if(passController1.text.compareTo(passController2.text)==0){
                              var response = await RestDatasource().save_user(username.text, email.text, passController1.text);
                              if(response.statusCode==500){
                                _showSuccessGuardar();
                                Navigator.of(context).pushReplacement(Login.route());
                              }else{
                                _showErrorGuardar();
                              }
                          }else{
                              _showErrorpass();
                          }
                        }
                      }
                    )
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget tabla() {
    return Column(
        children: <Widget>[
          new Expanded(
              child: new ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: username,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nombres',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(

                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Apellidos',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Numero de Telefono',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Dirección Domiciliaria',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Fecha de Nacimiento',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              labelText: 'Genero',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: email,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              labelText: 'Correo Electronico',
                              labelStyle: TextStyle(
                                  color: Colors.white),
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
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: passController1,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              } else if (text.length <= 5) {
                                return "Su contraseña debe ser al menos de 5 caracteres";
                              } else if (!contRegExp.hasMatch(text)) {
                                return "El formato para contraseña no es correcto";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: passController2,
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              labelText: 'Validar Contraseña',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              } else if (text.length <= 5) {
                                return "Su contraseña debe ser al menos de 5 caracteres";
                              } else if (!contRegExp.hasMatch(text)) {
                                return "El formato para contraseña no es correcto";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ]
    );
  }
  void _showErrorpass() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Contraseña no coincide"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showErrorGuardar() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("No se guardo el usuario"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showSuccessGuardar() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Aceptado"),
          content: new Text("Se guardo el usuario satisfactorio"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
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