import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/screens/MenuPage/CuentasAsociadas/CuentasAsociadas.dart';
import 'package:flutter_app/theme/style.dart';

class ModificarCuenta extends StatefulWidget {
  Cuenta cuenta;
  List<Cuenta> cuentas;
  Function callback,callbackloading,callbackfull;
  ModificarCuenta({Key key,this.cuenta,this.cuentas,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => ModificarCuenta(),
    );
  }

  @override
  _ModificarCuentaState createState() => _ModificarCuentaState();
}

class _ModificarCuentaState extends State<ModificarCuenta>{
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

                  children: <Widget>[
                    GestureDetector(
                      onTap: () {////para retroceder a CuentasAsociadas
                        this.widget.callback(CuentasAsociadas(cuentas: this.widget.cuentas,callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20.0,20.0,10.0,20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios,size: 10,color: appTheme().textTheme.subtitle.color,),
                            Text(Strings.TextRetroceder,style: appTheme().textTheme.subtitle,)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //alignment: Alignment(50, 0),
                        margin: const EdgeInsets.fromLTRB(65.0,20.0,10.0,20.0),
                        child: Text(Strings.ModificarTitulo1,style: appTheme().textTheme.title,)
                    )
                  ],
                ),
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              Expanded(
                child: formulario(this.widget.cuenta),//formulario()
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
  Widget formulario(Cuenta cuenta){
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              //controller: passController2,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme().buttonColor,
                      width: 1.0),
                ),
                labelText: Strings.LabelRegistroNombre,
                labelStyle: appTheme().textTheme.title,
                hintText: this.widget.cuenta.Nombre
              ),
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo contraseña es requerido";
                }/* else if (text.length <= 5) {
                  return "Su contraseña debe ser al menos de 5 caracteres";
                } else if (!contRegExp.hasMatch(text)) {
                  return "El formato para contraseña no es correcto";
                }*/
                return null;
              },
            ),
            //decoration: underlineTextField(),
          ),
        ],
      ),
    );
  }
  /*
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
                List<Horario> horarios= await RestDatasource().HorarioDoctor(doctores.elementAt(position).Id);
                this.widget.callbackfull();//(falta)mostrar un mensaje no hay horarios dispopnibles o cualquier cosa
                if(horarios.length==0){
                  _showDialogSeleccionNull();
                }else{
                  this.widget.callback(CalendarioPage(usuario: this.widget.usuario,idEspecialidadEscogida: this.widget.idEspecialidadEscogida, idHorario: horarios.elementAt(position).IdHorario,horarios: horarios,doctor: doctores.elementAt(position),callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,));
                }*/
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarioPage(horarios: horarios,)),
                );*/
                //Navigator.pop(context);
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
                          child: Icon(
                            Icons.edit,
                            size: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.delete,
                            size: 15.0,
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
*/
}