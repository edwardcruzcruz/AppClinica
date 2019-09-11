import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter_app/screens/MenuPage/Calendario.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';

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
  String _mySelection1;
  String _mySelection2;
  String _mySelection3;
  String _doctor;//estos son modelos
  String _horario;//estos son modelos

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dropdownApi(),//para paciente
          dropdown2(),//para especialidd
          dropdown3(),//para tipo tratamiento o consulta ---ver la forma de como validar con la key los dropdownapi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Horario:',
                style: new TextStyle(
                      fontSize: 15.0
                ),
              ),
              Text('Doctor(a):',
                style: new TextStyle(
                    fontSize: 15.0
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('-',
                style: new TextStyle(
                    fontSize: 15.0
                ),
              ),
              Text('-',
                style: new TextStyle(
                    fontSize: 15.0
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    //print(_formKey.currentState.validate());
                    bool _bandera=_formKey.currentState.validate();
                    if(_mySelection2==null){
                      _showDialogSeleccion();
                      _bandera=false;
                    }{
                      if(_bandera==true){
                        Navigator.of(context).push(CalendarioPage.route());
                      }
                    }
                  },
                  child: Text('Seleccionar Doctor y Horario'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(

                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    Navigator.of(context).pop();//pop
                  },
                  child: Text('Cancelar'),
                ),
              ),
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
                  child: Text('Agendar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
  Widget dropdownApi(){//hacer un solo metodo para solo ingresando una lista de item como parametro se pueda reutilizar el metodo
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
          _mySelection1 = newVal;
        });
      },
      value: _mySelection1,
      isExpanded: true,
      hint: Text(
          "Por favor seleccionar Cliente!",
          //style: TextStyle(
           // color: TEXT_BLACK,
          //)
      ),
    );
  }
  Widget dropdown2(){//hacer un solo metodo para solo ingresando una lista de item como parametro se pueda reutilizar el metodo
    //data=[{"id":1,"item_name":"Monitor LCD"},{"id":2,"item_name":"Speaker Boom"}];
    //api restfull https://stackoverflow.com/questions/52094031/dropdown-option-data-in-flutter-from-json-api
    // modelos y estrucctura dropdown https://medium.com/flutteropen/flutter-widgets-13-dropdownbutton-d21e9c226f04
    //esto se cambia por llamadar y tiene diferentes dropdown
    return DropdownButton(
      items: [
        DropdownMenuItem(
          value: "1",
          child: Text(
            "Odontologia",
          ),
        ),
        DropdownMenuItem(
          value: "2",
          child: Text(
            "Nutrición",
          ),
        ),
        DropdownMenuItem(
          value: "3",
          child: Text(
            "Psicologia",
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
          _mySelection2 = newVal;
        });
      },
      value: _mySelection2,
      isExpanded: true,
      hint: Text(
        "Por favor seleccionar la especialidad!",
        //style: TextStyle(
        // color: TEXT_BLACK,
        //)
      ),
    );
  }
  Widget dropdown3(){//hacer un solo metodo para solo ingresando una lista de item como parametro se pueda reutilizar el metodo
    //data=[{"id":1,"item_name":"Monitor LCD"},{"id":2,"item_name":"Speaker Boom"}];
    //api restfull https://stackoverflow.com/questions/52094031/dropdown-option-data-in-flutter-from-json-api
    // modelos y estrucctura dropdown https://medium.com/flutteropen/flutter-widgets-13-dropdownbutton-d21e9c226f04
    //esto se cambia por llamadar y tiene diferentes dropdown
    return DropdownButton(
      items: [
        DropdownMenuItem(
          value: "1",
          child: Text(
            "Consulta",
          ),
        ),
        DropdownMenuItem(
          value: "2",
          child: Text(
            "Tratamiento",
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
          _mySelection3 = newVal;
        });
      },
      value: _mySelection3,
      isExpanded: true,
      hint: Text(
        "Por favor seleccionar el tratamiento!",
        //style: TextStyle(
        // color: TEXT_BLACK,
        //)
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

