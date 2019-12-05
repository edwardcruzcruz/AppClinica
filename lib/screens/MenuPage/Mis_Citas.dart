import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/models/CitaCompleta.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Calendario.dart';

class Citas extends StatefulWidget {
  List<CitaCompleta> citasList;
  Function callback,callbackloading,callbackfull;
  Citas({Key key,this.citasList,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Citas(),
    );
  }

  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas>{
  final temp=DateTime.now();
  var storageService = locator<Var_shared>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
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
                  child: Text(Strings.CuerpoTituloPaginaCitas,style: appTheme().textTheme.display3,),
                )
              ],
            ),
          ),
        ),
        new Expanded(
          child: new DefaultTabController(
            length: 2,
            child: new Scaffold(
              appBar: new PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: new Container(
                  color: Colors.transparent,
                  child: new SafeArea(
                    child: Column(
                      children: <Widget>[
                        new TabBar(
                          indicatorColor: Colors.teal,
                          tabs: [
                            new Container(
                            margin: EdgeInsets.fromLTRB(0,10,0,10),
                            child: new Text(Strings.Tab1Citas,style: appTheme().textTheme.subhead,),
                          ), new Container(
                              margin: EdgeInsets.fromLTRB(0,10,0,10),
                              child: new Text(Strings.Tab2Citas,style: appTheme().textTheme.subhead,)
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: new TabBarView(
                children: <Widget>[
                  new Column(
                    children: <Widget>[new Expanded(child: this.widget.citasList==null?Center(child: Text("Sin contenido que mostrar",textAlign: TextAlign.center,style: appTheme().textTheme.subhead,),) :formulario())],//Text("Próximos Page")
                  ),
                  new Column(
                    children: <Widget>[new Expanded(child: this.widget.citasList==null?Center(child: Text("Sin contenido que mostrar",textAlign: TextAlign.center,style: appTheme().textTheme.subhead),) :formulario2())],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget formulario(){
    print("--------------------------------------------------------------------------------------------");
    //final temp=DateTime.now();
    List<CitaCompleta> citasProximas=new List();
    for(int i=0;i<this.widget.citasList.length;i++){
      DateTime fechaTemp=DateTime.parse(this.widget.citasList.elementAt(i).Fecha.Fecha);//+" "+this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio
      if(fechaTemp.isAfter(temp) || fechaTemp.isAtSameMomentAs(temp)){
        citasProximas.add(this.widget.citasList.elementAt(i));
      }
    }
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(//validar null citasProximas
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[

            GestureDetector(
              onTap: () {//async
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Expanded(child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(15.0,2.0,1.0,2.0),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: new Image.asset('assets/avatar.png',width: 33,height: 40),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(7.0, 12.0, 12.0, 3.0),
                                child: Text((this.widget.citasList.elementAt(position).Especialidad=="Odontología"?"OD. ":this.widget.citasList.elementAt(position).Especialidad=="Nutrición"?"NUT. ":"PSIC. ")+this.widget.citasList.elementAt(position).IdDoctor.Nombre+" "+this.widget.citasList.elementAt(position).IdDoctor.Apellido,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20.0,2.0,1.0,2.0),
                                child: Icon(Icons.calendar_today),//new Image.asset('assets/avatar.png',width: 43,height: 50),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 3.0),
                                child: Text(this.widget.citasList.elementAt(position).Fecha.Fecha,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20.0,2.0,1.0,2.0),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: Icon(Icons.access_time),//new Image.asset('assets/avatar.png',width: 43,height: 50),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 3.0),
                                child: Text(this.widget.citasList.elementAt(position).Fecha.Hora.HorarioInicio+" "+this.widget.citasList.elementAt(position).Fecha.Hora.Horariofin,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
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
                          padding: const EdgeInsets.all(2.0),
                          child:new IconButton(
                            icon: Icon(
                              Icons.add_alert,
                              size: 25.0,
                              color: Colors.grey,

                            ), // Icon(Icons.note_add),
                            onPressed: () async {
                              this._recordatorio(position);
                              /*final int helloAlarmID = position;
                              await AndroidAlarmManager.initialize();
                              await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID, printHello);*/
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(icon: Icon(
                              Icons.edit,
                              size: 25.0,
                              color: Colors.grey,
                            ), onPressed: () async {
                              List<HorarioRango> horariosId=new List();
                              List<Horario> horariosAvaliable=new List();
                              final temp=DateTime.now();
                              List<Horario> horarios= await RestDatasource().HorarioDoctor(this.widget.citasList.elementAt(position).IdDoctor.Id);
                              if(horarios!=null){
                                for(int i=0;i<horarios.length;i++){
                                  DateTime fechaTemp=DateTime.parse(horarios.elementAt(i).Fecha);
                                  HorarioRango horarioid=await RestDatasource().HorarioId(horarios.elementAt(i).Hora);
                                  if(horarioid!=null && horarios.elementAt(i).IsAvaliable && (fechaTemp.isAfter(temp)||(fechaTemp.isAtSameMomentAs(temp)&&temp.hour>fechaTemp.hour))){//dias posteriores .. si se graba
                                    horariosId.add(horarioid);
                                    horariosAvaliable.add(horarios.elementAt(i));
                                  }
                                }
                              }
                              User usuario= await RestDatasource().perfil(storageService.getEmail) ;
                              List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad();
                              int idEspecialidad=0;
                              for(var especialidad in especialidades){
                                if(especialidad.NombreEspecialidad==this.widget.citasList.elementAt(position).Especialidad){
                                  idEspecialidad=especialidad.Id;
                                }
                              }
                              print("--------------------------------------------"+this.widget.citasList.elementAt(position).Especialidad);
                              this.widget.callback(
                                  CalendarioPage(
                                    agendar: false,
                                    callback: this.widget.callback,
                                    callbackfull: this.widget.callbackfull,
                                    callbackloading: this.widget.callbackloading,
                                    usuario: usuario,
                                    doctor: this.widget.citasList.elementAt(position).IdDoctor,
                                    horarios: horariosAvaliable,
                                    horariosID: horariosId,
                                    idEspecialidadEscogida: idEspecialidad,
                                    idCita:this.widget.citasList.elementAt(position).Id ,

                                  ));

                                /*ModificarCuenta(
                                  cuenta: this.widget.cuentas.elementAt(position),
                                  cuentas: this.widget.cuentas,
                                  callback: this.widget.callback,
                                  callbackloading: this.widget.callbackloading,
                                  callbackfull: this.widget.callbackfull,)
                              );*/
                            }
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child:IconButton(
                            icon:Icon(
                              Icons.delete,
                              size: 25.0,
                              color: Colors.grey,
                            ),
                            onPressed: (){

                              this._eliminar(position);
                            },
                          )
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
      itemCount: citasProximas.length,
    );
  }

  Widget formulario2(){
    print("*****************************************************************************************************");
    var rating = 0.0;
    List<CitaCompleta> citasProximas=new List();
    for(int i=0;i<this.widget.citasList.length;i++){
      DateTime fechaTemp=DateTime.parse(this.widget.citasList.elementAt(i).Fecha.Fecha);//+" "+this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio
      if(fechaTemp.isBefore(temp)){
        citasProximas.add(this.widget.citasList.elementAt(i));
      }
    }
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(//validar null citasProximas
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[

            GestureDetector(
              onTap: () {//async
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Expanded(child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(15.0,2.0,1.0,2.0),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: new Image.asset('assets/avatar.png',width: 33,height: 40),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(7.0, 12.0, 12.0, 3.0),
                                child: Text((this.widget.citasList.elementAt(position).Especialidad=="Odontología"?"OD. ":this.widget.citasList.elementAt(position).Especialidad=="Nutrición"?"NUT. ":"PSIC. ")+this.widget.citasList.elementAt(position).IdDoctor.Nombre+" "+this.widget.citasList.elementAt(position).IdDoctor.Apellido,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20.0,2.0,1.0,2.0),
                                child: Icon(Icons.calendar_today),//new Image.asset('assets/avatar.png',width: 43,height: 50),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 3.0),
                                child: Text(this.widget.citasList.elementAt(position).Fecha.Fecha,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20.0,2.0,1.0,2.0),
                                //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                                child: Icon(Icons.access_time),//new Image.asset('assets/avatar.png',width: 43,height: 50),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 3.0),
                                child: Text(this.widget.citasList.elementAt(position).Fecha.Hora.HorarioInicio+" "+this.widget.citasList.elementAt(position).Fecha.Hora.Horariofin,style: appTheme().textTheme.subhead,),//Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
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
                        Container(
                          width: 100,
                          height: 20,
                          child: SmoothStarRating(
                              allowHalfRating: true,
                              onRatingChanged: (v) {
                                rating = v;
                                setState(() {});
                              },
                              starCount: 5,
                              rating: rating,
                              size: 20.0,
                              color: Colors.yellow,
                              borderColor: Colors.yellow,
                              spacing:0.0
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
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
      itemCount: citasProximas.length,
    );
  }
  /*void printHello() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }*/

  void _eliminar(position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: new Text("¿Desea cancelar la cita seleccionada?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new Center(
                  child: new Row(
                    children: <Widget>[
                      new FlatButton(
                        child: new Text("Aceptar"),
                        onPressed: () async {
                          //this.widget.callback(Citas());
                          var horarios = await RestDatasource().delete_cita(this
                              .widget.citasList
                              .elementAt(position)
                              .Id);
                          Navigator.of(context).pop();
                          //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
                        },
                      ),
                      new FlatButton(
                        child: new Text("Cancelar"),
                        onPressed: () {
                          //this.widget.callback(Citas());
                          Navigator.of(context).pop();
                          //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
                        },
                      ),
                    ],
                  ))
            ]
        );
      },
    );
  }

  void _recordatorio(i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("¿Está seguro de agregar alarma?"),
          actions: <Widget>[
        new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                print(this.widget.citasList.elementAt(i).Fecha.Fecha);
                print(this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio);
                DateTime dateparse= DateTime.parse(this.widget.citasList.elementAt(i).Fecha.Fecha.toString()+" "+this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio);
                DateTime fechaReal=dateparse.subtract(new Duration(minutes: 30));
                print(this.widget.citasList.elementAt(i).IdDoctor.Apellido);
                String cuerpo="Tiene cita con el doctor "+this.widget.citasList.elementAt(i).IdDoctor.Apellido+" en 30 minutos\n";
                String especialidad=this.widget.citasList.elementAt(i).Especialidad;
                String data=this.widget.citasList.elementAt(i).Fecha.Hora.HorarioInicio.toString()+"-"+this.widget.citasList.elementAt(i).IdDoctor.Apellido+"-"+this.widget.citasList.elementAt(i).Especialidad+"-"+this.widget.citasList.elementAt(i).Fecha.Hora.Horariofin.toString();
                this._programada(fechaReal,cuerpo,especialidad,data);
                //this.widget.callback(Citas());
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        ),
        ),

          ],
        );
      },
    );
  }

  Future onSelectNotification(String payload) async {
    print("*****************");
    print(payload);
    List<String> datos=payload.split("-");
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Recordatorio"),
          content: Text("Especialidad: "+datos[2]+"\nHora inicio: "+datos[0]+"\nHora fin: "+datos[3]+"\nDoctor: "+datos[1]),
        );
      },
    );
  }


  Future _programada(fecha,cuerpo,especialidad,data)async{

    var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('your other channel id',
        'your other channel name', 'your other channel description',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        especialidad,
        cuerpo,
        new DateTime.now().add(Duration(seconds: 10)),//fecha
        platformChannelSpecifics,
    payload: data);

  }


}