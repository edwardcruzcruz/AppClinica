import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/DateTime/flutter_datetime_picker.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:intl/intl.dart';

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
  String dropdownValue = '1';
  TextEditingController username = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController nophone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passController1 = new TextEditingController();
  TextEditingController passController2= new TextEditingController();
  String Date=DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  RegExp NameOlastNRegExp =
  new RegExp(r'^[A-Z]?[a-z]+(\s[A-Z]?[a-z]+)?$');
  RegExp PhoneRegExp =
  new RegExp(r'^(?:[+0]9)?[0-9]{10}$');

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                          String genero="";
                          if(dropdownValue==1){
                            genero="Masculino";
                          }else{
                            genero="Femenino";
                          }
                          // Process data.
                        if(passController1.text==(passController2.text)){
                              var response = await RestDatasource().save_user(username.text,lastname.text,nophone.text,address.text,Date.toString(),genero,email.text, passController1.text,passController2.text);
                              if(response.statusCode>200 && response.statusCode<400){
                                _showSuccessGuardar();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }else if (!NameOlastNRegExp.hasMatch(value)){
                                return 'Por favor ingresar caracteres alfabeticos y sin espacios';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: lastname,
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
                              }else if (!NameOlastNRegExp.hasMatch(value)){
                                return 'Por favor ingresar caracteres alfabeticos y sin espacios';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: nophone,
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
                              }else if (!PhoneRegExp.hasMatch(value)){
                                return 'Por favor ingresar numero telefonico';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: address,
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.only(bottom:10,left: 15,right: 10,top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Fecha de Nacimiento:",style: TextStyle(color: Colors.white,fontSize: 16),),
                                ),
                              ),
                              Expanded(
                                child:FlatButton(
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1955, 1, 1).toUtc(),
                                          maxTime: DateTime(DateTime.now().year, DateTime.now().month,DateTime.now().day),
                                          theme: DatePickerTheme(
                                              backgroundColor: Colors.blue,
                                              itemStyle: TextStyle(
                                                  color: Colors.white, fontWeight: FontWeight.bold),
                                              doneStyle:
                                              TextStyle(color: Colors.white, fontSize: 16)),
                                          onChanged: (date) {
                                            setState(() {//se utilizn estados para actualizar directmente sin esperar eventos
                                              Date=DateFormat("yyyy-MM-dd").format(date).toString();
                                            });
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                                    },
                                    child: new Text(Date,
                                      style: TextStyle(color: Colors.blue),
                                    )
                                ),

                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                          ),
                          padding: EdgeInsets.only(bottom:10,left: 15,right: 10,top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text("Genero: ",style: TextStyle(color: Colors.white,fontSize: 16),),
                                ),
                              ),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    items: [
                                      DropdownMenuItem(
                                        value: "1",
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Masculino",
                                            ),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: "2",
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Text(
                                              "Femenino",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value;
                                      });
                                    },
                                    isExpanded: true,
                                    //style: TextStyle(color: Colors.white),
                                    value : dropdownValue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pushReplacement(Login.route());
              },
            ),
          ],
        );
      },
    );
  }
}