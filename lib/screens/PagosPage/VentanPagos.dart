
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Constantes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VentanaPagos extends StatefulWidget{

  Function callback,callbackloading,callbackfull;
  String email,cel;
  int usuario;
  double total;
  VentanaPagos({Key key,this.callback,this.callbackloading,this.callbackfull,this.email,this.cel,this.usuario,this.total}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => VentanaPagos(),
    );
  }
  @override
  _VentanaPagosState createState() => _VentanaPagosState();

}

class _VentanaPagosState extends State<VentanaPagos>{
  //Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("------------------------------------------------------------");
    var urlFinal=Constantes.serverdomain+Constantes.pago+this.widget.usuario.toString()+"/"+this.widget.email+"/"+this.widget.cel+"/"+this.widget.total.toString()+"/";
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(urlFinal);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
        backgroundColor: Color(0xFF00d6bc),
      ),
      backgroundColor: Color(0xFF00d6bc),
      drawerScrimColor: Color(0xFF00d6bc),

      body: //Text("Hola")
      WebView(
        initialUrl:urlFinal,

        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          //_controller.complete(webViewController);
          _controller=webViewController;
        },
        /*javascriptChannels: Set.from([
          JavascriptChannel(
              name: 'Print',
              *//*onMessageReceived: (JavascriptMessage message) {
                //This is where you receive message from
                //javascript code and handle in Flutter/Dart
                //like here, the message is just being printed
                //in Run/LogCat window of android studio
                print("exit:");
                print(message.message);
              })*//*
        ]),*/
      ),
    );
  }

  _launchURL() async {
    var url = Constantes.serverdomain+Constantes.pago+this.widget.usuario.toString()+"/"+this.widget.email+"/"+this.widget.cel+"/"+this.widget.total.toString()+"/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}