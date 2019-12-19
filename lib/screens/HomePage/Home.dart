import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/models/CitaCompleta.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/Tratamiento.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/MenuPage/Acerca.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/CuentasAsociadas.dart';
import 'package:flutter_app/screens/MenuPage/Historial.dart';
import 'package:flutter_app/screens/MenuPage/Mis_Citas.dart';
import 'package:flutter_app/screens/MenuPage/Mis_Pagos.dart';
import 'package:flutter_app/screens/MenuPage/Noticias.dart';
import 'package:flutter_app/screens/MenuPage/Recetas.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/screens/MenuPage/Sugerencia.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter_app/models/RedSocial.dart';
import 'package:flutter_app/models/Receta.dart';
import 'package:flutter_app/models/HorarioCompleto.dart';
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  openTheDrawer(){
    _scaffoldKey.currentState.openEndDrawer();
  }
  var storageService = locator<Var_shared>();
  bool _saving = false; //to circular progress bar
  int currentTab = 0; //bottom Navigation menu bar choice


  Noticias noticiaPage;
  Citas citasPage;
  Historial historialPage;
  Recetas recetasPage;
  Agendamiento agend1Page;
  Pagos carrito;  
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    List<CitaCompleta> citas= new List<CitaCompleta>();//.generate(5, (i) => CitaCompleta(
        //i,User(1,"Edward", "Cruz","edward.cruzcruz@hotmail.com",1,"0938384849","Ronda","1996-04-27"), "Odontología","Limpieza Dental",HorarioCompleto(1,"2019-"+((8+(1*i)).toString().length==1?"0"+(8+(1*i)).toString():8+(1*i)).toString()+"-12",HorarioRango(3,"09:00","09:30"),12,false),Doctor(12,"Jose", "Ureta","2789456",1,"jos@gmail.com",3)
    //));
    List<Receta> recetas= new List<Receta>();//.generate(5, (i) => Receta(
    //i,"Receta $i",CitaCompleta(i,User(1,"Edward", "Cruz","edward.cruzcruz@hotmail.com",1,"0938384849","Ronda","1996-04-27"),Tratamiento(1,) "Odontología","Limpieza Dental",HorarioCompleto(1,"2019-"+((8+(1*i)).toString().length==1?"0"+(8+(1*i)).toString():8+(1*i)).toString()+"-12",HorarioRango(3,"09:00","09:30"),12,false),Doctor(12,"Jose", "Ureta","2789456",1,"jos@gmail.com",3))
    //)
    //);
    noticiaPage = Noticias();
    citasPage = Citas(callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull);
    historialPage = Historial(citasList: citas,callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull);
    recetasPage = Recetas(callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull);
    agend1Page = Agendamiento();
    carrito = Pagos();
    pages = [
      noticiaPage,
      citasPage,
      historialPage,
      recetasPage,
      agend1Page
    ]; //,pagosPage
    currentPage = noticiaPage;
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  void callbackloading() {
    setState(() {
      this._saving = true;
    });
  }

  void callbackfull() {
    setState(() {
      this._saving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: Icon(Icons.note_add),
          onPressed: storageService.getIdHijo==null?() async {
            setState(() {
              //se muestra barra circular de espera
              _saving = true;
            });
            List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad();

            User usuario= await RestDatasource().perfil(storageService.getEmail) ;
            setState(() {//se oculta barra circular de espera
              _saving = false;
            });

              currentPage=Agendamiento(
                usuario: usuario,
                especialidades: especialidades,
                callback: this.callback,
                callbackloading: this.callbackloading,
                callbackfull: this.callbackfull,);//cambiar a 5 cuando se agregue pgos, etc
          }:(){
            this._showDialogWorking();
          },
        ),
        title: new Image.asset(
          'assets/logo_white.png',
          fit: BoxFit.cover,
          alignment: Alignment(0, -1),
          width: 150,
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.shopping_cart), // Icon(Icons.note_add),
            onPressed: storageService.getIdHijo==null?() async {
              /*setState(() {//se muestra barra circular de espera
                _saving = true;
              });
              List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad() ;
              setState(() {//se oculta barra circular de espera
                _saving = false;
              });*/

              setState(() {
                //currentTab=4;
                currentPage =
                    //AgregarTarjeta();
                    Pagos();
              });
            }:(){
              this._showDialogWorking();
            },
          ),
          new IconButton(
            icon: Icon(Icons.menu), // Icon(Icons.note_add),
            onPressed: () =>openTheDrawer(),
          ),
        ],
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
              //margin: EdgeInsets.only(top: 10),
                color: Colors.transparent,
                //padding: EdgeInsets.all(8.0),
                child: new Divider(
                  height: 2,
                    color: Colors.white, indent: 50.0, endIndent: 50.0)
                //padding: const EdgeInsets.all(5.0),
                ),
            preferredSize: const Size.fromHeight(10.0)),
      ),
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child:new Column(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
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
              child: Row(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    child: DrawerHeader(
                      child: new CircleAvatar(
                        child: Image.asset("assets/avatar.png"),
                      ),
                    ),
                  ),
                  Text(storageService.getCuentaMaster,style: appTheme().textTheme.display2,)
                ],
              ),
            ),
            Container(
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
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
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
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.people,color: Colors.white,),
                      title: Text('Cuentas Asociadas',style: appTheme().textTheme.button,),
                      onTap: () async{//
                        setState(() {
                          //se muestra barra circular de espera
                          _saving = true;
                        });
                        /*List<Cuenta> cuentas= new List<Cuenta>.generate(1, (i) {
                  return Cuenta(
                      1,"Jose", "Cruz","jose@gmail.com","Masculino","0993449512","Ronda","2000-04-10",2
                  );
                });*/
                        Cuenta cuentas=await RestDatasource().CuentasByMaster(int.parse(storageService.getIdCuentaMaster.toString()));
                        //User usuario= await RestDatasource().perfil(storageService.getEmail) ;
                        setState(() {//se oculta barra circular de espera
                          _saving = false;
                        });
                        setState(() {
                          currentPage = CuentasAsociadas(cuentas: cuentas,callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull,);
                        });

                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      height: 2.0,
                      color: Colors.transparent,
                    ),
                    ListTile(
                      leading: Icon(Icons.question_answer,color: Colors.white,),
                      title: Text('Sugerencia',style: appTheme().textTheme.button,),
                      onTap: () {
                        setState(() {
                          currentPage = Sugerencia(callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull);
                        });
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      height: 2.0,
                      color: Colors.transparent,
                    ),
                    ListTile(
                      leading: Icon(Icons.info,color: Colors.white,),
                      title: Text('Sobre Nosotros',style: appTheme().textTheme.button,),
                      onTap: () async{//
                        setState(() {
                          //se muestra barra circular de espera
                          _saving = true;
                        });
                        /*List<Cuenta> cuentas= new List<Cuenta>.generate(1, (i) {
                  return Cuenta(
                      1,"Jose", "Cruz","jose@gmail.com","Masculino","0993449512","Ronda","2000-04-10",2
                  );
                });*/
                        List<Clinica> info=await RestDatasource().InfoClinica();
                        //User usuario= await RestDatasource().perfil(storageService.getEmail) ;
                        setState(() {//se oculta barra circular de espera
                          _saving = false;
                        });
                        /*List<RedSocial> redes= new List<RedSocial>();
                redes.add(new RedSocial(0,"Facebook", "https://www.facebook.com/cliesdentsa/"));
                redes.add(new RedSocial(1,"Instagram", "https://www.instagram.com/clinica.estetica.dental/?hl=es-la"));
                Clinica clinicainfo=new Clinica(0,"Clinica Estetica Dental","Somos una clinica que piensa en tu salud dental","0995104749","Alborada 5 etapa (9,77 km)","info@clinicaesteticadental.com",redes);*/
                        setState(() {
                          currentPage = Acerca(clinica: info.elementAt(0),callback: this.callback,callbackloading: this.callbackloading,callbackfull: this.callbackfull);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
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
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Container(
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
              child: ListTile(
                leading: Icon(Icons.exit_to_app,color: Colors.white,),
                title: Text("Cerrar Sesión",style: appTheme().textTheme.button,),
                onTap: () {
                  if(storageService.IsFacebookUser!=null){
                    if(storageService.IsFacebookUser){
                      FacebookLogin().logOut();
                      storageService.delete_userface();
                    }
                  }
                  storageService.delete_user(); //variable de session usuario eliminada
                  storageService.delete_email();
                  storageService.delete_idPadre();
                  storageService.delete_idHijo();
                  storageService.delete_currentAccount();
                  Navigator.of(context).pushAndRemoveUntil(
                      Login.route(), (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
          color: Colors.grey[600],
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          inAsyncCall: _saving,
          child: currentPage),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (int index) {
            storageService.getIdHijo==null?
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            }):this._showDialogWorking();
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: currentTab == 0
                  ? new Image.asset(
                      'assets/home_activo.png',
                      width: 32,
                      height: 28,
                    )
                  : new Image.asset(
                      'assets/home.png',
                      width: 32,
                      height: 28,
                    ), //new
              title: currentTab == 0
                  ? new Text(
                      Strings.ItemBottomNavigationBar0,
                      style: appTheme().textTheme.subtitle,
                    )
                  : new Text(
                      Strings.ItemBottomNavigationBar0,
                      style: appTheme().textTheme.title,
                    ),
            ),
            BottomNavigationBarItem(
              icon: currentTab == 1
                  ? new Image.asset(
                      'assets/mis_citas_activo.png',
                      width: 32,
                      height: 28,
                    )
                  : new Image.asset(
                      'assets/mis_citas.png',
                      width: 32,
                      height: 28,
                    ),
              title: currentTab == 1
                  ? new Text(
                      Strings.ItemBottomNavigationBar1,
                      style: appTheme().textTheme.subtitle,
                    )
                  : new Text(
                      Strings.ItemBottomNavigationBar1,
                      style: appTheme().textTheme.title,
                    ),
            ),
            BottomNavigationBarItem(
              icon: currentTab == 2
                  ? new Image.asset(
                      'assets/historial_clinico_activo.png',
                      width: 32,
                      height: 28,
                    )
                  : new Image.asset(
                      'assets/historial_clinico.png',
                      width: 32,
                      height: 28,
                    ),
              title: currentTab == 2
                  ? new AutoSizeText(
                      Strings.ItemBottomNavigationBar2,
                      style: appTheme().textTheme.subtitle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )
                  : new AutoSizeText(
                      Strings.ItemBottomNavigationBar2,
                      style: appTheme().textTheme.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
            ),
            BottomNavigationBarItem(
              icon: currentTab == 3
                  ? new Image.asset(
                      'assets/recetas_activo.png',
                      width: 32,
                      height: 28,
                    )
                  : new Image.asset(
                      'assets/recetas.png',
                      width: 32,
                      height: 28,
                    ),
              title: currentTab == 3
                  ? new Text(
                      Strings.ItemBottomNavigationBar3,
                      style: appTheme().textTheme.subtitle,
                    )
                  : new Text(
                      Strings.ItemBottomNavigationBar3,
                      style: appTheme().textTheme.title,
                    ),
            ),
          ]),
    );
  }

  void _showDialogWorking() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Trabajando...."),
          content: new Text("Esta funcionalidad aun esta en trabajo"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                //Navigator.of(context).pushAndRemoveUntil(Home.route(), (Route<dynamic> route)=>false);
              },
            ),
          ],
        );
      },
    );
  }
}
