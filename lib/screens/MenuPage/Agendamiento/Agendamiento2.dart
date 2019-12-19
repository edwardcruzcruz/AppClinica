import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento1.dart';
import 'package:flutter_app/screens/MenuPage/Calendario.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento2 extends StatefulWidget {
  List<Doctor> doctores;
  User usuario;
  int idEspecialidadEscogida;
  Function callback,callbackloading,callbackfull;

  Agendamiento2({Key key,this.usuario,this.idEspecialidadEscogida, this.doctores,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Agendamiento2(),
    );
  }

  @override
  _Agendamiento2State createState() => _Agendamiento2State(this.doctores);

}

class _Agendamiento2State extends State<Agendamiento2>{
  bool _saving = false;//to circular progress bar
  List<Doctor> doctores;
  _Agendamiento2State(this.doctores);
  var storageService = locator<Var_shared>();


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
                        this.widget.callbackloading;
                        List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad();
                        this.widget.callbackfull;
                        this.widget.callback(Agendamiento(usuario: this.widget.usuario,especialidades: especialidades,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
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
                      child: Text(Strings.AgendarTitulo2,style: appTheme().textTheme.title,)
                    )
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: formulario(),
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
                this.widget.callbackloading();
                List<HorarioRango> horariosId=new List();
                List<Horario> horariosAvaliable=new List();
                final temp=DateTime.now();
                List<Horario> horarios= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
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
                //List<>
                this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                if(horarios.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida,horarios: horariosAvaliable,horariosID: horariosId,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,agendar: true,idCita: 0,));
                }
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
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
                          child: Text((doctores.elementAt(position).Especialidad==3?"OD. ":doctores.elementAt(position).Especialidad==2?"NUT. ":"PSIC. ")+doctores.elementAt(position).Nombre+" "+doctores.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0.0, 6.0, 12.0, 12.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset('assets/titulo.png',width: 23,height: 30),
                                  Text(" Titulo ...",style: appTheme().textTheme.title,),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset('assets/clinica.png',width: 23,height: 30),
                                  Text(" Clínica Estética Dental",style: appTheme().textTheme.title,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
      itemCount: doctores.length,
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
          content: new Text("No hay horarios disponibles con este doctor"),
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

