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
  Future<HistorialClinico> future;//CitaCompleta
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
      builder: (BuildContext context, AsyncSnapshot<HistorialClinico> snapshot) {
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

            return snapshot.data != null
              ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Falta implementar")
                  ],
                ): Text(
              "No hay información nueva",
              textAlign: TextAlign.center,
              style: appTheme().textTheme.display4,
            );
        }
        return null;
      },
    );
  }
  /*Widget detalle(HistorialClinico hc){
    Container(
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
                child: Text((this.widget.cita.Especialidad==3?"OD. ":this.widget.cita.Especialidad==2?"NUT. ":"PSIC. ")+cita.IdDoctor,style: appTheme().textTheme.headline),
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
                  cita.Fecha.split("-")[2].split(" ")[0]+' de '+getMonth(cita.Fecha.split("-")[1])+' del '+cita.Fecha.split("-")[0],
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
                child: Text(cita.Fecha.split(" ")[1].split(":")[0] +' : '+cita.Fecha.split(" ")[1].split(":")[1]+" - "+cita.Fecha.split(" ")[2].split(":")[0] +' : '+cita.Fecha.split(" ")[2].split(":")[1],style: appTheme().textTheme.headline),
              ),
            ],
          ),
        ],
      ),
    )
  }*/
}