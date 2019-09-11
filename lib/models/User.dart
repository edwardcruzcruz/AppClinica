class User {
  final String _nombre;
  final String _apellido;
  final String _noTelefono;
  final DateTime _fecha_nacimiento;
  final String _genero;
  final String _correo;
  final String _contrasena;


  User(this._nombre, this._apellido,this._noTelefono,this._fecha_nacimiento,this._genero,this._correo,this._contrasena);
  User.fromJson(Map<String, dynamic> json)
      : _nombre = json['nombre'],
        _apellido = json['apellido'],
        _noTelefono = json['noTelefono'],
        _fecha_nacimiento = json['fecha_nacimiento'],
        _genero = json['genero'],
        _correo = json['correo'],
        _contrasena = json['contrasena'];

  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  DateTime get FechaNacimiento => _fecha_nacimiento;
  String get Genero => _genero;
  String get Correo => _correo;
  String get Password => _contrasena;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['noTelefono'] = this._noTelefono;
    data['fecha_nacimiento'] = this._fecha_nacimiento;
    data['genero'] = this._genero;
    data['correo'] = this._correo;
    data['contrasena'] = this._contrasena;
    return data;
  }
}
