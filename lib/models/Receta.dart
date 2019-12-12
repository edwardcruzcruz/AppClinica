import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/CitaCompleta.dart';
class Receta{
  final String _medicina;
  final int _hora_Tratamiento;
  final int _duracion_Tratamiento_Dias;
  final CitaCompleta _id_Cita;
  final bool _recordatorio;

  Receta(this._medicina,this._hora_Tratamiento,this._duracion_Tratamiento_Dias,this._id_Cita,this._recordatorio);
  Receta.fromJson(Map<String, dynamic> json)
      : _medicina = json['medicina'],
        _hora_Tratamiento = json['hora_Tratamiento'],
        _duracion_Tratamiento_Dias = json['duración_Tratamiento_Dias'],
        _id_Cita = CitaCompleta.fromJson(json['id_Cita']),
        _recordatorio = json['recordatorio'];


  String get Medicina => _medicina;
  int get HoraTratamiento=>_hora_Tratamiento;
  int get TratamientoDias=>_duracion_Tratamiento_Dias;
  CitaCompleta get GetCita => _id_Cita;
  bool get Recordatorio => _recordatorio;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicina'] = this._medicina;
    data['hora_Tratamiento'] = this._hora_Tratamiento;
    data['duración_Tratamiento_Dias'] = this._duracion_Tratamiento_Dias;
    data['id_Cita'] = this._id_Cita;
    data['recordatorio'] = this._recordatorio;
    return data;
  }
}
