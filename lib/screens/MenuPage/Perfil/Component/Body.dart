import 'package:flutter_app/components/DateTime/flutter_datetime_picker.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/screens/MenuPage/Perfil/Perfil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilPage extends StatefulWidget {
  Function callback,callbackloading,callbackfull;
  PerfilPage({Key key,this.callback,this.callbackloading,this.callbackfull,})
      : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => PerfilPage(),
    );
  }
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  ScrollController _controller;
  var storageService = locator<Var_shared>();
  final _formKey = GlobalKey<FormState>();
  bool _enabled = false,circular=false;
  Future<Cuenta> future;
  Future<Cuenta> future2;
  String dropdownValue = '1';
  TextEditingController username = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController nophone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController CIController= new TextEditingController();
  String Date = "";
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  RegExp NameOlastNRegExp =
  new RegExp(r'^[A-Z]?[a-z]+(\s[A-Z]?[a-z]+)?$');
  RegExp PhoneRegExp =
  new RegExp(r'^(?:[+0]9)?[0-9]{10}$');
  double backgroundHeight = 180.0;
  @override
  void initState() {
    super.initState();
    future = RestDatasource().CuentasByMaster(storageService.getIdPadre);

    print(future);
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
    print("Again");
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<Cuenta> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "No hay información para mostrar",
                        textAlign: TextAlign.center,
                        style: appTheme().textTheme.display4,
                      ),
                    ],
                  )
                ],
              ); //'Error: ${snapshot.error}'

            /*validamos que no se vuelva a sobreescribir la data actual a la anterior al actualizar los datos*/
            if(future!=future2){
              username.text=snapshot.data.Nombre;
              lastname.text = snapshot.data.Apellido;
              nophone.text = snapshot.data.Telefono;
              address.text = snapshot.data.Direccion;
              email.text = snapshot.data.Correo;
              CIController.text = snapshot.data.Cedula;
              Date= snapshot.data.FechaNacimiento;
              print("hey");
            }
            future2=future;//cambiamoso al actual
            return snapshot.data!=null
                ? form(snapshot.data):
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "No hay información nueva",
                      textAlign: TextAlign.center,
                      style: appTheme().textTheme.display4,
                    )
                  ],
                )
              ],
            );
        }
        return null;
      },
    );
  }
  Widget form(Cuenta data){
    return new ListView(
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
                    }else if (!Utils.Cedulavalida(value)){
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
                                }
                              ,currentTime: DateTime.now()
                                ,locale: LocaleType.en
                            );
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
                dynamic response = await RestDatasource().edit_user(storageService.getIdPadre, Cuenta(storageService.getIdPadre,username.text,lastname.text,email.text,int.parse(dropdownValue),nophone.text,address.text,Date.toString(),CIController.text, data.ListCuentasAsociads));
                //print(response.body);
                callbackfull();
                if(response.statusCode==200){
                  _showSuccessGuardar();
                }else{
                  _showDialogErrorAddAccount(response.body.toString());
                  //_showErrorGuardar();
                }
              }
            },
            child: Text(Strings.Actualizacion),
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
          title: new Text("Guardado"),
          content: new Text("Se guardo su información satisfactoriamente"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                //this.widget.callback(Perfil(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogErrorAddAccount(String problema) {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("No se pudo editar su cuenta de usuario, Causa: "+problema.split("[").elementAt(1).split("]").elementAt(0)),
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