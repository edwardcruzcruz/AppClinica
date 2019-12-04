import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter_app/models/RedSocial.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Acerca extends StatefulWidget {
  Clinica clinica;
  Function callback,callbackloading,callbackfull;
  Acerca({Key key,this.clinica,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Acerca(),
    );
  }

  @override
  _AcercaState createState() => _AcercaState();
}

class _AcercaState extends State<Acerca>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        Container(
          height: 100.0,
          decoration: new BoxDecoration(

              gradient: new LinearGradient(
                colors: [
                  Color(0xFF00a18d),
                  Color(0xFF00d6bc),
                ],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 120.0))
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Align(
                  child: Text(Strings.CuerpoTituloBienvenido,style: appTheme().textTheme.display1,),
                  alignment: Alignment(-0.80, 0),
                ),
                Align(
                  child: new Text(storageService.getCuentaActual,style: appTheme().textTheme.display2,),
                  alignment: Alignment(-0.80, 0),
                ),
                Padding(padding: EdgeInsets.only(bottom: 10),),
                Align(
                  child: Text(Strings.CuerpoTituloPaginaAcercade,style: appTheme().textTheme.display3,),
                )
              ],
            ),
          ),
        ),
        /*ListView(
          padding: EdgeInsets.all(8.0),
          children: _listViewData
              .map((data) => ListTile(
            leading: Icon(Icons.person),
            title: Text(data),
            subtitle: Text("a subtitle here"),
          ))
              .toList(),
        ),*/
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: this.widget.clinica.redes.map((item) => new IconButton(
              icon: Icon(item.GetNombre=="Facebook"?FontAwesomeIcons.facebookF:item.GetNombre=="Twitter"?FontAwesomeIcons.twitter:FontAwesomeIcons.instagram, size: 30,color: Colors.teal,), // Icon(Icons.note_add),
                onPressed: () {
                  var url=item.GetLink;
                  launch(url);
                },//_launchURL(this.widget.clinica.redes.elementAt(index).GetLink),
              )
            ).toList(),
          ),
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        ),
        this.widget.clinica==null?Center(child: Text("Sin contenido que mostrar",textAlign: TextAlign.center,style: appTheme().textTheme.subhead,),):Expanded(
          child: Center(
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
                             Text(this.widget.clinica.GetTelefono,style: appTheme().textTheme.headline,),
                           ],
                         ),
                       ),
                       onTap: ()=> launch("tel:${this.widget.clinica.GetTelefono}"),
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
                              Text(this.widget.clinica.GetDireccion,style: appTheme().textTheme.headline,),
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
                              Text(this.widget.clinica.GetCorreo,style: appTheme().textTheme.headline,),
                            ],
                          ),
                        ),
                        onTap: ()=> launch("mailto:${this.widget.clinica.GetCorreo}"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        )
      ],
    );
  }
}