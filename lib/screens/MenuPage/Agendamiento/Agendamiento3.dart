import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Cita.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter_app/screens/MenuPage/Calendario.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:intl/intl.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento3 extends StatefulWidget {
  Cita cita;

  Agendamiento3({Key key, this.cita}) : super(key: key);
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
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
      ),
      body: /*ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child:*/ Column  (
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
          new Expanded (
              child: formulario()
          )
          //),
        ],
      ),
      //)
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
                        width: 40.0,
                        height: 40.0,
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: new AssetImage(
                              'assets/splash.jpg'),
                              fit: BoxFit.fill,
                            ),
                          //shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                        child: Text(cita.Especialidad),
                      ),
                    ],
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: Text("Doctor: "+cita.IdDoctor),
                    ),
                  ],
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: Text(DateTime.parse(DateFormat("yyyy-MM-dd").format(cita.Fecha).toString()).day.toString()+' de '+DateTime.parse(DateFormat("yyyy-MM-dd").format(cita.Fecha).toString()).month.toString()+' del '+DateTime.parse(DateFormat("yyyy-MM-dd").format(cita.Fecha).toString()).year.toString()),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: Text(cita.Fecha.hour.toString() +' : '+cita.Fecha.minute.toString()+" - "+cita.Fecha.hour.toString() +' : '+cita.Fecha.add(Duration(minutes: 30)).minute.toString()),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: FlatButton(onPressed:(){
                        Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
                      },child: Text("cancelar"),),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 6.0),
                      child: FlatButton(onPressed:(){//async
                        /*setState(() {//se muestra barra circular de espera
                          _saving = true;
                        });
                        var respuesta= await RestDatasource().save_cita(cita);
                        setState(() {//se muestra barra circular de espera
                          _saving = false;
                        });
                        if(respuesta.statusCode>=200 || respuesta.statusCode<=400){*/
                          _showDialogSave();
                        //}
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
                Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        );
      },
    );
  }
}

