import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Carrito.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

import 'AgregarTarjeta.dart';

class Carrito extends StatefulWidget {
  //Listado(tipo, titulo);

  Function callback,callbackloading,callbackfull;
  Carrito({Key key,this.callback,this.callbackloading,this.callbackfull}) : super(key: key);
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Carrito(),
    );
  }

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  ScrollController _controller;
  Future<List<CarritoCompra>> future;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    future = RestDatasource().ListaCarritos();
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
        builder: (BuildContext context,
            AsyncSnapshot<List<CarritoCompra>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text("No hay tratamientos a pagar",
                    textAlign: TextAlign.center,
                    style: appTheme()
                        .textTheme
                        .display4); //'Error: ${snapshot.error}'
              return
                Scaffold(
                body: Row(
                  children: <Widget>[
                    DataTable(
                      rows: snapshot.data
                          .map(
                            (CarritoCompra) => DataRow(
                                //selected: selectedUsers.contains(user),
                                /*onSelectChanged: (b) {
                                  print("Onselect");
                                  onSelectedRow(b, user);
                                },*/
                                cells: [
                                  DataCell(
                                      Checkbox(
                                        onChanged: (bool value) {
                                          setState(() {
                                            CarritoCompra.seleccionado(value);
                                          });
                                        },
                                        value: CarritoCompra.Seleccionado,
                                      )
                                  ),
                                  DataCell(
                                    Text(CarritoCompra.IdTratamiento.IDEspecialidad.NombreEspecialidad),
                                    onTap: () {
                                      print('Selected ${CarritoCompra.IdTratamiento.IDEspecialidad.NombreEspecialidad}');
                                    },
                                  ),
                                  DataCell(
                                    Text(CarritoCompra.valorFaltante),
                                  ),
                                ]),
                          )
                          .toList(),
                      columns: [
                        DataColumn(
                          label: Text(""),
                        ),
                        DataColumn(
                          label: Text("Descripción"),
                        ),
                        DataColumn(
                          label: Text("Costo"),
                        ),
                      ],
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    List<CarritoCompra> lista_tmp=new List<CarritoCompra>();
                    double total=0;
                    print("+++++++++++++++++");
                    for (var i = 0; i < snapshot.data.length; i++) {
                      print(snapshot.data.elementAt(i).Seleccionado);
                      print(snapshot.data.elementAt(i).IdTratamiento.IDEspecialidad.NombreEspecialidad);
                      print(snapshot.data.elementAt(i).toJson());
                      if(snapshot.data.elementAt(i).Seleccionado){
                        lista_tmp.add(snapshot.data.elementAt(i));
                        total+=double.parse(snapshot.data.elementAt(i).valorFaltante);
                      }
                    }
                    print(lista_tmp);
                    print(total);
                    this.widget.callbackloading();
                    this.widget.callbackfull();
                    this.widget.callback(AgregarTarjeta(callback: this.widget.callback,callbackloading: this.widget.callbackloading,callbackfull: this.widget.callbackfull,compras: lista_tmp,total: total,));
                    // Add your onPressed code here!
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Color(0xFF00d6bc),
                ),
              );
          }
          return null;
        });
  }
}
