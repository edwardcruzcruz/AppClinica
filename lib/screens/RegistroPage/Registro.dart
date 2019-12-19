import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/DateTime/flutter_datetime_picker.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_app/theme/style.dart';


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
  bool _saving = false;//to circular progress bar
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '1';
  TextEditingController username = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController nophone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passController1 = new TextEditingController();
  TextEditingController passController2= new TextEditingController();
  TextEditingController CIController= new TextEditingController();
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
        elevation: 0,
        backgroundColor: Colors.white,
        title: new Image.asset('assets/logoclinica.png', fit: BoxFit.cover,),
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
      body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: tabla()),
      bottomNavigationBar: BottomAppBar(
        child:  Container(
        width: double.infinity,
        child: FlatButton(
            child: Text(Strings.ButtonRegistrarse,style: appTheme().textTheme.button,),
            padding: const EdgeInsets.all(10.0),
            onPressed: () async{
              // Validate will return true if the form is valid, or false if
              // the form is invalid.

              if (_formKey.currentState.validate()) {
                /*String genero="";
                if(dropdownValue==1){
                  genero="Masculino";
                }else{
                  genero="Femenino";
                }*/
                // Process data.
                if(passController1.text==(passController2.text)){
                  setState(() {//se muestra barra circular de espera
                    _saving = true;
                  });
                  var response = await RestDatasource().save_user(username.text,lastname.text,nophone.text,address.text,Date.toString(),dropdownValue,CIController.text,email.text, passController1.text);
                  setState(() {//se muestra barra circular de espera
                    _saving = false;
                  });
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
        ),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Color(0xFF00a18d),
              Color(0xFF00d6bc),
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
        ),
      ),
      ),
    );
  }

  Widget tabla() {
    return Column(
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
                            controller: CIController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelCI,
                              labelStyle: appTheme().textTheme.title,
                              errorStyle: appTheme().textTheme.overline,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor llenar los espacios';
                              }else if (!Cedulavalida(value)){
                                return 'Por favor ingresar un numero de cedula valida';
                              }
                              return null;
                            },
                          ),
                          //decoration: underlineTextField(),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(40,0,40,10),
                          child: TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelRegistroNombre,
                              errorStyle: appTheme().textTheme.overline,
                              labelStyle: appTheme().textTheme.title,
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
                          margin: const EdgeInsets.fromLTRB(40,0,40,10),
                          child: TextFormField(
                            controller: lastname,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelRegistroApellidos,
                              errorStyle: appTheme().textTheme.overline,
                              labelStyle: appTheme().textTheme.title,
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
                                return 'Por favor ingresar numero telefonico';
                              }
                              return null;
                            },
                          ),
                          //decoration: underlineTextField(),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(40,0,40,10),
                          child: TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelRegistroDireccion,
                              errorStyle: appTheme().textTheme.overline,
                              labelStyle: appTheme().textTheme.title,
                            ),
                            validator: (text) {
                              if (text.length == 0) {
                                return "Este campo contraseña es requerido";
                              }
                              return null;
                            },
                          ),
                          //decoration: underlineTextField(),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom:10,left: 15,right: 10,top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text("Fecha de Nacimiento:",style: appTheme().textTheme.title,),
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
                                              itemStyle: appTheme().textTheme.button,
                                              doneStyle:
                                              appTheme().textTheme.button),
                                          onChanged: (date) {
                                            setState(() {//se utilizn estados para actualizar directmente sin esperar eventos
                                              Date=DateFormat("yyyy-MM-dd").format(date).toString();
                                            });
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                                    },
                                    child: new Text(Date,
                                      style: appTheme().textTheme.title,
                                    )
                                ),

                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40,right: 40),
                          child: Container(
                            height: 1.0,
                            color: Colors.teal,
                            child: Divider(
                              color: Colors.teal,
                            ),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom:10,left: 15,right: 10,top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: Text("Género: ",style: appTheme().textTheme.title,),
                                ),
                              ),
                              Expanded(
                                child: new Padding(
                                  padding: const EdgeInsets.only(right: 22),
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
                                                style: appTheme().textTheme.title,
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
                                                style: appTheme().textTheme.title,
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
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 40,right: 40),
                            child: Container(
                              height: 1.0,
                              color: Colors.teal,
                              child: Divider(
                                color: Colors.teal,
                              ),
                            )
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
                        Container(
                          margin: const EdgeInsets.fromLTRB(40,0,40,10),
                          child: TextFormField(
                            controller: passController1,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelPassword,
                              labelStyle: appTheme().textTheme.title,
                              errorStyle: appTheme().textTheme.overline,
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
                          //decoration: underlineTextField(),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(40,0,40,10),
                          child: TextFormField(
                            controller: passController2,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelRegistroValidarPas,
                              labelStyle: appTheme().textTheme.title,
                              errorStyle: appTheme().textTheme.overline,
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
  bool Cedulavalida(String x) {
    bool cedulaCorrecta = false;


      if (x.length == 10) // ConstantesApp.LongitudCedula
          {
        int tercerDigito = int.parse(x.substring(2, 3));
        if (tercerDigito < 6) {
// Coeficientes de validación cédula
// El decimo digito se lo considera dígito verificador
          var coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2 ] ;
    int verificador = int.parse(x.substring(9,10));
    int suma = 0;
    int digito = 0;
    for (int i = 0; i < (x.length - 1); i++) {
    digito = int.parse(x.substring(i, i + 1))* coefValCedula[i];
    suma += ((digito % 10) + (digito / 10)).toInt() ;

    }

    if ((suma % 10 == 0) && (suma % 10 == verificador)) {
    cedulaCorrecta = true;
    }
    else if ((10 - (suma % 10)) == verificador) {
    cedulaCorrecta = true;
    } else {
    cedulaCorrecta = false;
    }
    } else {
    cedulaCorrecta = false;
    }
    } else {
    cedulaCorrecta = false;
    }

    if (!cedulaCorrecta) {
    print("La Cédula ingresada es Incorrecta");
    }
    return cedulaCorrecta;
  }
}