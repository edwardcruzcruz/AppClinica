import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginPage/Component/Body.dart';
import 'package:flutter_app/screens/RegistroPage/Registro.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/theme/Strings.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
    margin: const EdgeInsets.only(top: 30.0,bottom: 10.0),
    width: 150.0,
    height: 150.0,
    decoration: new BoxDecoration(
      image: DecorationImage(
        image: new AssetImage(
            'assets/logo_login.jpg'),
        fit: BoxFit.fill,
      ),
      //shape: BoxShape.circle,
    ),
  );
}
BoxDecoration underlineTextField() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide( //                   <--- left side
        color: appTheme().buttonColor,
        width: 1.0,
      ),
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
      ),
    );

  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _logo(),//primer widget del logo login
        Container(
          width: 300.0, //size.width * .6,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
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
                    decoration: InputDecoration(
                      hintText: Strings.HintEmail,
                      hintStyle: appTheme().textTheme.title,
                      labelStyle: appTheme().textTheme.title,
                      labelText: Strings.LabelEmail,
                      counterText: '',
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                  ),
                  decoration: underlineTextField(),
                ),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0,bottom: 10.0),
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
                      hintText: Strings.HintPassword,
                      labelText: Strings.LabelPassword,
                      hintStyle: appTheme().textTheme.title,
                      labelStyle: appTheme().textTheme.title,
                      counterText: '',
                      fillColor: Colors.transparent,
                      filled: true  ,
                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye,size: 32.0,
                        color: appTheme().hintColor),
                           onPressed: _toggle,
                        ),
                    ),
                  ),
                  decoration: underlineTextField(),
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
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        child: Image.asset("assets/login_facebook.png"),
                        onPressed: (){
                          initiateFacebookLogin();
                        },
                      ),
                      /*FlatButton(
                        child: Image.asset("assets/twitter.png"),
                        onPressed: null,//() {},
                      ),*/
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60.0),
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
            ),
          ),
        ),
        Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              child: FlatButton(
                textColor: Colors.white,
                onPressed: ()async{
                  setState(() {//se muestra barra circular de espera
                    _saving = true;
                  });
                  if (_key.currentState.validate()) {
                    var response = await RestDatasource().postLogin(emailController.text,passController.text);
                    _key.currentState.save();
                    if(response.statusCode==200){
                      setState(() {//se oculta barra circular de espera
                        _saving = false;
                      });
                      //print(_key.currentState.validate());
                      String token=response.body;
                      storageService.save_email(emailController.text);
                      storageService.save_user(token);
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
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        facebookLoginResult.toString();
        onLoginStatusChanged(true);
        break;
    }
  }
  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      if(isLoggedIn==true){
        print('hola');
      }
    });
  }
}

