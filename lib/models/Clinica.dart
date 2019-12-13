import 'dart:io';
import 'package:flutter_app/models/RedSocial.dart';


class Clinica {
  final int _id;
  final String _celular;
  final String _proposito;
  final String _mision;
  final String _vision;
  final String _telefono;
  final String _direccion;
  final String _correo;
  final List<RedSocial> redes;

  Clinica(this._id,this._direccion,this._telefono,this._celular,this._correo, this._proposito,this._vision,this._mision,this.redes);
  factory Clinica.fromJson(Map<String, dynamic> json){

    var list = json['redesSocial'] as List;
    print(list.runtimeType);
    List<RedSocial> redes = list.map((i) => RedSocial.fromJson(i)).toList();


    return Clinica(
        json['id'],
        json['direccion'],
        json['telefono'],
        json['celular'],
        json['correo'],
        json['proposito'],
        json['mision'],
        json['vision'],
        redes
    );
  }

  String get GetCelular => _celular;
  String get Proposito => _proposito;
  String get Mision => _mision;
  String get Vision => _vision;
  String get GetTelefono =>_telefono;
  String get GetDireccion=>_direccion;
  String get GetCorreo=>_correo;
  List<RedSocial> get GetRedes=>redes;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombe']=this._celular;
    data['descripcion']=this._proposito;
    data['telefono']=this._telefono;
    data['direccion']=this._direccion;
    data['correo']=this._correo;
    data['redes']=this.redes;
    return data;
  }
}