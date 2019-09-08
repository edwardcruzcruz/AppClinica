import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_app/services/Shared_Preferences.dart';


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
            'assets/splash.jpg'),
        fit: BoxFit.fill,
      ),
      shape: BoxShape.circle,
    ),
  );
}
class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  var storageService = locator<Var_shared>();
  AnimationController controller;
  Animation<double> animation;

  GlobalKey<FormState> _key = GlobalKey();
  //var loc=locator<Shared_Preferences>();


  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  String _correo='';
  String _contrasena='';

  bool _obscureText = true;//contraseñaOculta

  initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    //    Descomentar las siguientes lineas para generar un efecto de "respiracion"
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse();
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });

    controller.forward();
  }

  dispose() {
    // Es importante SIEMPRE realizar el dispose del controller.
    controller.dispose();
    super.dispose();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,//Quitar el mensaje de exceso de pixeles
      body: loginForm(),
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su Correo',
                      hintStyle: new TextStyle(color: Colors.white),
                      labelStyle: new TextStyle(color: Colors.white),
                      labelText: 'Correo',
                      counterText: '',
                      fillColor: Color.fromRGBO(19, 206, 177, 100),
                      filled: true,
                    ),
                    onSaved: (text) {
                      //print('saved');
                      _correo = text;
                    }
                  ),
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
                    keyboardType: TextInputType.text,
                    maxLength: 20,
                    textAlign: TextAlign.center,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su Contraseña',
                      labelText: 'Contraseña',
                      hintStyle: new TextStyle(color: Colors.white),
                      labelStyle: new TextStyle(color: Colors.white),
                      counterText: '',
                      fillColor: Color.fromRGBO(19, 206, 177, 100),
                      filled: true  ,
                      suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye,size: 32.0,
                          color: Colors.black),
                                      onPressed: _toggle,
                                      ),
                    ),
                    onSaved: (text) => _contrasena = text,
                  ),
                ),
                new FlatButton(
                  child: new Text('¿Olvidaste tu contraseña?'),
                  onPressed:  null,//_passwordReset,
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    color: Color.fromRGBO(19, 206,148, 100),
                    textColor: Colors.white,
                    onPressed: ()async{
                      //print(storageService.getuser);
                      print('Correo: edward@hotmail.com  Contraseña: edwardcruz123');
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        //Aqui se llamaria a su API para hacer el login
                        if(_correo.compareTo("edward@hotmail.com")==0 &&_contrasena.compareTo("edwardcruz123")==0){
                          storageService.save_user(_correo);
                          //print(storageService.getuser);
                          Navigator.of(context).pushReplacement(Home.route());
                        }else{
                          print("Correo o contraseña incorrecta");//programar spam
                        }
                      //
                      }
                    },
                    child: Text('Iniciar Sesion'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Image.asset("assets/facebook.png"),
                        onPressed: null,//(){},
                      ),
                      RaisedButton(
                        child: Image.asset("assets/twitter.png"),
                        onPressed: null,//() {},
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
            child: new FlatButton(
              child: new Text('¿No tienes cuenta? Registrate ahora.'),
              onPressed: null,//_formChange,
            ),
          ),
        ),
      ],
    );
  }
}

