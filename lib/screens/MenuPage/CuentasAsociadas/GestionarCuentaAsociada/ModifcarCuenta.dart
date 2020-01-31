import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/models/UserFB.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/CuentasAsociadas.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

class ModificarCuenta extends StatefulWidget {
  User cuenta;
  int cuentaAsociada;
  Function callback,callbackloading,callbackfull;
  ModificarCuenta({Key key,this.cuentaAsociada,this.cuenta,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => ModificarCuenta(),
    );
  }

  @override
  _ModificarCuentaState createState() => _ModificarCuentaState();
}

class _ModificarCuentaState extends State<ModificarCuenta>{
  var storageService = locator<Var_shared>();
  String dropdownValue = '1';
  final _formKey = GlobalKey<FormState>();
  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  TextEditingController username = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController CIController= new TextEditingController();
  @override
  void initState() {
    super.initState();
    //print(this.widget.cuenta);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.CuerpoTituloPaginaCuentasAsociadas),
        new Expanded(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(

                  children: <Widget>[
                    GestureDetector(
                      onTap: ()async {////para retroceder a CuentasAsociadas
                        this.widget.callback(CuentasAsociadas(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
                            Text(Strings.TextRetroceder,style: appTheme().textTheme.subtitle,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //alignment: Alignment(50, 0),
                        margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
                        child: Text(Strings.ModificarTitulo1,style: appTheme().textTheme.title,)
                    )
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: formulario(this.widget.cuenta),//formulario()
              ),
              RaisedButton(

                onPressed:()async{//async
                  if(_formKey.currentState.validate()){
                    if(this.widget.cuentaAsociada==-1){
                      this.widget.callbackloading();
                      User usuario= await RestDatasource().perfilfbByFLName(username.text,lastname.text);
                      this.widget.callbackfull();
                      if(usuario==null){
                        dynamic response=await RestDatasource().save_userfb(username.text,lastname.text,"","","1996-10-10","1",CIController.text,email.text,storageService.getIdPadre.toString());
                        print(response.body);
                        if(response.statusCode==200 || response.statusCode==201){
                          _showDialogSave();
                        }else{
                          _showDialogErrorAddAccount(response.body.toString());
                        }
                      }else{
                        _showDialogAddAccount();
                      }
                    }else{//modificar
                      List<CuentasAsociadas> emptylist = [];
                      Cuenta usuario= await RestDatasource().CuentasByMaster(this.widget.cuentaAsociada);
                      this.widget.callbackloading();
                      dynamic response=await RestDatasource().perfil(this.widget.cuentaAsociada,Cuenta(this.widget.cuentaAsociada,username.text,lastname.text,email.text,int.parse(dropdownValue),"00000000","entrabajo","1996-10-10",CIController.text,usuario.ListCuentasAsociads));
                      this.widget.callbackfull();
                      print(response.body);
                      if(response.statusCode==200 || response.statusCode==201){
                        _showDialogEdit();
                      }else{
                        _showDialogErrorAddAccount(response.body.toString());
                      }
                    }
                  }
                },child: Text("confirmar"),
                color: Colors.teal,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget SinCuentas(){
    return new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("No hay clientes"),
          ],
        )
    );
  }
  Widget formulario(User cuenta){
    if(cuenta!=null){
      username.text = cuenta.Nombre;
      lastname.text = cuenta.Apellido;
      email.text = cuenta.Correo;
      CIController.text = cuenta.Cedula;
    }
    return new ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(50,5,50,5),
                child: TextFormField(
                controller: username,

                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                      width: 1.0),
                    ),
                    labelText: Strings.LabelRegistroNombre,
                    labelStyle: appTheme().textTheme.title,
                    //hintText: this.widget.cuenta==null?"":this.widget.cuenta.Nombre,
                  ),
                  validator: (text) {
                  if (text.length == 0) {
                  return "Este campo contraseña es requerido";
                  }/* else if (text.length <= 5) {
                                return "Su contraseña debe ser al menos de 5 caracteres";
                              } else if (!contRegExp.hasMatch(text)) {
                                return "El formato para contraseña no es correcto";
                              }*/
                  return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50,5,50,5),
                child: TextFormField(
                controller: lastname,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                      width: 1.0),
                    ),
                    labelText: Strings.LabelRegistroApellidos,
                    labelStyle: appTheme().textTheme.title,
                    //hintText: this.widget.cuenta==null?"":this.widget.cuenta.Nombre,this.widget.cuenta.Apellido
                  ),
                  validator: (text) {
                  if (text.length == 0) {
                  return "Este campo contraseña es requerido";
                  }/* else if (text.length <= 5) {
                                return "Su contraseña debe ser al menos de 5 caracteres";
                              } else if (!contRegExp.hasMatch(text)) {
                                return "El formato para contraseña no es correcto";
                              }*/
                  return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50,5,50,5),
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
                    //hintText: this.widget.cuenta==null?"":this.widget.cuenta.Nombre,this.widget.cuenta.Apellido,this.widget.cuenta.Cedula,
                  ),
                  validator: (text) {
                  if (text.length == 0) {
                    return "Este campo es requerido";
                  }else if (!Cedulavalida(text)){
                    return 'Por favor ingresar un numero de cedula valida';
                  }
                  return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50,5,50,5),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                          width: 1.0),
                    ),
                    labelText: Strings.LabelEmail,
                    labelStyle: appTheme().textTheme.title,
                    //hintText: this.widget.cuenta==null?"":this.widget.cuenta.Nombre,this.widget.cuenta.Apellido,this.widget.cuenta.Cedula,this.widget.cuenta.Correo,
                  ),
                  validator: (text) {
                    if (text.length == 0) {
                      return "Este campo contraseña es requerido";
                    }else if (!emailRegExp.hasMatch(text)) {
                      return "El formato para correo no es correcto";
                    }
                    return null;
                  },
                ),
                //decoration: underlineTextField(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50,5,50,5),
                //padding: EdgeInsets.only(bottom:10,left: 15,right: 10,top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("Parentesco: ",style: appTheme().textTheme.title,),
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
                                    "Ninguno",
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
                                    "Padre o Madre",
                                    style: appTheme().textTheme.title,
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "3",
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    "Hijo o Hija",
                                    style: appTheme().textTheme.title,
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "4",
                              child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    "Sobrino o Sobrina",
                                    style: appTheme().textTheme.title,
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "5",
                              child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    "Tio o Tia",
                                    style: appTheme().textTheme.title,
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "6",
                              child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    "Otro",
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
                  ],
                ),
              ),

            ],
          ),
        ),

      ]);
  }
  void _showDialogAddAccount() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("El usuario ya existe"),
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
  void _showDialogErrorAddAccount(String problema) {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("No se pudo registrar al usuario, Causa: "+problema.split("[").elementAt(1).split("]").elementAt(0)),
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
  void _showDialogSave() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Registro Exitoso"),
          content: new Text("Se ha registrado una cuenta asociada con el nombre de "+username.text+" "+lastname.text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () async{
                this.widget.callback(CuentasAsociadas(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialogEdit() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Actualización Exitoso"),
          content: new Text("Se ha actualizado la cuenta asociada con el nombre de "+username.text+" "+lastname.text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () async{
                //this.widget.callback(CuentasAsociadas(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
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