import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/CitaCompleta.dart';

import 'Especialidad.dart';
import 'HorarioCompleto.dart';
import 'RecetaxCita.dart';
import 'Tratamiento.dart';
import 'User.dart';
class Receta{
  final int _id;
  final User _paciente;
  final Tratamiento _tratamiento;
  final HorarioCompleto _fecha;//un modelo mas llamado horarios, tipo programacion con un solo horario en una emisora de radio
  final Doctor _iddoctor;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta
  final Especialidad _idespecialidad;
  final List<RecetaxCita> _recetaxCita;

  Receta(this._id,this._paciente, this._idespecialidad,this._tratamiento,this._fecha,this._iddoctor,this._recetaxCita);

  factory Receta.fromJson(Map<String, dynamic> json){
    var list = json['RecetaxCita'] as List;
    print(list.runtimeType);
    List<RecetaxCita> ListRecetas = list.map((i) => RecetaxCita.fromJson(i)).toList();

    return Receta(
      json['cita_id'],
      User.fromJson(json['cliente']),
      Especialidad.fromJson(json['especialidad']),
      json['tratamiento']==null? Tratamiento.fromJson({
        "tratam_id": 0,
        "descripcion": "",
        "precio": "00.00",
        "duracion": "00:00"
      }) :Tratamiento.fromJson(json['tratamiento']),
        HorarioCompleto.fromJson(json['fechaHora']),
        Doctor.fromJson(json['doctor']),
        ListRecetas
    );
  }

  int get Id => _id;
  User get Paciente => _paciente;
  Especialidad get IDEspecialidad => _idespecialidad;
  Tratamiento get IDTratamiento => _tratamiento;
  HorarioCompleto get Fecha => _fecha;
  Doctor get IdDoctor=> _iddoctor;
  List<RecetaxCita> get RecetaPorCita=> _recetaxCita;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['cliente']=this._paciente;
    data['especialidad']=this._idespecialidad;
    data['tratamiento']=this._tratamiento;
    data['fechaHora']=this._fecha;
    data['Doctor']=this._iddoctor;
    data['RecetaxCita']=this._recetaxCita;
    return data;
  }
}
