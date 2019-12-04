import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Acerca extends StatefulWidget {
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
  final List<String> _listViewData = [
    "Inducesmile.com",
    "Flutter Dev",
    "Android Dev",
    "iOS Dev!",
  ];
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
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.facebookF, size: 30,color: Colors.teal,), // Icon(Icons.note_add),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.twitter, size: 25,color: Colors.teal,), // Icon(Icons.note_add),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.instagram, size: 25,color: Colors.teal,), // Icon(Icons.note_add),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.youtube, size: 25,color: Colors.teal,), // Icon(Icons.note_add),
                //onPressed: () =>openTheDrawer(),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Divider(
          height: 2.0,
          color: Colors.grey,
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.phone),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                    Text("0917612818"),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.search),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                    Text("Av. Amazonas y Pereira"),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.email),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),),
                    Text("info@clinicaesteticadental.com"),
                  ],
                )
              ],
            ),
          )
        )
      ],
    );
  }
}