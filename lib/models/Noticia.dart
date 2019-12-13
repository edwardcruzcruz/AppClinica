import 'dart:io';


class Noticia {
  final String _titulo;
  final String _descripcion;
  final String _imagen;
  final String _fechaPublicacion;
  Noticia(this._titulo, this._descripcion,this._imagen,this._fechaPublicacion);
  Noticia.fromJson(Map<String, dynamic> json)
      : _titulo = json['Descripcion'],
        _descripcion = json['Contenido'],
        _imagen=json['imagen'],
        _fechaPublicacion=json['fechaPublicacion'];


  String get Titulo => _titulo;
  String get Descripcion => _descripcion;
  String get Imagen =>_imagen;
  String get FechaPublicacion=>_fechaPublicacion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo']=this._titulo;
    data['descripcion']=this._descripcion;
    data['imagen']=this._imagen;
    data['fechaPublicacion']=this._fechaPublicacion;
    return data;
  }
}