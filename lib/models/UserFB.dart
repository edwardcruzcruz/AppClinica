class UserFB {
  final int _idUsuario;
  final String _nombre;
  final String _apellido;
  final String _correo;
  final int _sexo;
  final String _noTelefono;
  final String _direccion;
  final String _fecha_nacimiento;
  final String _cedula;
  final int _idPadre;


  UserFB(this._idUsuario,this._nombre, this._apellido,this._correo,this._sexo,this._noTelefono,this._direccion,this._fecha_nacimiento,this._cedula,this._idPadre);
  UserFB.fromJson(Map<String, dynamic> json)
      : _idUsuario = json['id'],
        _nombre = json['nombre'],
        _apellido = json['apellido'],
        _correo = json['email'],
        _sexo = json['sexo'],
        _noTelefono = json['telefono'],
        _direccion = json['direccion'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _cedula = json['cedula'],
        _idPadre = json['id_Padre'];

  int get Id => _idUsuario;
  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Correo => _correo;
  int get Sexo => _sexo;
  String get Direccion => _direccion;
  String get Cedula => _cedula;
  int get IdPadre => _idPadre;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['email'] = this._correo;
    data['sexo'] = this._sexo;
    data['telefono'] = this._noTelefono;
    data['direccion'] = this._direccion;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['cedula'] = this._fecha_nacimiento;
    data['id_Padre'] = this._fecha_nacimiento;
    return data;
  }
}
