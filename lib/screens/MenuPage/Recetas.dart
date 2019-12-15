import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/models/Receta.dart';

import 'RecetaView.dart';

class Recetas extends StatefulWidget {
  Function callback, callbackloading, callbackfull;

  Recetas({Key key, this.callback, this.callbackloading, this.callbackfull})
      : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Recetas(),
    );
  }

  @override
  _RecetasState createState() => _RecetasState();
}

class _RecetasState extends State<Recetas> {
  final temp = DateTime.now();
  var storageService = locator<Var_shared>();
  Future<List<Receta>> future;

  @override
  void initState() {
    super.initState();
    print("***********************--------------------------------*********************************");
    print(storageService.getIdPadre);
    print("***********************--------------------------------*********************************");
    future = RestDatasource().ListarRecetas(storageService.getIdPadre);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                      MediaQuery.of(context).size.width, 120.0))),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Align(
                  child: Text(
                    Strings.CuerpoTituloBienvenido,
                    style: appTheme().textTheme.display1,
                  ),
                  alignment: Alignment(-0.80, 0),
                ),
                Align(
                  child: new Text(
                    storageService.getCuentaActual,
                    style: appTheme().textTheme.display2,
                  ),
                  alignment: Alignment(-0.80, 0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Align(
                  child: Text(
                    Strings.CuerpoTituloPaginaRecetas,
                    style: appTheme().textTheme.display3,
                  ),
                ),
              ],
            ),
          ),
        ),
        new Expanded(
          child: new Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //alignment: Alignment(50, 0),
                        margin:
                        const EdgeInsets.fromLTRB(65.0, 20.0, 10.0, 20.0),
                        child: Text(
                          "Paciente: " + storageService.getCuentaActual,
                          style: appTheme().textTheme.subhead,
                        )),
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child:
                /*this.widget.recetas == null ? Center(child: Text(
                        "Sin contenido que mostrar",
                        textAlign: TextAlign.center, style: appTheme().textTheme
                          .subhead,),) :*/
                formulario(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget formulario() {
    /*List<Receta> recetasAnteriores=new List();
    for(int i=0;i<data.length;i++){
      DateTime fechaTemp=DateTime.parse(data.elementAt(i).GetCita.Fecha.Fecha);//+" "+this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio
      if(fechaTemp.isBefore(temp)){
        recetasAnteriores.add(data.elementAt(i));
      }
    }*/

    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Receta>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text(
                "No hay recetas",
                textAlign: TextAlign.center,
                style: appTheme().textTheme.display4,
              ); //'Error: ${snapshot.error}'

            //String especialidad=this.doctores.elementAt(0).Especialidad;
            return snapshot.data.length>0?
            ListView.builder(
              //validar null citasProximas
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        //async
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                15.0, 2.0, 1.0, 2.0),
                                            //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                            child: new Image.asset(
                                                'assets/avatar.png',
                                                width: 33,
                                                height: 40),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                7.0, 12.0, 12.0, 3.0),
                                            child: Text(
                                              (snapshot.data
                                                  .elementAt(position)
                                                  .IDEspecialidad
                                                  .NombreEspecialidad ==
                                                  "Odontología"
                                                  ? "OD. "
                                                  : snapshot.data
                                                  .elementAt(
                                                  position)
                                                  .IDEspecialidad
                                                  .NombreEspecialidad ==
                                                  "Nutrición"
                                                  ? "NUT. "
                                                  : "PSIC. ") +
                                                  snapshot.data
                                                      .elementAt(position)
                                                      .IdDoctor
                                                      .Nombre +
                                                  " " +
                                                  snapshot.data
                                                      .elementAt(position)
                                                      .IdDoctor
                                                      .Apellido,
                                              style: appTheme().textTheme.subhead,
                                            ), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  /*Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            20.0, 2.0, 1.0, 2.0),
                                        child: new Image.asset(
                                            'assets/recetas_activo.png', width: 33,
                                            height: 40),//new Image.asset('assets/avatar.png',width: 43,height: 50),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            10.0, 12.0, 12.0, 3.0),
                                        child: Text(snapshot.data
                                            .elementAt(position).Medicina, style: appTheme().textTheme
                                            .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),*/
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20.0, 2.0, 1.0, 2.0),
                                            child: Icon(Icons
                                                .calendar_today), //new Image.asset('assets/avatar.png',width: 43,height: 50),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10.0, 12.0, 12.0, 3.0),
                                            child: Text(
                                              snapshot.data
                                                  .elementAt(position)
                                                  .Fecha
                                                  .Fecha,
                                              style: appTheme().textTheme.subhead,
                                            ), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20.0, 2.0, 1.0, 2.0),
                                            //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                            child: Icon(Icons
                                                .access_time), //new Image.asset('assets/avatar.png',width: 43,height: 50),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                10.0, 12.0, 12.0, 3.0),
                                            child: Text(snapshot.data
                                                .elementAt(position)
                                                .Fecha
                                                .Hora
                                                .HorarioInicio + " " + snapshot.data
                                                .elementAt(position)
                                                .Fecha
                                                .Hora
                                                .Horariofin,
                                              style: appTheme().textTheme
                                                  .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20.0, 2.0, 1.0, 2.0),
                                            child: Icon(Icons
                                                .edit), //new Image.asset('assets/avatar.png',width: 43,height: 50),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10.0, 12.0, 12.0, 3.0),
                                            child: Text(
                                              snapshot.data
                                                  .elementAt(position)
                                                  .Description,
                                              style: appTheme().textTheme.subhead,
                                            ), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          GestureDetector(
                            onTap: () {
                              //async
                              this.widget.callbackloading();
                              this.widget.callbackfull();
                              this.widget.callback(RecetaView(
                                recetas: snapshot.data
                                    .elementAt(position)
                                    .RecetaPorCita,
                                callback: this.widget.callback,
                                callbackloading:
                                this.widget.callbackloading,
                                callbackfull: this.widget.callbackfull,
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 25.0, 0.0),
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: 25.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
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
            )
                :Text(
              "No hay recetas",
              textAlign: TextAlign.center,
              style: appTheme().textTheme.display4,
            )
            ;
        }
        return null;
      },
    );
  }
}
