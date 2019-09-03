import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  static Route<dynamic> route(String mensaje) {
    return MaterialPageRoute(
      builder: (context) => Home(mensaje: mensaje),
    );
  }


  final String mensaje;


  const Home({Key key, @required this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navegacion',
            color: Colors.white,
            onPressed: () =>
                ListTile(
                ),
          ),
        ],
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
                                            'assets/agendamiento.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(204,192, 2,100),
                                    ),
                                  ),
                                  new Container(
                                    child: new Text('Agendar Cita'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                            'assets/calendario.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(75, 54, 154, 100),
                                    ),
                                  ),
                                  new Container(
                                    child: new Text('Mis Citas'),
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
                                            'assets/recetas.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  new Container(
                                    child: new Text('Recetas'),
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
                                            'assets/carrito.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(240, 126, 26,100),
                                    ),
                                  ),
                                  new Container(
                                    child: new Text('Pagos'),
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
  class AppMenu extends StatelessWidget{
    final String nombre;

    const AppMenu(this.nombre);

    @override
    Widget build(BuildContext context){
      return DecoratedBox(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(nombre),
        ),
      );
  }
}
