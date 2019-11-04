import 'dart:convert';
import 'dart:ffi';
import 'dart:io';


class CarritoCompra {
  final String _descripcion;
  final Float _costo;
  final int _id;
  bool _seleccionado;

  CarritoCompra(this._descripcion,this._costo,this._id);
  CarritoCompra.fromJson(Map<String, dynamic> json):
        _descripcion = json['Descripcion'],
        _costo=json['Costo'],
        _id=json['Id'];


  String get Descripcion => _descripcion;
  Float get Costo =>_costo;
  int get Id=>_id;
  bool get Seleccionado=>_seleccionado;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descripcion']=this._descripcion;
    data['Costo']=this._costo;
    data['Id']=this._id;
    return data;
  }

  void seleccionado(bool value) {
    _seleccionado = value;
  }
}