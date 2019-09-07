import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
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
  var storageService = locator<Var_shared>();
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
                            //Text('25 min'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: new Row(
                                children: <Widget>[
                                  new Column(
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                        width: 130.0,
                                        height: 130.0,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            image: new AssetImage(
                                                'assets/historial.png'),
                                            fit: BoxFit.none,
                                          ),
                                          shape: BoxShape.circle,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                      new Container(
                                        child: new Text('Historial Clinico'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            new Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: new Row(
                                children: <Widget>[
                                  new Column(
                                    children: <Widget>[
                                      new Container(
                                        margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                        width: 130.0,
                                        height: 130.0,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            image: new AssetImage(
                                                'assets/resultados.png'),
                                            fit: BoxFit.none,
                                          ),
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(22, 48, 207, 100),
                                        ),
                                      ),
                                      new Container(
                                        child: new Text('Mis Resultados'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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

}
