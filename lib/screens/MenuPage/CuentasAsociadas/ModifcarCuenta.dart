import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/UserFB.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/CuentasAsociadas.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

class ModificarCuenta extends StatefulWidget {
  UserFB cuenta;
  Function callback,callbackloading,callbackfull;
  ModificarCuenta({Key key,this.cuenta,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
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
  TextEditingController username = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController CIController= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
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
                child: Text(Strings.CuerpoTituloPaginaCuentasAsociadas,style: appTheme().textTheme.display3,),
              )
            ],
          ),
        ),
      ),
        new Expanded(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(

                  children: <Widget>[
                    GestureDetector(
                      onTap: ()async {////para retroceder a CuentasAsociadas
                        this.widget.callbackloading;
                        Cuenta cuentas= await RestDatasource().CuentasByMaster(int.parse(storageService.getIdPadre.toString()));
                        this.widget.callbackfull;
                        this.widget.callback(CuentasAsociadas(cuentas: cuentas,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
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
  Widget formulario(UserFB cuenta){
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
                    hintText: this.widget.cuenta==null?"":this.widget.cuenta.Nombre,
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
                    hintText: this.widget.cuenta==null?"":this.widget.cuenta.Apellido
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
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: appTheme().buttonColor,
                      width: 1.0),
                    ),
                    labelText: Strings.LabelCI,
                    labelStyle: appTheme().textTheme.title,
                    hintText: this.widget.cuenta==null?"":this.widget.cuenta.Cedula,
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
        FlatButton(
          onPressed:()async{//async
            if(_formKey.currentState.validate()){
              this.widget.callbackloading();
              User usuario= await RestDatasource().perfilfbByFLName(username.text,lastname.text);
              this.widget.callbackfull();
              if(usuario==null){
                dynamic response=await RestDatasource().save_userfb(username.text,lastname.text,"","","1996-10-10","1","","dummie@dummie.com",storageService.getIdPadre.toString());
                if(response.statusCode==200 || response.statusCode==201){
                  print(response.body);
                  _showDialogSave();
                }else{
                  _showDialogErrorAddAccount();
                }
              }else{
                _showDialogAddAccount();
              }
            }
          },child: Text("confirmar"),),
      ]);
  }
  /*
  Widget formulario(){
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {//async
                /*this.widget.callbackloading();
                List<Horario> horarios= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                if(horarios.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida, idHorario: horarios.elementAt(position).IdHorario,horarios: horarios,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                }*/
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarioPage(horarios: horarios,)),
                );*/
                //Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                        child: new Image.asset('assets/avatar.png',width: 63,height: 70),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 3.0),
                        child: Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.edit,
                            size: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            size: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            )
          ],
        );
      },
      itemCount: this.widget.cuentas.length,
    );
  }
*/
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
  void _showDialogErrorAddAccount() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("No se pudo registrar al usuario"),
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
                this.widget.callbackloading;
                Cuenta cuentas= await RestDatasource().CuentasByMaster(int.parse(storageService.getIdPadre.toString()));
                this.widget.callbackfull;
                this.widget.callback(CuentasAsociadas(cuentas: cuentas,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        );
      },
    );
  }
}