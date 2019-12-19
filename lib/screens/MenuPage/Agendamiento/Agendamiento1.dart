import 'package:flutter/material.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento2.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento extends StatefulWidget {
  List<Especialidad> especialidades;
  User usuario;
  Function callback,callbackloading,callbackfull;
  Agendamiento({Key key,this.usuario, this.especialidades,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Agendamiento(),
    );
  }

  @override
  _AgendamientoState createState() => _AgendamientoState(this.especialidades);

}

class _AgendamientoState extends State<Agendamiento>{
  bool _saving = false;//to circular progress bar

  List<Especialidad> especialidades;
  _AgendamientoState(this.especialidades);
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
                    margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                    child: Text(Strings.AgendarTitulo1,style: appTheme().textTheme.title,),
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
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async{
                this.widget.callbackloading();
                List<Doctor> doctores= await RestDatasource().doctoresEspecialidad(especialidades.elementAt(position).Id);
                this.widget.callbackfull();
                if(doctores.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(Agendamiento2(usuario: this.widget.usuario,idEspecialidadEscogida: this.especialidades.elementAt(position).Id,doctores: doctores,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                }
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
                        //if("Nutricion".equal(especialidades.elementAt(position).NombreEspecialidad)){
                          //child: new Image.asset('assets/nutricion.png',width: 33,height: 40),
                        //}else{
                          child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                        //}
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                        child: Text(especialidades.elementAt(position).NombreEspecialidad,style: appTheme().textTheme.display4,),
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
      itemCount: especialidades.length,
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

