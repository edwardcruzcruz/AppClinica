import 'package:flutter_app/models/Sexo.dart';
class UserHistorial {
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
  final List<String> _AplicarTratamientoCliente;
  final List<String> _CitaxCliente;
  final List<String> _Odontograma;

  UserHistorial(this._idUsuario,this._nombre, this._apellido,this._correo,this._sexo,this._noTelefono,this._direccion,this._fecha_nacimiento,this._cedula,this._id_Padre,this._AplicarTratamientoCliente,this._CitaxCliente,this._Odontograma);

  UserHistorial.fromJson(Map<String, dynamic> json)
      : _idUsuario = json['id'],
        _nombre = json['nombre'],
        _apellido = json['apellido'],
        _correo = json['email'],
        _sexo = Genero.fromJson(json['sexo']),
        _noTelefono = json['telefono'],
        _direccion = json['direccion'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _cedula = json['cedula'],
        _id_Padre = json['id_Padre'],
        _AplicarTratamientoCliente = new List<String>.from(json['AplicarTratamientoCliente']),
        _Odontograma = new List<String>.from(json['Odontograma']),
        _CitaxCliente = new List<String>.from(json['CitaxCliente']);

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
  List<String> get TratamientoAplicado => _AplicarTratamientoCliente;
  List<String> get CitaxCliente => _CitaxCliente;
  List<String> get Odontogramas => _Odontograma;

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
    data['Odontograma'] = this._Odontograma;
    return data;
  }
}
