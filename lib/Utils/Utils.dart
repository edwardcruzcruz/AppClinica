import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  static bool Cedulavalida(String x) {
    bool cedulaCorrecta = false;


    if (x.length == 10) // ConstantesApp.LongitudCedula
        {
      int tercerDigito = int.parse(x.substring(2, 3));
      if (tercerDigito < 6) {
// Coeficientes de validación cédula
// El decimo digito se lo considera dígito verificador
        var coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2];
        int verificador = int.parse(x.substring(9, 10));
        int suma = 0;
        int digito = 0;
        for (int i = 0; i < (x.length - 1); i++) {
          digito = int.parse(x.substring(i, i + 1)) * coefValCedula[i];
          suma += ((digito % 10) + (digito / 10)).toInt();
        }

        if ((suma % 10 == 0) && (suma % 10 == verificador)) {
          cedulaCorrecta = true;
        }
        else if ((10 - (suma % 10)) == verificador) {
          cedulaCorrecta = true;
        } else {
          cedulaCorrecta = false;
        }
      } else {
        cedulaCorrecta = false;
      }
    } else {
      cedulaCorrecta = false;
    }

    if (!cedulaCorrecta) {
      print("La Cédula ingresada es Incorrecta");
    }
    return cedulaCorrecta;
  }
  static String getMonth(String number){
    String month="Enero";
    print("99999999999999999999999999999999999999999999999999999999999999999");
    print(number);
    if ( number.compareTo("02")==0) {
      month="Febrero";
    } else if (number.compareTo("03")==0) {
      month="Marzo";
    } else if (number.compareTo("04")==0) {
      month="Abril";
    }else if (number.compareTo("05")==0) {
      month="Mayo";
    }else if (number.compareTo("06")==0) {
      month="Junio";
    }else if (number.compareTo("07")==0) {
      month="Julio";
    }else if (number.compareTo("08")==0) {
      month="Agosto";
    }else if (number.compareTo("09")==0) {
      month="Septiembre";
    }else if (number.compareTo("10")==0) {
      month="Octubre";
    }else if (number.compareTo("11")==0) {
      month="Noviembre";
    }else if (number.compareTo("12")==0) {
      month="Diciembre";
    }
    return month;
  }
  static void showDialogError(BuildContext context,String problema) {//todos estos mensajes se tendrian que poner en una clase externa
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Causa: "+problema.split("[").elementAt(1).split("]").elementAt(0)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}