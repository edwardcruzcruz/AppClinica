import 'package:flutter_app/models/HorarioRango.dart';
class HorarioFecha {
  final int _id_horario;
  final String _fecha;
  final HorarioRango _hora;

  HorarioFecha(this._id_horario,this._fecha,this._hora);
  HorarioFecha.fromJson(Map<String, dynamic> json):
        _id_horario= json['horarios_id'],
         _fecha= json['fecha'],
        _hora = HorarioRango.fromJson(json['hora']);

  int get IdHorario => _id_horario;
  String get Fecha => _fecha;
  HorarioRango get Hora => _hora;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horarios_id']=this._id_horario;
    data['fecha']=this._fecha;
    data['hora']=this._hora;
    return data;
  }
}