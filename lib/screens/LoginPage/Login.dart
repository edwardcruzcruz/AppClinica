import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/models/UserFB.dart';
import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/RegistroPage/Registro.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class Login extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Login(),
    );
  }

  @override
  _LoginState createState() => _LoginState();
}
Widget _logo(){
  return Container(
    margin: const EdgeInsets.only(top: 100.0),
    width: 220.0,
    height: 100.0,
    decoration: new BoxDecoration(
      image: DecorationImage(
        image: new AssetImage(
            'assets/logoclinica.png'),
        fit: BoxFit.fill,
      ),
      //shape: BoxShape.circle,
    ),
  );
}
class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  bool _saving = false;//to circular progress bar
  var storageService = locator<Var_shared>();

  GlobalKey<FormState> _key = GlobalKey();
  //var loc=locator<Shared_Preferences>();


  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  bool _obscureText = true;//contraseñaOculta

  static const EdgeInsets _padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0);//para subrayado

  initState() {
    super.initState();
  }

  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    super.dispose();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,//Quitar el mensaje de exceso de pixeles
        body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: loginForm()),
        bottomNavigationBar: BottomAppBar(
          child:  Container(
            width: double.infinity,
            child: FlatButton(
              onPressed: ()async{
                if (_key.currentState.validate()) {
                  setState(() {//se muestra barra circular de espera
                    _saving = true;
                  });
                  var response = await RestDatasource().postLogin(emailController.text,passController.text);
                  _key.currentState.save();
                  if(response.statusCode==200){
                    String token=response.body;
                    storageService.save_email(emailController.text);
                    storageService.save_user(token);
                    User usuario= await RestDatasource().perfil(storageService.getEmail) ;
                    storageService.save_idPadre(usuario.Id);//guardamos de manera general el id padre
                    storageService.save_idPadreMaster(usuario.Id);//guardamos de manera general el id padre
                    storageService.save_currentAccount(usuario.Apellido+" "+usuario.Nombre);
                    storageService.save_MasterAccount(usuario.Apellido+" "+usuario.Nombre);
                    setState(() {//se oculta barra circular de espera
                      _saving = false;
                    });
                    //print(_key.currentState.validate());
                    print(storageService.getuser);
                    Navigator.of(context).pushReplacement(Home.route());
                  }else{
                    setState(() {//se oculta barra circular de espera
                      _saving = false;
                    });
                    _showDialogLogin();
                  }
                  //
                }
              },
              child: Text(Strings.ButtonLogin,style: appTheme().textTheme.button,),
            ),
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
        ),
      ),
    );

  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _logo(),//primer widget del logo login
        new Expanded(
          child: ListView(
            children: <Widget>[
              Container(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(40,0,40,0),
                        child: TextFormField(

                          validator: (text) {
                            if (text.length == 0) {
                              return "Este campo correo es requerido";
                            } else if (!emailRegExp.hasMatch(text)) {
                              return "El formato para correo no es correcto";
                            }
                            return null;
                          },
                          controller:emailController,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 50,
                          textAlign: TextAlign.center,
                          /*decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: appTheme().buttonColor,
                                    width: 1.0),
                              ),
                              labelText: Strings.LabelRegistroNombre,
                              errorStyle: appTheme().textTheme.overline,
                              labelStyle: appTheme().textTheme.title,
                            ),*/
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent,//
                                  width: 1.0),
                            ),
                            hintText: Strings.HintEmail,
                            hintStyle: appTheme().textTheme.title,
                            labelStyle: appTheme().textTheme.title,
                            labelText: Strings.LabelEmail,
                            counterText: '',
                            errorStyle: appTheme().textTheme.overline,
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 40,right: 40,bottom: 10),
                          child: Container(
                            height: 1.0,
                            color: Colors.teal,
                            child: Divider(
                              color: Colors.teal,
                            ),
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(40,0,40,0),
                        child: TextFormField(
                          validator: (text) {
                            if (text.length == 0) {
                              return "Este campo contraseña es requerido";
                            } else if (text.length <= 5) {
                              return "Su contraseña debe ser al menos de 5 caracteres";
                            } else if (!contRegExp.hasMatch(text)) {
                              return "El formato para contraseña no es correcto";
                            }
                            return null;
                          },
                          controller: passController,
                          keyboardType: TextInputType.text,
                          maxLength: 20,
                          textAlign: TextAlign.center,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent,
                                  width: 1.0),
                            ),
                            hintText: Strings.HintPassword,
                            labelText: Strings.LabelPassword,
                            hintStyle: appTheme().textTheme.title,
                            labelStyle: appTheme().textTheme.title,
                            errorStyle: appTheme().textTheme.overline,
                            counterText: '',
                            fillColor: Colors.transparent,
                            filled: true  ,
                            suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye,size: 22.0,
                                color: appTheme().hintColor),
                              onPressed: _toggle,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 40,right: 40,bottom: 5),
                          child: Container(
                            height: 1.0,
                            color: Colors.teal,
                            child: Divider(
                              color: Colors.teal,
                            ),
                          )
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              child: new Text(Strings.OlvidastePassword,style: appTheme().textTheme.body1,),
                              onPressed:  null,//_passwordReset,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Ingresar con",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,fontFamily: 'Myriad Pro',color: Color(0xFF87868a)),),
                                FlatButton(
                                  child: Image.asset("assets/facebook.png"),
                                  onPressed: (){
                                    initiateFacebookLogin();
                                  },
                                ),
                              ],
                            ),
                            /*FlatButton(
                        child: Image.asset("assets/twitter.png"),
                        onPressed: null,//() {},
                      ),*/
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )
        ),
        Container(
          //margin: const EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                child: new Text(Strings.Registrate,style: appTheme().textTheme.body2,),
                onPressed: (){
                  Navigator.of(context).pushReplacement(Registro.route());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  void _showDialogLogin() {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Usuario o Contraseña Incorrectos"),
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

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);
    //print('hola');
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false,facebookLoginResult.status);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false,facebookLoginResult.status);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        //facebookLoginResult.toString();

        final token=facebookLoginResult.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        //var response = await RestDatasource().postLoginFB(token);
        _key.currentState.save();
        //if(response.statusCode==200){
          //String token=response.body;
          storageService.save_user('{\"token\":\"ed6b300aaed57d62531efedadd8c62b379d9aa56\"}');//token
          storageService.save_email(profile['email']);



          storageService.save_currentAccount(profile['name']);
          storageService.save_MasterAccount(profile['name']);
          User usuario= await RestDatasource().perfilfb(profile['email']);
          if(usuario==null){
            dynamic response=await RestDatasource().save_userfb(profile['first_name'],profile['last_name'],"","","1996-10-10","1","",profile['email'],"");

            print(response.statusCode);
            print(response.body);
            if(response.statusCode==200 ||response.statusCode==201){
              UserFB acc=UserFB.fromJson(JSON.jsonDecode(response.body));
              storageService.save_idPadre(acc.Id);//guardar cuando se cree la funcion de guardar cliente sin token pero verlo ojo
              storageService.save_idPadreMaster(acc.Id);
            }
          }else{
            storageService.save_idPadre(usuario.Id);
            storageService.save_idPadreMaster(usuario.Id);
          }
          storageService.save_isuserFace(true);
          Navigator.of(context).pushReplacement(Home.route());
          onLoginStatusChanged(true,facebookLoginResult.status);
        //}else{
          //_showDialogLogin();
        //}
        break;
    }
  }
  void onLoginStatusChanged(bool isLoggedIn,var result){
    setState(() {
      if(isLoggedIn==true){
        print('hola');
      }
    });
  }
}

