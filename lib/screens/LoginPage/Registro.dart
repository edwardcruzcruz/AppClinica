import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';

class Registro extends StatefulWidget{

  static Route<dynamic> route(){
    return MaterialPageRoute(
      builder: (context)=> Registro(),
    );
  }

  @override
  _RegistroState createState() =>  _RegistroState();
}



class _RegistroState extends State<Registro>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabla(),
      persistentFooterButtons: <Widget>[
        ButtonBar(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 80),
                  child: RaisedButton(
                    color: Colors.greenAccent,
                    textColor: Colors.white,
                    child: Text("Atras"),
                    padding: const EdgeInsets.all(10.0),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(Login.route());
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 80),
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      textColor: Colors.white,
                      child: Text("Registrarse"),
                      padding: const EdgeInsets.all(10.0),
                      onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                          if (_formKey.currentState.validate()) {
                      // Process data.
                          }
                      },
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
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nombres',
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
                              border: OutlineInputBorder(),
                              labelText: 'Apellidos',
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
                              border: OutlineInputBorder(),
                              labelText: 'Numero de Telefono',
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
                              border: OutlineInputBorder(),
                              labelText: 'Dirección Domiciliaria',
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }
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
                              labelText: 'Correo Electronico',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }
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
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }
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
                              labelText: 'Validar Contraseña',
                              labelStyle: TextStyle(
                                  color: Colors.white),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }
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
}