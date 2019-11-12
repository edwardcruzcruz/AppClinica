import 'dart:convert';
import 'dart:ffi';
import 'dart:io';


class CarritoCompra {
  final int _id_Cliente;
  final int _id_Oferta;
  final int _id_Tratamiento;
  final String _valorFaltante;

  bool _seleccionado;

  CarritoCompra(this._id_Cliente,this._id_Oferta,this._id_Tratamiento,this._valorFaltante);
  CarritoCompra.fromJson(Map<String, dynamic> json):
        _id_Cliente=json['id_Cliente'],
        _id_Oferta = json['id_Oferta'],
        _id_Tratamiento = json['id_Tratamiento'],
        _valorFaltante=json['valorFaltante'];


  int get IdOferta => _id_Oferta;
  String get valorFaltante =>_valorFaltante;
  int get IdCliente=>_id_Cliente;
  bool get Seleccionado=>_seleccionado;
  int get IdTratamiento=>_id_Tratamiento;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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