import 'dart:io';
import 'package:flutter_app/models/RedSocial.dart';


class Clinica {
  final int _id;
  final String _nombre;
  final String _descripcion;
  final String _telefono;
  final String _direccion;
  final String _correo;
  final List<RedSocial> redes;

  Clinica(this._id,this._nombre, this._descripcion,this._telefono,this._direccion,this._correo,this.redes);
  Clinica.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _nombre = json['nombre'],
        _descripcion = json['Contenido'],
        _telefono=json['imagen'],
        _direccion=json['direccion'],
        _correo=json['email'],
        redes=json['redsocial'];


  String get GetNombre => _nombre;
  String get Descripcion => _descripcion;
  String get GetTelefono =>_telefono;
  String get GetDireccion=>_direccion;
  String get GetCorreo=>_correo;
  List<RedSocial> get GetRedes=>redes;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombe']=this._nombre;
    data['descripcion']=this._descripcion;
    data['telefono']=this._telefono;
    data['direccion']=this._direccion;
    data['correo']=this._correo;
    data['redes']=this.redes;
    return data;
  }
}