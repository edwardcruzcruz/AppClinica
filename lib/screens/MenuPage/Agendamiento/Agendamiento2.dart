import 'package:flutter/material.dart';

class Agendamiento2 extends StatefulWidget {
  String especialidad;

  Agendamiento2({Key key, this.especialidad}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Agendamiento2(),
    );
  }

  @override
  _Agendamiento2State createState() => _Agendamiento2State(this.especialidad);

}

class _Agendamiento2State extends State<Agendamiento2>{
  String especialidad;
  _Agendamiento2State(this.especialidad);
  //var storageService = locator<Var_shared>();
  //User usuario;
  //Doctor _doctor;//estos son modelos
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
      body: Column(
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
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  new Container(
                    //padding: EdgeInsets.all(20),
                    //child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: new Text(
                                          'Agendamiento de Citas',
                                          style: new TextStyle(
                                            fontSize: 20.0
                                            //color: Colors.yellow,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        formulario(),
                      ],
                    ),
                  ),
                ],
              )
          )
          //),
        ],
      ),

    );
  }

  Widget formulario(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[//para tipo tratamiento o consulta ---ver la forma de como validar con la key los dropdownapi
          ListTile(
            leading: Icon(Icons.people),
            title: Text(especialidad),
            onTap: () {
              // This line code will close drawer programatically....
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(especialidad),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(especialidad),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 2.0,
          ),

        ],
      ),
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

