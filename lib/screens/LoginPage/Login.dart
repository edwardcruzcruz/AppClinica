import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginPage/Component/Body.dart';
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
class _LoginState extends State<Login>{

  bool _saving = false;//to circular progress bar

  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: appTheme(),
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,//Quitar el mensaje de exceso de pixeles
        body: ModalProgressHUD(color: Colors.grey[600],progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),inAsyncCall: _saving, child: Container( child:Center(child: LoginPage(),))),//loginForm()
      ),
    );

  }
}
