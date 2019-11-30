import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/theme/style.dart';

class Citas extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Citas(),
    );
  }

  @override
  _CitasState createState() => _CitasState();
}

class _CitasState extends State<Citas>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        new Container(
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
                  child: Text(Strings.CuerpoTituloPaginaCitas,style: appTheme().textTheme.display3,),
                )
              ],
            ),
          ),
        ),
        new Expanded(
          child: new DefaultTabController(
            length: 2,
            child: new Scaffold(
              appBar: new PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: new Container(
                  color: Colors.transparent,
                  child: new SafeArea(
                    child: Column(
                      children: <Widget>[
                        new TabBar(
                          indicatorColor: Colors.teal,
                          tabs: [
                            new Container(
                            margin: EdgeInsets.fromLTRB(0,10,0,10),
                            child: new Text(Strings.Tab1Citas,style: appTheme().textTheme.subhead,),
                          ), new Container(
                              margin: EdgeInsets.fromLTRB(0,10,0,10),
                              child: new Text(Strings.Tab2Citas,style: appTheme().textTheme.subhead,)
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: new TabBarView(
                children: <Widget>[
                  new Column(
                    children: <Widget>[new Text("Próximos Page")],
                  ),
                  new Column(
                    children: <Widget>[new Text("Anteriores Page")],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}