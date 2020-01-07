import 'package:flutter_app/models/UserHistorial.dart';

import 'Tratamiento.dart';


class HistorialClinico {
  //final int _id;
  final UserHistorial _paciente;
  final String _medicacionActual,_problemasCardiacos,_sangranEncias,_diabetes,_alergias,_observaciones,_diagnostico,_fechaCreacion;


  HistorialClinico(this._paciente, this._medicacionActual,this._problemasCardiacos,this._sangranEncias,this._diabetes,this._alergias,this._observaciones,this._diagnostico,this._fechaCreacion);
  HistorialClinico.fromJson(Map<String, dynamic> json)
      : //_id = json['id'],
        _paciente = UserHistorial.fromJson(json['id_cliente']),
        _medicacionActual = json['medicacionActual'],
        _problemasCardiacos = json['problemasCardiacos'],
        _sangranEncias = json['sangranEncias'],
        _diabetes = json['diabetes'],
        _alergias = json['alergias'],
        _observaciones = json['observaciones'],
        _diagnostico = json['diagnostico'],
        _fechaCreacion = json['fechaCreacion'];

  //int get Id => _id;
  UserHistorial get Paciente => _paciente;
  String get MedicacionActual => _medicacionActual;
  String get ProblemasCardiacos => _problemasCardiacos;
  String get SangraEncias => _sangranEncias;
  String get Diabetes => _diabetes;
  String get Alergias => _alergias;
  String get Observaciones => _observaciones;
  String get Diagnostico => _diagnostico;
  String get FechaCreacion => _fechaCreacion;



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id']=this._id;
    data['id_cliente']=this._paciente;
    data['medicacionActual']=this._medicacionActual;
    data['problemasCardiacos']=this._problemasCardiacos;
    data['sangranEncias']=this._sangranEncias;
    data['diabetes']=this._diabetes;
    data['alergias']=this._alergias;
    data['observaciones']=this._observaciones;
    data['diagnostico']=this._diagnostico;
    data['fechaCreacion']=this._fechaCreacion;
    return data;
  }
}