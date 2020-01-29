import 'package:flutter/cupertino.dart';
import 'package:flutter_app/theme/style.dart';

class Utils{
  static setOval(context,String tituloBienvenida,String cuenta,String titulo){
    return Container(
      width: double.infinity,
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
                  MediaQuery.of(context).size.width, 120.0)
          )
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Align(
              child: Text(tituloBienvenida,style: appTheme().textTheme.display1,),
              alignment: Alignment(-0.80, 0),
            ),
            Align(
              child: new Text(cuenta,style: appTheme().textTheme.display2,),
              alignment: Alignment(-0.80, 0),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10),),
            Align(
              child: Text(titulo,style: appTheme().textTheme.display3,),
            )
            //,_lista()
          ],

        ),

      ),

    );
  }
}