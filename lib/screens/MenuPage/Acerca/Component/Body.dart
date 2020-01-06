import 'dart:math';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaPage extends StatefulWidget {
  AcercaPage({Key key})
      : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => AcercaPage(),
    );
  }
  @override
  _AcercaPageState createState() => _AcercaPageState();
}

class _AcercaPageState extends State<AcercaPage> {
  ScrollController _controller;
  double backgroundHeight = 180.0;
  Future<List<Clinica>> future;
  @override
  void initState() {
    super.initState();
    future = RestDatasource().InfoClinica();

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        backgroundHeight = max(0, 180.0 - _controller.offset);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
  Widget _body() {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Clinica>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text(
                "No hay información para mostrar",
                textAlign: TextAlign.center,
                style: appTheme().textTheme.display4,
              ); //'Error: ${snapshot.error}'

            return snapshot.data.length > 0
              ? Column(
                children: <Widget>[
                  RedesSociales(snapshot.data.elementAt(0)),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  ),
                  snapshot.data.elementAt(0)==null?Center(child: Text("Sin contenido que mostrar",textAlign: TextAlign.center,style: appTheme().textTheme.subhead,),):Expanded(child: informacionClinica(snapshot.data.elementAt(0)),)
                ],
              )
                : Text(
              "No hay información nueva",
              textAlign: TextAlign.center,
              style: appTheme().textTheme.display4,
            );
        }
        return null;
      },
    );
  }
  Widget RedesSociales(Clinica clinica){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: clinica.redes.map((item) => new IconButton(
          icon: Icon(item.GetNombre=="Facebook"?FontAwesomeIcons.facebookF:item.GetNombre=="Twitter"?FontAwesomeIcons.twitter:FontAwesomeIcons.instagram, size: 30,color: Colors.teal,), // Icon(Icons.note_add),
          onPressed: () {
            var url=item.GetLink;
            launch(url);
          },//_launchURL(this.widget.clinica.redes.elementAt(index).GetLink),
        )
        ).toList(),
      ),
    );
  }
  Widget informacionClinica(Clinica clinica){
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(70, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.phone),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                        Text(clinica.GetTelefono,style: appTheme().textTheme.headline,),
                      ],
                    ),
                  ),
                  onTap: ()=> launch("tel:${clinica.GetTelefono}"),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Image.asset("assets/googlemap.png",height: 27,),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                        Text(clinica.GetDireccion,style: appTheme().textTheme.headline,),
                      ],
                    ),
                  ),
                  onTap: ()=> launch("google.navigation:q=-2.26379, -79.895622"),//"google.navigation:q=${_mapLocation['latitude']},${_mapLocation['longitude']}"
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.email),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                        Text(clinica.GetCorreo,style: appTheme().textTheme.headline,),
                      ],
                    ),
                  ),
                  onTap: ()=> launch("mailto:${clinica.GetCorreo}"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}