import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/ModifcarCuenta.dart';
import 'package:flutter_app/theme/style.dart';

class CuentasAsociadas extends StatefulWidget {
  List<Cuenta> cuentas;
  Function callback,callbackloading,callbackfull;
  CuentasAsociadas({Key key,this.cuentas,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => CuentasAsociadas(),
    );
  }

  @override
  _CuentasAsociadasState createState() => _CuentasAsociadasState();
}

class _CuentasAsociadasState extends State<CuentasAsociadas>{
  var storageService = locator<Var_shared>();
  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: Text(Strings.CuerpoTituloPaginaCuentasAsociadas,style: appTheme().textTheme.display3,),
              )
            ],
          ),
        ),
      ),
        new Expanded(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    GestureDetector(
                      onTap: () {//async
                        /*this.widget.callbackloading;
                        List<Especialidad> especialidades= await RestDatasource().ListaEspecialidad();
                        this.widget.callbackfull;
                        this.widget.callback(Agendamiento(usuario: this.widget.usuario,especialidades: especialidades,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                        */
                        },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0.0,20.0,20.0,20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,size: 10,color: appTheme().textTheme.subtitle.color,),
                            Text(Strings.TextAgregarCuentaAsoc,style: appTheme().textTheme.subtitle,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: this.widget.cuentas==null?SinCuentas():formulario(),//formulario()
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget SinCuentas(){
    return new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("No hay clientes"),
          ],
        )
    );
  }
  Widget formulario(){
    //String especialidad=this.doctores.elementAt(0).Especialidad;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {//async
                /*this.widget.callbackloading();
                Cuenta cuenta= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                if(horarios.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida, idHorario: horarios.elementAt(position).IdHorario,horarios: horarios,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                }*/
                //Navigator.pop(context);
                storageService.save_idHijo(this.widget.cuentas.elementAt(position).IdCuentaPadre);
                storageService.save_currentAccount(this.widget.cuentas.elementAt(position).Apellido);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        //child: especialidades.elementAt(position).NombreEspecialidad=="Nutrición"?new Image.asset('assets/nutricion.png',width: 33,height: 40):especialidades.elementAt(position).NombreEspecialidad=="Odontología"?new Image.asset('assets/odontologia.png',width: 33,height: 40):new Image.asset('assets/psicologia.png',width: 33,height: 40),
                        child: new Image.asset('assets/avatar.png',width: 63,height: 70),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(0.0, 12.0, 12.0, 3.0),
                        child: Text(this.widget.cuentas.elementAt(position).Nombre+" "+this.widget.cuentas.elementAt(position).Apellido,style: appTheme().textTheme.display4,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(icon: Icon(
                            Icons.edit,
                            size: 25.0,
                            color: Colors.grey,
                          ), onPressed: (){
                            this.widget.callback(
                                /*
                                ModificarCuenta(
                                  cuenta: this.widget.cuentas.elementAt(position),
                                  cuentas: this.widget.cuentas,
                                  callback: this.widget.callback,
                                  callbackloading: this.widget.callbackloading,
                                  callbackfull: this.widget.callbackfull,)*/
                                );
                              }
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            size: 25.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            )
          ],
        );
      },
      itemCount: this.widget.cuentas.length,
    );
  }

}