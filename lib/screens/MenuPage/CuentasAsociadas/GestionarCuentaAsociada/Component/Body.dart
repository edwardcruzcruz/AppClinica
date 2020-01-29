import 'dart:math';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/models/Sexo.dart';
import 'package:flutter_app/models/UserFB.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/GestionarCuentaAsociada/ModifcarCuenta.dart';
import 'package:flutter_app/screens/MenuPage/Noticias.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

class GestionarCuentasBodyPage extends StatefulWidget {
  Function callback,callbackloading,callbackfull;
  GestionarCuentasBodyPage({Key key,this.callback,this.callbackloading,this.callbackfull})
      : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => GestionarCuentasBodyPage(),
    );
  }
  @override
  _GestionarCuentasBodyPageState createState() => _GestionarCuentasBodyPageState();
}

class _GestionarCuentasBodyPageState extends State<GestionarCuentasBodyPage> {
  var storageService = locator<Var_shared>();
  ScrollController _controller;
  double backgroundHeight = 180.0;
  Future<Cuenta> future;
  @override
  void initState() {
    super.initState();

    future = RestDatasource().CuentasByMaster(int.parse(storageService.getIdCuentaMaster.toString()));

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        backgroundHeight = max(0, 180.0 - _controller.offset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
  Widget _body() {
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
              return Text(
                "No hay información para mostrar",
                textAlign: TextAlign.center,
                style: appTheme().textTheme.display4,
              ); //'Error: ${snapshot.error}'

            return snapshot.data != null
              ? Column(
                children: <Widget>[
                  Container(
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        storageService.getIdHijo!=null?new Expanded(
                          child: GestureDetector(
                            onTap: () {
                              storageService.delete_idHijo();
                              storageService.save_idPadre(storageService.getIdCuentaMaster);
                              storageService.save_currentAccount(storageService.getCuentaMaster);
                              _showDialogChange();
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
                                  Text(Strings.TextRetrocederCuenta,style: appTheme().textTheme.subtitle,)
                                ],
                              ),
                            ),
                          ),
                        ):new Container(),
                        GestureDetector(
                          onTap: () {//async
                            /*this.widget.callbackloading;
                          List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad();
                          this.widget.callbackfull;
                          this.widget.callback(Agendamiento(usuario: this.widget.usuario,especialidades: especialidades,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                          */
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0.0,20.0,20.0,20.0),
                            child:
                            GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.add,size: 10,color: appTheme().textTheme.subtitle.color,),
                                    Text(Strings.TextAgregarCuentaAsoc,style: appTheme().textTheme.subtitle,)
                                  ],
                                ),
                                onTap: (){
                                  this.widget.callback(
                                    ModificarCuenta(
                                      cuenta: null,
                                      cuentaAsociada: -1,
                                      callback: this.widget.callback,
                                      callbackloading: this.widget.callbackloading,
                                      callbackfull: this.widget.callbackfull,)
                                  );
                                }
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: snapshot.data.ListCuentasAsociads==null?SinCuentas():formulario(snapshot.data),//formulario()
                  ),
                ],
              )
                : Text(
              "No hay información nueva",
              textAlign: TextAlign.center,
              style: appTheme().textTheme.display4,
            );
        }
        return null;
      },
    );
  }

  Widget formulario(Cuenta cuenta){
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[

            GestureDetector(
              onTap: () {//async
                /*this.widget.callbackloading();
                Cuenta cuenta= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                if(horarios.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida, idHorario: horarios.elementAt(position).IdHorario,horarios: horarios,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                }*/
                //Navigator.pop(context);
                //storageService.save_idPadreTemporal(storageService.getIdPadre);
                storageService.save_idPadre(cuenta.ListCuentasAsociads.elementAt(position).Id);
                storageService.save_idHijo(cuenta.ListCuentasAsociads.elementAt(position).Id);
                storageService.save_currentAccount(cuenta.ListCuentasAsociads.elementAt(position).Nombre+" "+cuenta.ListCuentasAsociads.elementAt(position).Apellido);
                this._showDialogChange();
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
                        child: Text(cuenta.ListCuentasAsociads.elementAt(position).Nombre+" "+cuenta.ListCuentasAsociads.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
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
                            child: IconButton(icon: Icon(
                              Icons.edit,
                              size: 25.0,
                              color: Colors.grey,
                            ), onPressed: (){
                              this.widget.callback(

                                  ModificarCuenta(
                                    cuenta: null,//UserFB(cuenta.ListCuentasAsociads.elementAt(position).Id,cuenta.ListCuentasAsociads.elementAt(position).Nombre,cuenta.ListCuentasAsociads.elementAt(position).Apellido,cuenta.ListCuentasAsociads.elementAt(position).Correo,Genero(1,"Masculino"),cuenta.ListCuentasAsociads.elementAt(position).Telefono,cuenta.ListCuentasAsociads.elementAt(position).Direccion,cuenta.ListCuentasAsociads.elementAt(position).FechaNacimiento,cuenta.ListCuentasAsociads.elementAt(position).Cedula,int.parse(cuenta.ListCuentasAsociads.elementAt(position).IdCuentaPadre)),//cuenta.ListCuentasAsociads.elementAt(position)
                                    cuentaAsociada: cuenta.ListCuentasAsociads.elementAt(position).Id,
                                    callback: this.widget.callback,
                                    callbackloading: this.widget.callbackloading,
                                    callbackfull: this.widget.callbackfull,)
                                );
                              }
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            size: 25.0,
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
      itemCount: cuenta.ListCuentasAsociads.length,
    );
  }

  void _showDialogChange() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Cambio de Cuenta"),
          content: new Text("Se ha cambiado la cuenta a "+storageService.getCuentaActual),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                this.widget.callback(Noticias());
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        );
      },
    );
  }

  Widget SinCuentas(){
    return new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("No hay clientes",textAlign: TextAlign.center,style: appTheme().textTheme.subhead,),
          ],
        )
    );
  }
}