class UserR {
  final String _nombre;
  final String _apellido;
  final String _noTelefono;
  final String _direccion;
  final String _fecha_nacimiento;
  final String _cedula;
  final String _sexo;
  final String _correo;
  final String _contrasena;


  UserR(this._nombre, this._apellido,this._noTelefono,this._direccion,this._fecha_nacimiento,this._sexo,this._cedula,this._correo,this._contrasena);
  UserR.fromJson(Map<String, dynamic> json)
      : _nombre = json['nombre'],
        _apellido = json['apellido'],
        _noTelefono = json['telefono'],
        _direccion = json['direccion'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _sexo = json['sexo'],
        _correo = json['email'],
        _cedula = json['cedula'],
        _contrasena = json['contraseña'];

  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Sexo => _sexo;
  String get Cedula => _cedula;
  String get Correo => _correo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['telefono'] = this._noTelefono;
    data['direccion'] = this._direccion;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['sexo'] = this._sexo;
    data['cedula'] = this._cedula;
    data['email'] = this._correo;
    data['password'] = this._contrasena;
    print(data);
    return data;
  }

}
