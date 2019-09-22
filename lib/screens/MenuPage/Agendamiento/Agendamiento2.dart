import 'package:flutter/material.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/screens/MenuPage/Calendario.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Agendamiento2 extends StatefulWidget {
  List<Doctor> doctores;

  Agendamiento2({Key key, this.doctores}) : super(key: key);
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
      body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: Column  (
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
      )

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
                setState(() {//se muestra barra circular de espera
                  _saving = true;
                });
                List<Horario> horarios= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                setState(() {//se oculta barra circular de espera
                  _saving = false;
                });//mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarioPage(horarios: horarios,)),
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
                        child: Text(doctores.elementAt(position).Nombre+" "+doctores.elementAt(position).Apellido),
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
      itemCount: doctores.length,
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
  List<Doctor> ListamisDoctores() {
    List<Doctor> list = new List();
    for(final doctor in doctores){
      list.add(doctor);
    }
    return list ;
  }
}

