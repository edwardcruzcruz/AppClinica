import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/HorarioFecha.dart';
import 'package:flutter_app/models/Doctor.dart';


class citaxcliente{
  final int _id;
  //final Doctor _iddoctor;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta
  final Especialidad _idespecialidad;
  final String observacion,descripcion;
  final HorarioFecha _recordatorio;

  //_iddoctor = Doctor.fromJson(json['doctor']),
  citaxcliente(this._id,this._idespecialidad,this.observacion,this.descripcion,this._recordatorio);//,this._iddoctor
  citaxcliente.fromJson(Map<String, dynamic> json)
      : _id = json['cita_id'],
        _idespecialidad = Especialidad.fromJson(json['especialidad']),
        observacion=json['observacion'],
        descripcion=json['descripcion'],
        _recordatorio = HorarioFecha.fromJson(json['fechaHora']);

  int get Id => _id;
  Especialidad get IDEspecialidad => _idespecialidad;
  //Doctor get IdDoctor=> _iddoctor;
  String get Observacion=>observacion;
  String get Descripcion=>descripcion;
  HorarioFecha get HorarioFechaP=>_recordatorio;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cita_id']=this._id;
    data['doctor']=this._idespecialidad;
    data['especialidad']=this.observacion;
    data['observacion']=this.descripcion;
    data['descripcion']=this._recordatorio;
    //data['fechaHora']=this._iddoctor;
    return data;
  }
}