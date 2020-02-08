import 'package:flutter_app/Utils/Constantes.dart';
import 'package:flutter_app/screens/PagosPage/VentanPagos.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'package:html/parser.dart' show parse;

class AgregarTarjeta extends StatefulWidget{
//Listado(tipo, titulo);
  Function callback,callbackloading,callbackfull;
  List<CarritoCompra> compras;
  double total;
  AgregarTarjeta({Key key,this.callback,this.callbackloading,this.callbackfull,this.compras,this.total}) : super(key: key);
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
  TextEditingController CIController= new TextEditingController();
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
              this.nophone.text=snapshot.data.Telefono==null?"":snapshot.data.Telefono;
              this.email.text=snapshot.data.Correo==null?"":snapshot.data.Correo;
              this.CIController.text=snapshot.data.Cedula==null?"":snapshot.data.Cedula;
              print(this.widget.total);
              print(this.widget.compras);
              return
                Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,30,0,0),
                      ),
                      new Expanded(
                          child: new ListView(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                child: Align(
                                  child: Text("Confirme sus datos:",style: appTheme().textTheme.caption,),
                                  alignment: Alignment(-0.80, 0),
                                ),
                              ),
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
                                            return 'Por favor ingresar un número de cédula valida';
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
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                child: Align(
                                  child: Text("Resumen pago:",style: appTheme().textTheme.body2,),
                                  alignment: Alignment(-0.80, 0),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: this.widget.compras.length,
                                itemBuilder: (context, position) {
                                  return
                                    new Container(
                                      child: new Material(
                                        child: new Column(
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                              child: Align(
                                                child: Text(this.widget.compras.elementAt(position).IdTratamiento.IDEspecialidad.NombreEspecialidad+": "+this.widget.compras.elementAt(position).valorFaltante,style: appTheme().textTheme.body2,),
                                                alignment: Alignment(-0.80, 0),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                }
                              ),
                              Container(
                                child: new Material(
                                  child: new Column(
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(40,0,40,10),
                                        child: Align(
                                          child: Text("Total:      "+this.widget.total.toString(),style: appTheme().textTheme.body2,),
                                          alignment: Alignment(-0.80, 0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: FlatButton(
                                    child: Text(Strings.CONFIRMAR,style: appTheme().textTheme.button,),
                                    padding: const EdgeInsets.all(10.0),
                                    onPressed: () async{
                                      // Validate will return true if the form is valid, or false if
                                      // the form is invalid.

                                      if (_formKey.currentState.validate()) {
                                        // Process data.
                                        print("Good");
                                        int usuario=this.widget.compras.elementAt(0).IdCliente;
                                        //var response=await RestDatasource().getPagosVentana();
                                        for (var i = 0; i < this.widget.compras.length; i++) {
                                          var response=await RestDatasource().actualizar_shop(this.widget.compras.elementAt(i).Id,true);

                                        }
                                        print("+++++++++++++++++++++++++");
                                        print("+++++++++++++++++++++++++");
                                        var url = Constantes.serverdomain+Constantes.pago+usuario.toString()+"/"+this.email.text+"/"+this.nophone.text+"/"+this.widget.total.toString()+"/";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                        /*this.widget.callbackloading();
                                        this.widget.callbackfull();
                                        this.widget.callback(VentanaPagos(
                                          callback: this.widget.callback,
                                          callbackloading: this.widget.callbackloading,
                                          callbackfull: this.widget.callbackfull,
                                          total: this.widget.total,
                                          cel: this.nophone.text,
                                          usuario: usuario,
                                          email: this.email.text ,
                                        ));*/

                                        //_launchURL();
                                      }
                                    },
                                  color: Color(0xFF00d6bc),
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

