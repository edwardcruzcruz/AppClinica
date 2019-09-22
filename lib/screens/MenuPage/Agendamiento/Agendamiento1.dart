import 'package:flutter/material.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento2.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento extends StatefulWidget {
  List<Especialidad> especialidades;
  Agendamiento({Key key, this.especialidades}) : super(key: key);
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
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
      ),
      body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: Column(
        children: <Widget>[
          new Banner(
            message: "",//mensaje esquina superior derecha
            location: BannerLocation.topEnd,
            color: Colors.red,
            child: Container(
              margin: const EdgeInsets.only(left:0.0,top:10.0,right: 0.0,bottom: 0.0),
              color: Colors.blue,
              height: 100,
              child: Center(child: new Image.asset('assets/promocion.jpg', fit: BoxFit.fill,),),
            ),
          ),
          new Expanded(
              child: formulario(),
          )
          //),
        ],
      ),
      )
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
                setState(() {//se muestra barra circular de espera
                  _saving = true;
                });
                List<Doctor> doctores= await RestDatasource().doctoresEspecialidad(especialidades.elementAt(position).NombreEspecialidad);
                setState(() {//se oculta barra circular de espera
                  _saving = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Agendamiento2(doctores: doctores,)),
                );
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
                        width: 90.0,
                        height: 90.0,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage(
                                'assets/splash.jpg'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                        child: Text(especialidades.elementAt(position).NombreEspecialidad),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 6.0, 12.0, 12.0),
                        child: Text("degree and icon"),
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
                            Icons.arrow_right,
                            size: 35.0,
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

