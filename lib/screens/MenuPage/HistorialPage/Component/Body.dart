import 'dart:math';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/HistorialClinico.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HistorialPage extends StatefulWidget {
  HistorialPage({Key key})
      : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => HistorialPage(),
    );
  }
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  ScrollController _controller;
  var storageService = locator<Var_shared>();
  double backgroundHeight = 180.0;
  Future<List<HistorialClinico>> future;//CitaCompleta
  @override
  void initState() {
    super.initState();
    future = RestDatasource().HistorialId(storageService.getIdPadre);
    /*print("***********************--------------------------------*********************************");
    print(future);
    print("***********************--------------------------------*********************************");*/

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
      builder: (BuildContext context, AsyncSnapshot<List<HistorialClinico>> snapshot) {
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

            return snapshot.data.length>0
              ? Column(
              //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    detalle(snapshot.data.elementAt(0))
                  ],
                ):
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
  Widget detalle(HistorialClinico hc){
    return Expanded(
      child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          decoration: BoxDecoration(
            //color: Colors.green,
            //border: Border.all(color: Colors.teal),
          ),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Detalle",textAlign: TextAlign.center,
                        style: appTheme().textTheme.headline,)
                    ],
                  ),
                  hc.Paciente.CitaxCliente.isEmpty?detalleInvalidoCitaxCliente():detalleValidoCitaxCliente(hc),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: DiagnosticoCabecera(),
                      )
                    ],
                  ),
                  diagnostico(hc)
                ],
              )
            ]),
      ),
    );
  }
  Widget DiagnosticoCabecera(){
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5,right: 15),
          width: 35,
          height: 35,
          child: Image.asset("assets/diagnostic.png"),
        ),
        Text("Diagnóstico",textAlign: TextAlign.center,
          style: appTheme().textTheme.caption,)
      ],
    );
  }
  Widget detalleInvalidoCitaxCliente(){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No hay detalle disponible",style: appTheme().textTheme.subhead,)
            ],
          ),
        ],
      ),
    );
  }
  Widget detalleValidoCitaxCliente(HistorialClinico hc){
    return Container(
      margin: EdgeInsets.fromLTRB(70, 10, 70, 10),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        //color: Colors.green,
        border: Border.all(color: Colors.teal),
      ),
      child: Column(
        children: <Widget>[
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: new Image.asset('assets/avatar.png',width: 43,height: 50),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text((hc.Paciente.CitaxCliente.elementAt(0).IdDoctor.Especialidad==3?"OD. ":hc.Paciente.CitaxCliente.elementAt(0).IdDoctor.Especialidad==2?"NUT. ":"PSIC. ")+hc.Paciente.CitaxCliente.elementAt(0).IdDoctor.Nombre+" "+hc.Paciente.CitaxCliente.elementAt(0).IdDoctor.Apellido,style: appTheme().textTheme.headline),
              ),

            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(12.0, 5.0, 0.0, 5.0),
                child: Icon(Icons.calendar_today),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(17.0, 10.0, 10.0, 10.0),
                child: Text(
                  hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split("-")[2].split(" ")[0]+' de '+getMonth(hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split("-")[1])+' del '+hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split("-")[0],
                  style: appTheme().textTheme.headline,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(12.0, 5.0, 0.0, 5.0),
                child: new Image.asset('assets/reloj.png',width: 23,height: 30),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(17.0, 10.0, 10.0, 10.0),
                child: Text(hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split(" ")[1].split(":")[0] +' : '+hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split(" ")[1].split(":")[1]+" - "+hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split(" ")[2].split(":")[0] +' : '+hc.Paciente.CitaxCliente.elementAt(0).HorarioFechaP.Fecha.split(" ")[2].split(":")[1],style: appTheme().textTheme.headline),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget diagnostico(HistorialClinico hc){
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),

      child: Text(hc.Diagnostico,style: appTheme().textTheme.subhead,),
    );
  }
  String getMonth(String number){
    String month="Enero";
    if ( number.compareTo("2")==0) {
      month="Febrero";
    } else if (number.compareTo("3")==0) {
      month="Marzo";
    } else if (number.compareTo("4")==0) {
      month="Abril";
    }else if (number.compareTo("5")==0) {
      month="Mayo";
    }else if (number.compareTo("6")==0) {
      month="Junio";
    }else if (number.compareTo("7")==0) {
      month="Julio";
    }else if (number.compareTo("8")==0) {
      month="Agosto";
    }else if (number.compareTo("9")==0) {
      month="Septiembre";
    }else if (number.compareTo("10")==0) {
      month="Octubre";
    }else if (number.compareTo("11")==0) {
      month="Noviembre";
    }else if (number.compareTo("12")==0) {
      month="Diciembre";
    }
    return month;
  }
}