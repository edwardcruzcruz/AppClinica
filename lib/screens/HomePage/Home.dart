import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Home(),
    );
  }

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
        /*actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navegacion',
            color: Colors.white,
            onPressed: () =>
                ListTile(
                ),
          ),
        ],*/
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Edward'),//consultas api con modelos
              accountEmail: Text('xfaff@hotmail.com'),
              currentAccountPicture:
              Image.network('https://hammad-tariq.com/img/profile.png'),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Drawer layout Item 1'),
              onTap: () {
                // This line code will close drawer programatically....
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text('Drawer layout Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Drawer layout Item 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Logout"),
                onTap: (){
                  Navigator.pop(context);
                }/* async {
                // hapus shared prefs login
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('login');
                // redirect page/route ke login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }*/,
            ),
          ],
        ),
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
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
