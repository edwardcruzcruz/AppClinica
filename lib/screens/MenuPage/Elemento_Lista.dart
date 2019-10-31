import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Noticia.dart';

class Elemento_Lista extends StatefulWidget {
  Elemento_Lista({Key key, this.noticia}) : super(key: key);
  final Noticia noticia;

  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => Elemento_Lista(),
    );
  }

  @override
  _Elemento_Lista createState() => _Elemento_Lista();
}

class _Elemento_Lista extends State<Elemento_Lista>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF00a18d),
      ),
      body: new Container(
        margin: new EdgeInsets.all(10.0),
        child: new Material(
          elevation: 4.0,
          borderRadius: new BorderRadius.circular(6.0),
          child: new ListView(
            children: <Widget>[
              this.widget.noticia.Imagen!=null?
              _getImageNetwork(this.widget.noticia.Imagen)
              :SizedBox(width: 0.0),
              _getBody(this.widget.noticia.Titulo,this.widget.noticia.FechaPublicacion,this.widget.noticia.Descripcion),
            ],
          ),
        ),
      ),
    );

  }



Widget _getImageNetwork(mediaUrl){

  return new Container(
      height: 200.0,
      child: mediaUrl != null
          ? Image.network(
        mediaUrl,
        fit: BoxFit.cover,
        width: 120,
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
        _getTittle(tittle),
        _getDate(date),
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