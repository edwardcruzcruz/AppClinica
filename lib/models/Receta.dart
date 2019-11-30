import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/CitaCompleta.dart';
class Receta{
  final int _id;
  final String _especialidad;
  final CitaCompleta _citaCompleta;


  Receta(this._id,this._especialidad,this._citaCompleta);
  Receta.fromJson(Map<String, dynamic> json)
      : _id = json['especialidad_id'],
        _especialidad = json['nombEspe'],
        _citaCompleta = json['nombEspe'];

  int get Id => _id;
  String get NombreEspecialidad => _especialidad;
  CitaCompleta get GetCita => _citaCompleta;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['especialidad_id'] = this._id;
    data['nombEspe'] = this._especialidad;
    data['nombEspe'] = this._citaCompleta;
    return data;
  }
}
