import 'package:flutter_app/models/HorarioRango.dart';
class HorarioCompleto {
  final int _id_horario;
  final String _fecha;
  final HorarioRango _hora;
  final int _id_doctor;
  final bool _is_avaliable;

  HorarioCompleto(this._id_horario,this._fecha,this._hora,this._id_doctor,this._is_avaliable);
  HorarioCompleto.fromJson(Map<String, dynamic> json):
        _id_horario= json['horarios_id'],
         _fecha= json['fecha'],
        _hora = json['hora'],
        _id_doctor= json['doctor'],
        _is_avaliable= json['is_available'];

  int get IdHorario => _id_horario;
  String get Fecha => _fecha;
  HorarioRango get Hora => _hora;
  int get IdDoctor => _id_doctor;
  bool get IsAvaliable => _is_avaliable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horarios_id']=this._id_horario;
    data['fecha']=this._fecha;
    data['hora']=this._hora;
    data['doctor']=this._id_doctor;
    data['is_available']=this._is_avaliable;
    return data;
  }
}