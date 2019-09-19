class User {
  final String _nombre;
  final String _apellido;
  final String _noTelefono;
  final String _fecha_nacimiento;
  final String _username;
  final String _correo;
  //final String _contrasena;


  User(this._nombre, this._apellido,this._noTelefono,this._fecha_nacimiento,this._username,this._correo);
  User.fromJson(Map<String, dynamic> json)
      : _nombre = json['nombre'],
        _apellido = json['apellido'],
        _noTelefono = json['telefono'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _correo = json['email'],
        _username = json['username'];

  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Usuario => _username;
  String get Correo => _correo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['telefono'] = this._noTelefono;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['username'] = this._username;
    data['email'] = this._correo;
    return data;
  }
}
