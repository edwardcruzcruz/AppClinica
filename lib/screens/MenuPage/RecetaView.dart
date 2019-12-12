/*
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/Receta.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento2.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RecetaView extends StatefulWidget {
  List<Receta> especialidades;
  User usuario;
  Function callback,callbackloading,callbackfull;
  RecetaView({Key key,this.usuario, this.especialidades,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => RecetaView(),
    );
  }

  @override
  _RecetaViewState createState() => _RecetaViewState(this.especialidades);

}

class _RecetaViewState extends State<RecetaView>{
  bool _saving = false;//to circular progress bar

  List<Receta> recetas;
  _RecetaViewState(this.recetas);
  var storageService = locator<Var_shared>();
  User usuario;
  //List<Doctor> _doctor;//estos son modelos
  //Horario _horario;//estos son modelos


  final _formKey = GlobalKey<FormState>();
  List data = List();
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
                  child: Text(Strings.AppbarIconoAgregarCita,style: appTheme().textTheme.display3,),
                ),
              ],
            ),
          ),
        ),
        new Expanded(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async{
                        this.widget.callbackloading();
                        List<Horario> horariosAvaliable=new List();
                        final temp=DateTime.now();
                        List<Horario> horarios= await RestDatasource().HorarioDoctor(this.widget.doctor.Id);
                        if(horarios!=null){
                          for(int i=0;i<horarios.length;i++){
                            DateTime fechaTemp=DateTime.parse(horarios.elementAt(i).Fecha);
                            if(horarios.elementAt(i).IsAvaliable && (fechaTemp.isAfter(temp)||(fechaTemp.isAtSameMomentAs(temp)&&temp.hour>fechaTemp.hour))){//dias posteriores .. si se graba
                              horariosAvaliable.add(horarios.elementAt(i));
                            }
                          }
                        }
                        this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                        this.widget.callback(Horarios(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,horarios: horariosAvaliable,doctor: this.widget.doctor,date: this.widget.fecha,selectedEvents: this.widget.events,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,agendar: this.widget.agendar,idCita: this.widget.idCita,));
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
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              formulario(),
            ],
          ),
        )
        //),
      ],
    );
  }

  Widget formulario(){
    return ListView.builder( //validar null citasProximas
      shrinkWrap: true,
      itemCount: recetas.length,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[

            GestureDetector(
              onTap: () { //async
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Expanded(child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    15.0, 2.0, 1.0, 2.0),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: new Image.asset(
                                    'assets/avatar.png', width: 33,
                                    height: 40),
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
                                    7.0, 12.0, 12.0, 3.0),
                                child: Text((recetas.
                                    .elementAt(position)
                                    .GetCita
                                    .IDEspecialidad
                                    .NombreEspecialidad == "Odontología"
                                    ? "OD. "
                                    : snapshot.data
                                    .elementAt(position)
                                    .GetCita
                                    .IDEspecialidad
                                    .NombreEspecialidad == "Nutrición"
                                    ? "NUT. "
                                    : "PSIC. ") + snapshot.data
                                    .elementAt(position)
                                    .GetCita
                                    .IdDoctor
                                    .Nombre + " " + snapshot.data
                                    .elementAt(position)
                                    .GetCita
                                    .IdDoctor
                                    .Apellido,
                                  style: appTheme().textTheme
                                      .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      */
/*Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            10.0, 12.0, 12.0, 3.0),
                                        child: Text(snapshot.data
                                            .elementAt(position)
                                            .GetCita
                                            .Fecha
                                            .Fecha, style: appTheme().textTheme
                                            .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
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
                                            .GetCita
                                            .Fecha
                                            .Hora
                                            .HorarioInicio + " " + snapshot.data
                                            .elementAt(position)
                                            .GetCita
                                            .Fecha
                                            .Hora
                                            .Horariofin,
                                          style: appTheme().textTheme
                                              .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                                      ),
                                    ],
                                  ),
                                ],
                              ),*//*

                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
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
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                    10.0, 12.0, 12.0, 3.0),
                                child: Text(snapshot.data
                                    .elementAt(position)
                                    .GetCita.IDEspecialidad.NombreEspecialidad,
                                  style: appTheme().textTheme
                                      .subhead,), //Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    );
  }
  void _showDialogSeleccionNull() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sin contenido"),
          content: new Text("No hay doctores en esta especialidad, trabajando..."),
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

*/
