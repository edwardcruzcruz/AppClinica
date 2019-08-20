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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppMenu("Agendamiento de Citas"),
            SizedBox(height: 10,),
            AppMenu("Historial de Citas"),
            SizedBox(height: 10,),
            AppMenu("Pagos"),
          ],
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
