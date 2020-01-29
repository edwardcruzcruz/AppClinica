import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/Utils.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento3.dart';
import 'package:flutter_app/models/Cita.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/screens/MenuPage/Calendario.dart';
import 'package:flutter_app/services/Rest_Services.dart';

class Horarios extends StatefulWidget {
  Doctor doctor;
  User usuario;
  int idEspecialidadEscogida;
  DateTime date;
  List<Horario> horarios;
  List<String> selectedEvents;
  Function callback,callbackloading,callbackfull;
  bool agendar;
  int idCita;
  Horarios({Key key, this.usuario,this.idEspecialidadEscogida , this.horarios,this.doctor,this.date,this.selectedEvents,this.callback,this.callbackloading,this.callbackfull,this.agendar,this.idCita}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Horarios(),
    );
  }

  @override
  _HorariosState createState() => _HorariosState();

}

class _HorariosState extends State<Horarios>{
  _HorariosState();
  var storageService = locator<Var_shared>();


  final _formKey = GlobalKey<FormState>();
  List data = List();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Utils.setOval(context,Strings.CuerpoTituloBienvenido,storageService.getCuentaActual,Strings.AppbarIconoAgregarCita),
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
                        List<HorarioRango> horariosId=new List();
                        List<Horario> horariosAvaliable=new List();
                        final temp=DateTime.now();
                        List<Horario> horarios= await RestDatasource().HorarioDoctor(this.widget.doctor.Id);
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
                        this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                        //CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida, idHorario: horarios.elementAt(position).IdHorario,horarios: horarios,horariosID: horariosId,doctor: doctores.elementAt(position)
                        this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,horarios: horariosAvaliable,horariosID: horariosId,doctor: this.widget.doctor,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,agendar: this.widget.agendar,idCita: this.widget.idCita,));
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
                        child: Text(Strings.AgendarTitulo4,style: appTheme().textTheme.title,)
                    )
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: formulario(),//formulario()
              ),
            ],
          ),
        )
        //),
      ],
    );
  }

  Widget formulario(){
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                //print(this.widget.selectedEvents.elementAt(position).toString());
                /*int idHorario=0;
                for(final horario in this.widget.horarios){
                  if(horario.Fecha.compareTo(this.widget.selectedEvents.elementAt(position))==1){
                    idHorario=horario.Hora;
                  }
                }*/
                this.widget.callback(Agendamiento3(usuario: this.widget.usuario,idEspecialidadEscogida:  this.widget.idEspecialidadEscogida,idHorario: this.widget.horarios.elementAt(position).IdHorario,cita: new Cita(storageService.getEmail,this.widget.idEspecialidadEscogida,"dental",(DateFormat("yyyy-MM-dd").format(this.widget.date).toString()+" "+this.widget.selectedEvents.elementAt(position).toString()),this.widget.doctor.Nombre+' '+this.widget.doctor.Apellido),doctor: this.widget.doctor,fecha: this.widget.date,events: this.widget.selectedEvents,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,agendar: this.widget.agendar,idCita: this.widget.idCita,));
                //this.widget.callbackloading();
                //List<Horario> horarios= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                //this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                //this.widget.callback(CalendarioPage(horarios: horarios,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
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
                        child: new Image.asset('assets/reloj_disponible.png',width: 43,height: 50),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 3.0),
                        child: Text(this.widget.selectedEvents.elementAt(position).split(" ")[0].split(":")[0] +' : '+this.widget.selectedEvents.elementAt(position).split(" ")[0].split(":")[1]+" - "+this.widget.selectedEvents.elementAt(position).split(" ")[1].split(":")[0] +' : '+this.widget.selectedEvents.elementAt(position).split(" ")[1].split(":")[1]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
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
      itemCount: this.widget.selectedEvents.length,
    );
  }
  void _showDialogSeleccion() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Falta un campo Requerido"),
          content: new Text("Seleccione un tipo de Especialidad"),
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

