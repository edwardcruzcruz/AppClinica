class User {
  final String _nombre;
  final String _apellido;
  final String _noTelefono;
  final String _fecha_nacimiento;
  final String _padre;
  final String _sexo;
  final String _correo;
  final String _contrasena;


  User(this._nombre, this._apellido,this._noTelefono,this._fecha_nacimiento,this._padre,this._sexo,this._correo,this._contrasena);
  User.fromJson(Map<String, dynamic> json)
      : _nombre = json['nombre'],
        _apellido = json['apellido'],
        _noTelefono = json['telefono'],
        _fecha_nacimiento = json['fechaNacimiento'],
        _sexo = json['sexo'],
        _correo = json['email'],
        _padre = json['padre'],
        _contrasena = json['contraseña'];

  String get Nombre => _nombre;
  String get Apellido => _apellido;
  String get Telefono => _noTelefono;
  String get FechaNacimiento => _fecha_nacimiento;
  String get Sexo => _sexo;
  String get Padre => _padre;
  String get Correo => _correo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this._nombre;
    data['apellido'] = this._apellido;
    data['telefono'] = this._noTelefono;
    data['fechaNacimiento'] = this._fecha_nacimiento;
    data['sexo'] = this._sexo;
    data['padre'] = this._padre;
    data['email'] = this._correo;
    return data;
  }
}
class UserList {
  final List<User> usuarios;

  UserList({
    this.usuarios,
  });
  factory UserList.fromJson(List<dynamic> parsedJson) {

    List<User> users = new List<User>();

    return new UserList(
      usuarios: users,
    );
  }
}
