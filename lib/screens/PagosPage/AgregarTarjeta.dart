import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgregarTarjeta extends StatefulWidget{
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => AgregarTarjeta(),
    );
  }
  @override
  _AgregarTarjetaState createState() => _AgregarTarjetaState();

}

class _AgregarTarjetaState extends State<AgregarTarjeta>{
  //Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos')
      ),
      body: //Text("Hola")
      WebView(
        initialUrl:'https://test.placetopay.ec/redirection/session/130372/51b580bdff7728fe08a3496a4b5276d7',
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

}

