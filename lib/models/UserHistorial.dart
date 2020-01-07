import 'package:flutter_app/models/AplicarTratamientoCliente.dart';
import 'package:flutter_app/models/CitaxCliente.dart';
import 'package:flutter_app/models/Odontograma.dart';
import 'package:flutter_app/models/Sexo.dart';
class UserHistorial {
  final List<citaxcliente> _CitaxCliente;
  final int _idUsuario;
  final String _nombre;
  final String _apellido;
  final String _correo;
  final Genero _sexo;
  final String _noTelefono;
  final String _direccion;
  final String _fecha_nacimiento;
  final String _cedula;
  final int _id_Padre;
  final List<AplicarTratamientoCliente> _AplicarTratamientoCliente;
  final List<odontograma> _odontograma;

  UserHistorial(this._idUsuario,this._nombre, this._apellido,this._correo,this._sexo,this._noTelefono,this._direccion,this._fecha_nacimiento,this._cedula,this._id_Padre,this._AplicarTratamientoCliente,this._CitaxCliente,this._odontograma);
  factory UserHistorial.fromJson(Map<String, dynamic> json){

    var list = json['AplicarTratamientoCliente'] as List;
    List<AplicarTratamientoCliente> tratamientos = list.map((i) => AplicarTratamientoCliente.fromJson(i)).toList();
    var list2 = json['Odontograma'] as List;
    List<odontograma> odontogr = list2.map((i) => odontograma.fromJson(i)).toList();
    var list3 = json['CitaxCliente'] as List;
    List<citaxcliente> citaxCliente = list3.map((i) => citaxcliente.fromJson(i)).toList();

    return UserHistorial(
        json['id'],
        json['nombre'],
        json['apellido'],
        json['email'],
        Genero.fromJson(json['sexo']),
        json['telefono'],
        json['direccion'],
        json['fechaNacimiento'],
        json['cedula'],
        json['id_Padre'],
        tratamientos,
        citaxCliente,
        odontogr
    );
  }

  int get Id => _idUsuario;
  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Correo => _correo;
  Genero get Sexo => _sexo;
  String get Direccion => _direccion;
  String get Cedula => _cedula;
  int get IdPadre => _id_Padre;
  List<AplicarTratamientoCliente> get TratamientoAplicado => _AplicarTratamientoCliente;
  List<citaxcliente> get CitaxCliente => _CitaxCliente;
  List<odontograma> get Odontogramas => _odontograma;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['email'] = this._correo;
    data['sexo'] = this._sexo;
    data['telefono'] = this._noTelefono;
    data['direccion'] = this._direccion;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['cedula'] = this._cedula;
    data['id_Padre'] = this._id_Padre;
    data['AplicarTratamientoCliente'] = this._AplicarTratamientoCliente;
    data['CitaxCliente'] = this._CitaxCliente;
    data['Odontograma'] = this._odontograma;
    return data;
  }
}
