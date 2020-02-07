import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'CitaCompleta.dart';
import 'Tratamiento.dart';


class CarritoCompra {
  final int _id;
  final int _id_Cliente;
  final int _id_Oferta;
  final CitaCompleta _id_Tratamiento;//final Tratamiento _tratamiento;
  final String _valorFaltante;

  bool _seleccionado;

  CarritoCompra(this._id,this._id_Cliente,this._id_Oferta,this._id_Tratamiento,this._valorFaltante);

  factory CarritoCompra.fromJson(Map<String, dynamic> json){
    return CarritoCompra(
      json['id'],
      json['id_Cliente'],
      json['id_Oferta'],
      json['cita_id']==null? CitaCompleta.fromJson({
        "tratam_id": 0,
        "descripcion": "",
        "precio": "00.00",
        "duracion": "00:00"
      }) :CitaCompleta.fromJson(json['cita_id']),
        json['valorFaltante'],
    );
  }

  int get Id => _id;
  int get IdOferta => _id_Oferta;
  String get valorFaltante =>_valorFaltante;
  int get IdCliente=>_id_Cliente;
  bool get Seleccionado=>_seleccionado;
  CitaCompleta get IdTratamiento=>_id_Tratamiento;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['id_Cliente']=this._id_Cliente;
    data['id_Oferta']=this._id_Oferta;
    data['valorFaltante']=this._valorFaltante;
    data['id_Cliente']=this._id_Cliente;
    return data;
  }

  void seleccionado(bool value) {
    _seleccionado = value;
  }
}