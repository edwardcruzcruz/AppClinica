import 'package:flutter_app/screens/HomePage/Home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Login(),
    );
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  var logo = Container(
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

  var margen_btn = Container(
    margin: EdgeInsets.symmetric(vertical: 30,horizontal: 0),
  );

  // These functions can self contain any user auth logic required, they all have access to _email and _password
  /*
  void _loginPressed () {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_email and $_password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }*/


  AnimationController controller;
  Animation<double> animation;

  GlobalKey<FormState> _key = GlobalKey();

  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');
  String _correo;
  String _contrasena;
  String mensaje = '';

  bool _logueado = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logueado ? Home(mensaje: mensaje) : loginForm(),
//      body: loginForm(),
    );
  }

  Widget loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo,//clinica dental logo
          ],
        ),
        Container(
          width: 300.0, //size.width * .6,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(

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
                    labelText: 'Correo',
                    counterText: '',
                    fillColor: Colors.greenAccent,
                    filled: true,
                  ),
                  onSaved: (text) => _correo = text,
                ),
                TextFormField(
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
                  decoration: InputDecoration(
                    hintText: 'Ingrese su Contraseña',
                    labelText: 'Contraseña',
                    counterText: '',
                    fillColor: Colors.greenAccent,
                    filled: true,
                    suffixIcon: Icon(Icons.remove_red_eye, size: 32.0, color: Colors.blue[800]),
                  ),
                  onSaved: (text) => _contrasena = text,
                ),
                new FlatButton(
                  child: new Text('¿Olvidaste tu contraseña?'),
                  //onPressed: _passwordReset,
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.greenAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        //Aqui se llamaria a su API para hacer el login
                        setState(() {
                          _logueado = true;
                        });
                        mensaje = 'Gracias \n $_correo \n $_contrasena';
//                      Una forma correcta de llamar a otra pantalla
//                      Navigator.of(context).push(HomeScreen.route(mensaje));
                      }
                    },
                    child: Text('Iniciar Sesion'),
                  ),
                  //onPressed: _loginPressed,
                ),

                IconButton(
                  /*onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      //Aqui se llamaria a su API para hacer el login
                      setState(() {
                        _logueado = true;
                      });
                      mensaje = 'Gracias \n $_correo \n $_contrasena';
//                      Una forma correcta de llamar a otra pantalla
//                      Navigator.of(context).push(HomeScreen.route(mensaje));
                    }
                  },*/
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                ),
                new FlatButton(
                  child: new Text('¿No tienes cuenta? Registrate ahora.'),
                  //onPressed: _formChange,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

