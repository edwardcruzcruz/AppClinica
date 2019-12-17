import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Noticia.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:webfeed/webfeed.dart';
import 'dart:math';
import 'package:flutter_app/services/Rest_Services.dart';

import 'Elemento_Lista.dart';

const swatch_1 = Colors.white;
const swatch_2 = Color(0xffe3e6f3);
const swatch_3 = Color(0xFF00a18d);
const swatch_4 = Color(0xff545c6b);
const swatch_5 = Color(0xff363cb0);
const swatch_6 = Color(0xff09090a);
const swatch_7 = Color(0xff25255b);

class Listado extends StatefulWidget {
  Listado({Key key, this.tipo}) : super(key: key);
  final String tipo;

  //Listado(tipo, titulo);

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Listado(),
    );
  }

  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  ScrollController _controller;
  double backgroundHeight = 180.0;
  Future<List<Noticia>> future;

  @override
  void initState() {
    super.initState();
    future = RestDatasource().ListaNoticias();

    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        backgroundHeight = max(0, 180.0 - _controller.offset);
      });
    });
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
      builder: (BuildContext context, AsyncSnapshot<List<Noticia>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text(
                "No hay noticias nuevas",
                textAlign: TextAlign.center,
                style: appTheme().textTheme.display4,
              ); //'Error: ${snapshot.error}'

            return snapshot.data.length > 0
                ? ListView.builder(
                    //validar null citasProximas
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, position) {
                      return
                        new Container(
                          margin: new EdgeInsets.all(10.0),
                          child: new Material(
                            elevation: 4.0,
                            borderRadius: new BorderRadius.circular(6.0),
                            child: new Column(
                              children: <Widget>[
                                _getBody(snapshot.data.elementAt(position).Titulo,snapshot.data.elementAt(position).FechaPublicacion,snapshot.data.elementAt(position).Descripcion),
                                snapshot.data.elementAt(position).Imagen!=null?
                                _getImageNetwork(snapshot.data.elementAt(position).Imagen)
                                    :SizedBox(width: 0.0),
                              ],
                            ),
                          ),
                        );
                    },
                  )
                : Text(
                    "No hay noticias nuevas",
                    textAlign: TextAlign.center,
                    style: appTheme().textTheme.display4,
                  );
        }
        return null;
      },
    );
  }

  Widget _item(Noticia item) {
    String mediaUrl = item.Imagen;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: IntrinsicHeight(
          child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Elemento_Lista(
                                noticia: item,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          //padding: EdgeInsets.all(12.0),
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 42.0,
                                  height: 42.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21.0),
                                    color: swatch_5,
                                  ),
                                  child: Center(
                                    child: Text(
                                      item.Titulo.length > 1
                                          ? item.Titulo.substring(0, 1)
                                          : "",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  item.Titulo.length > 12
                                      ? item.Titulo.substring(0, 12)
                                      : item.Titulo,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  height: 2.0,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            Text(
                              item.Descripcion.substring(0, 80),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              item.FechaPublicacion,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: swatch_4,
                              ),
                            )
                          ],
                        ) // Text('Flat Button'),
                        ),
                  ],
                ),
              ),
              SizedBox(width: 16.0),
              mediaUrl != null
                  ? Image.network(
                      mediaUrl,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    )
                  : SizedBox(width: 0.0),
            ],
          ),
          Divider(
            height: 2.0,
            color: Colors.teal,
          )
        ],
      )),
    );
  }

  Widget _getImageNetwork(mediaUrl){

    return new Container(
      height: 200.0,
      child: mediaUrl != null
          ? Image.network(
        mediaUrl,
        fit: BoxFit.cover,
        //width: 120,
        height: 120,
      )
          : SizedBox(width: 0.0),
    );

  }

  Widget _getBody(tittle,date,description){

    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getDate(date),
          _getTittle(tittle),
          _getDescription(description),
        ],
      ),
    );
  }

  _getTittle(tittle) {
    return new Text(tittle,
      style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0),
    );
  }

  _getDate(date) {

    return new Container(
        margin: new EdgeInsets.only(top: 5.0),
        child: new Text(date,
          textAlign: TextAlign.right,
          style: new TextStyle(
              fontSize: 10.0,
              color: Colors.grey
          ),
        )
    );
  }

  _getDescription(description) {
    return new Container(
      margin: new  EdgeInsets.only(top: 20.0),
      child: new Text(description),
    );
  }


}
