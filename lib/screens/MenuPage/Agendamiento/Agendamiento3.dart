import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Cita.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Horarios.dart';
import 'package:flutter_app/screens/MenuPage/Noticias.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:intl/intl.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento3 extends StatefulWidget {
  Cita cita;
  DateTime fecha;
  int idEspecialidadEscogida,idHorario;
  Doctor doctor;
  User usuario;
  List<String> events;
  Function callback,callbackloading,callbackfull;
  Agendamiento3({Key key,this.usuario,this.idEspecialidadEscogida, this.idHorario,this.cita,this.doctor,this.fecha,this.events,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Agendamiento3(),
    );
  }

  @override
  _Agendamiento3State createState() => _Agendamiento3State(this.cita);

}

class _Agendamiento3State extends State<Agendamiento3>{
  //bool _saving = false;//to circular progress bar
  var storageService = locator<Var_shared>();
  Cita cita;
  _Agendamiento3State(this.cita);


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
                        this.widget.callback(Horarios(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,horarios: horariosAvaliable,doctor: this.widget.doctor,date: this.widget.fecha,selectedEvents: this.widget.events,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
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
                        child: Text(Strings.AgendarTitulo5,style: appTheme().textTheme.title,)
                    )
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
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        child: this.widget.cita.Especialidad==2?new Image.asset('assets/nutricion.png',width: 33,height: 40):this.widget.cita.Especialidad==3?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                        child: Text(this.widget.cita.Especialidad==2?"Nutrición":this.widget.cita.Especialidad==3?"Odontología":"Psicología"),
                      ),
                    ],
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: new Image.asset('assets/avatar.png',width: 43,height: 50),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((this.widget.cita.Especialidad==3?"OD. ":this.widget.cita.Especialidad==2?"NUT. ":"PSIC. ")+cita.IdDoctor),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Icon(Icons.calendar_today),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(cita.Fecha.split("-")[0]+' de '+cita.Fecha.split("-")[1]+' del '+cita.Fecha.split("-")[2].split(" ")[0]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: new Image.asset('assets/reloj.png',width: 23,height: 30),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(cita.Fecha.split(" ")[1].split(":")[0] +' : '+cita.Fecha.split(" ")[1].split(":")[1]+" - "+cita.Fecha.split(" ")[1].split(":")[0] +' : '+cita.Fecha.split(" ")[1].split(":")[0]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: FlatButton(onPressed:(){
                        Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
                      },child: Text("cancelar"),),
                    ),*/
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: FlatButton(onPressed:()async{//async
                        this.widget.callbackloading();
                        print(this.widget.usuario.Id);
                        var respuesta= await RestDatasource().save_cita(this.widget.usuario.Id,this.widget.idEspecialidadEscogida,1,this.widget.idHorario,this.widget.doctor.Id);
                        Horario horario=await RestDatasource().HorarioDoctorbyId(this.widget.idHorario);
                        var respuesta2= await RestDatasource().CambiarDisponibilidadHorarioDoctor(this.widget.idHorario, horario);
                        this.widget.callbackfull();
                        if(respuesta.statusCode==200 || respuesta.statusCode==201 || respuesta2.statusCode==200 || respuesta2.statusCode==201){
                          _showDialogSave();
                        }else{
                          _showDialogDontSave();
                        }
                      },child: Text("confirmar"),),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
          content: new Text("Se ha registrado una cita con la cuenta "+storageService.getEmail),
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
  void _showDialogDontSave() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Registro Fallido"),
          content: new Text("No se ha podido registrar una cita con la cuenta "+storageService.getEmail),
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
}

