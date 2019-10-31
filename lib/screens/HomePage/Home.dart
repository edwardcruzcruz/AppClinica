import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Historial.dart';
import 'package:flutter_app/screens/MenuPage/Mis_Citas.dart';
import 'package:flutter_app/screens/MenuPage/Mis_Pagos.dart';
import 'package:flutter_app/screens/MenuPage/Noticias.dart';
import 'package:flutter_app/screens/MenuPage/Recetas.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_app/screens/LoginPage/Login.dart';
import 'package:flutter_app/screens/MenuPage/Agendamiento/Agendamiento1.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/services/Rest_Services.dart';
//import 'package:flutter_app/services/Rest_Services.dart';

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
  bool _saving = false;//to circular progress bar
  int currentTab=0;//bottom Navigation menu bar choice

  Noticias noticiaPage;
  Citas citasPage;
  Historial historialPage;
  //Pagos pagosPage;
  Recetas recetasPage;
  Agendamiento agend1Page;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState
    noticiaPage= Noticias();
    citasPage= Citas();
    historialPage= Historial();
    //pagosPage= Pagos();
    recetasPage=Recetas();
    agend1Page= Agendamiento();
    pages=[noticiaPage,citasPage,historialPage,recetasPage,agend1Page];//,pagosPage
    currentPage = noticiaPage;
    super.initState();
  }

  void callback(Widget nextPage){
    setState(() {
      this.currentPage=nextPage;
    });
  }
  void callbackloading(){
    setState(() {
      this._saving=true;
    });
  }
  void callbackfull(){
    setState(() {
      this._saving=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.note_add),
          onPressed: () async{
            setState(() {//se muestra barra circular de espera
              _saving = true;
            });
            List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad() ;
            User usuario= await RestDatasource().perfil(storageService.getEmail) ;
            //print(usuario);
            setState(() {//se oculta barra circular de espera
              _saving = false;
            });

            setState((){
              //currentTab=4;
              currentPage=Agendamiento(usuario: usuario,especialidades: especialidades,callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull,);//cambiar a 5 cuando se agregue pgos, etc
            });

          },
        ),
        title: new Image.asset('assets/logo_white.png',fit: BoxFit.cover,),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Color(0xFF00a18d),
                Color(0xFF00d6bc),
              ],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
            ),
          ),
        ),
        bottom: new PreferredSize(
            child: new Container(
                color: Colors.transparent,
                  //padding: EdgeInsets.all(8.0),
                  child: new Divider(color: Colors.white,indent: 50.0, endIndent: 50.0)
              //padding: const EdgeInsets.all(5.0),
            ),
            preferredSize: const Size.fromHeight(10.0)),
      ),
      endDrawer: Drawer (
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader (
              accountName: Text(""),//consultas api con modelos
              accountEmail: Text(storageService.getEmail),
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
                    Navigator.of(context).pushAndRemoveUntil(Login.route(), (Route<dynamic> route)=>false);
                  },
                )
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: currentPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index){
          setState((){
            currentTab=index;
            currentPage=pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: currentTab==0?new Image.asset('assets/home_activo.png',width: 32,height: 28,):new Image.asset('assets/home.png',width: 32,height: 28,),//new
          title: currentTab==0?new Text(Strings.ItemBottomNavigationBar0,style: appTheme().textTheme.subtitle,):new Text(Strings.ItemBottomNavigationBar0,style: appTheme().textTheme.title,),
        ),
        BottomNavigationBarItem(
          icon: currentTab==1?new Image.asset('assets/mis_citas_activo.png',width: 32,height: 28,):new Image.asset('assets/mis_citas.png',width: 32,height: 28,),
          title: currentTab==1?new Text(Strings.ItemBottomNavigationBar1,style: appTheme().textTheme.subtitle,):new Text(Strings.ItemBottomNavigationBar1,style: appTheme().textTheme.title,),
        ),
        BottomNavigationBarItem(
          icon: currentTab==2?new Image.asset('assets/historial_clinico_activo.png',width: 32,height: 28,):new Image.asset('assets/historial_clinico.png',width: 32,height: 28,),
          title: currentTab==2?new AutoSizeText(Strings.ItemBottomNavigationBar2,style: appTheme().textTheme.subtitle,maxLines: 2,textAlign: TextAlign.center,):new AutoSizeText(Strings.ItemBottomNavigationBar2,style: appTheme().textTheme.title,maxLines: 2,textAlign: TextAlign.center,),
        ),
        BottomNavigationBarItem(
          icon: currentTab==3?new Image.asset('assets/recetas_activo.png',width: 32,height: 28,):new Image.asset('assets/recetas.png',width: 32,height: 28,),
          title: currentTab==3?new Text(Strings.ItemBottomNavigationBar3,style: appTheme().textTheme.subtitle,):new Text(Strings.ItemBottomNavigationBar3,style: appTheme().textTheme.title,),
        ),
        ]
      ),
    );
  }

}
