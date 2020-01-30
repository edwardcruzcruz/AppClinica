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
}