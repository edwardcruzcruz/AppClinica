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
    //future = RestDatasource().ListaNoticias();
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
        /*switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');*/

        return Scaffold(
          body: Table(
            children: [
              TableRow(
                children: [
                  Text(
                      "Descripcion"
                  ),
                  Text(
                      "Costo"
                  ),
                ]
              ),

            ],
          ),
          /*Stack(
            children: <Widget>[

              Column(
                children: <Widget>[
                  Row(

                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              "Descripcion"
                          ),
                        ],
                      ),
                      Divider(
                        height: 2.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                              "Costo"
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                      child: Divider()
                  ),
                ],
              ),


              *//*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      initState() {}
                      return _item(snapshot.data.elementAt(index));
                    },
                  ),
                ),*//*

            ],
          ),*/
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },

            child: Icon(Icons.arrow_forward_ios),
            backgroundColor: Color(0xFF00d6bc),
          ),
        );

        //}
        return null;
      },
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
