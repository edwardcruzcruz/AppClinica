class Doctor {
  final String _nombre;
  final String _apellido;
  final String _noTelefono;
  final String _correo;
  final String _genero;
  final String _especialidad;


  Doctor(this._nombre, this._apellido,this._noTelefono,this._genero,this._correo,this._especialidad);
  Doctor.fromJson(Map<String, dynamic> json)
      : _nombre = json['nombre'],
        _apellido = json['apellido'],
        _noTelefono = json['telefono'],
        _correo = json['email'],
        _genero = json['sexo'],
        _especialidad = json['especialidad'];

  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get Genero => _genero;
  String get Correo => _correo;
  String get Especialidad => _especialidad;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['telefono'] = this._noTelefono;
    data['sexo'] = this._genero;
    data['email'] = this._correo;
    data['especialidad'] = this._especialidad;
    return data;
  }
}
class DoctorList {
  final List<Doctor> doctores;

  DoctorList({
    this.doctores,
  });
  factory DoctorList.fromJson(List<dynamic> parsedJson) {

    List<Doctor> users = new List<Doctor>();

    return new DoctorList(
      doctores: users,
    );
  }
}
