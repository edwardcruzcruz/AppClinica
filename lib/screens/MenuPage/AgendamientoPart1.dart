import 'package:flutter/material.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_app/services/Shared_Preferences.dart';

class Agendamiento extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Agendamiento(),
    );
  }

  @override
  _AgendamientoState createState() => _AgendamientoState();

}

class _AgendamientoState extends State<Agendamiento>{
  String _mySelection;
  final _formKey = GlobalKey<FormState>();
  var storageService = locator<Var_shared>();
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
              child: Center(child: Text("Hello, banner!"),),
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
                                        child: new Text('Agendamiento de Citas'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        formulario1(),
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

  Widget formulario1(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dropdownApi(),//para paciente
          dropdownApi(),//para especialidd
          dropdownApi(),//para tipo tratamiento o consulta ---ver la forma de como validar con la key los dropdownapi
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(

              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Siguiente'),
            ),
          ),
        ],
      ),
    );

  }
  Widget dropdownApi(){
    //data=[{"id":1,"item_name":"Monitor LCD"},{"id":2,"item_name":"Speaker Boom"}];
    //api restfull https://stackoverflow.com/questions/52094031/dropdown-option-data-in-flutter-from-json-api
    // modelos y estrucctura dropdown https://medium.com/flutteropen/flutter-widgets-13-dropdownbutton-d21e9c226f04
    //esto se cambia por llamadar y tiene diferentes dropdown
    return DropdownButton(
      items: [
        DropdownMenuItem(
          value: "1",
          child: Text(
            "Edward",
          ),
        ),
        DropdownMenuItem(
          value: "2",
          child: Text(
          "Jose",
          ),
        ),
      ]
      /*data.map((item) {
        DropdownMenuItem(
          child: new Text(item['item_name']),
          value: item['id'].toString(),
        );
      }).toList()*/,
      onChanged: (newVal) {
        setState(() {
          _mySelection = newVal;
        });
      },
      value: _mySelection,
      isExpanded: true,
      hint: Text(
          "Por favor seleccionar opción!",
          //style: TextStyle(
           // color: TEXT_BLACK,
          //)
      ),
    );
  }
}
