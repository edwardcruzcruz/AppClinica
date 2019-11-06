class Cuenta {
  final int _idUsuario;
  final String _nombre;
  final String _apellido;
  final String _correo;
  final String _sexo;
  final String _noTelefono;
  final String _direccion;
  final String _fecha_nacimiento;
  final int _idCuentaPadre;
  //final String _contrasena;


  Cuenta(this._idUsuario,this._nombre, this._apellido,this._correo,this._sexo,this._noTelefono,this._direccion,this._fecha_nacimiento,this._idCuentaPadre);
  Cuenta.fromJson(Map<String, dynamic> json)
      : _idUsuario = json['id'],
        _nombre = json['nombre'],
        _apellido = json['apellido'],
        _correo = json['email'],
        _sexo = json['sexo'],
        _noTelefono = json['telefono'],
        _direccion = json['direccion'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _idCuentaPadre= json['idCuentaPadre'];

  int get Id => _idUsuario;
  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Correo => _correo;
  String get Sexo => _sexo;
  String get Direccion => _direccion;
  int get IdCuentaPadre => _idCuentaPadre;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['email'] = this._correo;
    data['sexo'] = this._sexo;
    data['telefono'] = this._noTelefono;
    data['direccion'] = this._direccion;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['idCuentaPadre'] = this._idCuentaPadre;
    return data;
  }
}