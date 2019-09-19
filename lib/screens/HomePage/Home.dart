import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/services/Rest_Services.dart';

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
  var storageService = locator<Var_shared>();

  @override
  Widget build(BuildContext context) {
    //User usuario=User.fromJson(RestDatasource().login());
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset('assets/logo_clinica.png', fit: BoxFit.cover,),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(19, 206, 177, 100),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("edward"),//consultas api con modelos
              accountEmail: Text("edward@gmail.com"),
              currentAccountPicture:
              Image.network('https://thechanmakerrecipe.files.wordpress.com/2014/10/ec-only-logo-copy.png?w=243'),
              decoration: BoxDecoration(color: Color.fromRGBO(19, 206, 177, 100)),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Cuentas Asociadas'),
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
              title: Text('Sugerencia'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de Nosotros'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 2.0,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Cerrar Sesión"),
                  onTap: (){
                    storageService.delete_user();//variable de session usuario eliminada
                    storageService.delete_email();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                )
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Banner(
          message: "",//mensaje esquina superior derecha
            location: BannerLocation.topEnd,
            color: Colors.red,
            child: Container(
              margin: const EdgeInsets.only(left:0.0,top:5.0,right: 0.0,bottom: 0.0),
              color: Colors.blue,
              height: 100,
              child: Center(child: new Image.asset('assets/promocion.jpg', fit: BoxFit.fill,),),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
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
                                  GestureDetector(
                                    onTap: ()async{
                                      User usuario = await RestDatasource().perfil(storageService.getEmail);
                                      print(usuario.Nombre);

                                      Navigator.of(context).push(Agendamiento.route());
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                      width: 130.0,
                                      height: 130.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/agendamiento.png'),
                                          fit: BoxFit.none,
                                        ),
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(204,192, 2,100),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Agendar Cita'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/calendario.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(75, 54, 154, 100),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Mis Citas'),
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
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/historial.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Colors.cyan,
                                    ),
                                  ),
                                  Container(
                                    child: Text('Historial Clinico'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
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
                                  Container(
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
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/resultados.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(22, 48, 207, 100),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Mis Resultados'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/carrito.png'),
                                        fit: BoxFit.none,
                                      ),
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(240, 126, 26,100),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Pagos'),
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
