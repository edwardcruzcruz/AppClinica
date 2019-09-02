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
        title: Text("Inicio"),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //FloatingActionButton(
                  //  backgroundColor: Colors.redAccent,
                  //  onPressed: () => {},
                  //),
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  Text('PREP:'),
                  //Text('25 min'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('COOK:'),
                  //Text('1 hr'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.restaurant, color: Colors.green[500]),
                  Text('FEEDS:'),
                  //Text('4-6'),
                ],
              ),
            ],
          ),
        ),
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
