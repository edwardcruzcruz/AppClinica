import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/models/HorarioCompleto.dart';
import 'package:flutter_app/models/Doctor.dart';

class CitaCompleta {
  final int _id;
  final User _paciente;
  final String _tratamiento;
  final HorarioCompleto _fecha;//un modelo mas llamado horarios, tipo programacion con un solo horario en una emisora de radio
  final Doctor _iddoctor;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta
  final String _idespecialidad;

  CitaCompleta(this._id,this._paciente, this._idespecialidad,this._tratamiento,this._fecha,this._iddoctor);
  CitaCompleta.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _paciente = json['cliente'],
        _idespecialidad = json['especialidad'],
        _tratamiento=json['tratamiento'],
        _fecha = json['fechaHora'],
        _iddoctor= json['IdDoctor'];

  int get Id => _id;
  User get Paciente => _paciente;
  String get Especialidad => _idespecialidad;
  String get Tratamiento => _tratamiento;
  HorarioCompleto get Fecha => _fecha;
  Doctor get IdDoctor=> _iddoctor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['cliente']=this._paciente;
    data['especialidad']=this._idespecialidad;
    data['tratamiento']=this._tratamiento;
    data['fechaHora']=this._fecha;
    data['Doctor']=this._iddoctor;
    return data;
  }
}