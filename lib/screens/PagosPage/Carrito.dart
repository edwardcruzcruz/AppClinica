import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/Utils/Strings.dart';
import 'package:flutter_app/models/Carrito.dart';
import 'package:flutter_app/services/Rest_Services.dart';
import 'package:flutter_app/theme/style.dart';

class Carrito extends StatefulWidget {
  //Listado(tipo, titulo);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Carrito(),
    );
  }

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  Future<List<CarritoCompra>> future;
  @override
  void initState() {
    super.initState();
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
                  style:appTheme().textTheme.display4
                );//'Error: ${snapshot.error}'
            return Scaffold(
              body: Row(
                children: <Widget>[
                  Table(
                    //border: TableBorder.all(width: 1.0, color: Colors.black),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Text(''),

                              new Text('Descripción'),
                              new Text("Costo",
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new Radio(
                                  value: 1, groupValue: null, onChanged: null),
                              new Text('Name'),
                              new Text("dfgjksdfsdf"),
                            ],
                          ),
                        )
                      ]),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        initState() {}
                        return _item(snapshot.data.elementAt(index));
                      },
                    ),
                  ),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                },

                child: Icon(Icons.arrow_forward_ios),
                backgroundColor: Color(0xFF00d6bc),
              ),
            );

        }
          return null;
      }
    );
  }

  Widget _item(CarritoCompra item) {
    //String mediaUrl = item.Imagen;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      item.seleccionado(value);
                    });
                  },
                  value: item.Seleccionado,
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  item.Descripcion
                )
              ],

            ),
            Column(
              children: <Widget>[
                Text(
                  item.Costo.toString()
                )
              ],

            )

          ],
        ),
      ),
    );
  }

}
