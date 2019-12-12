
class Tratamiento{
  final int _id;
  final String _especialidad;
  final String _precio;
  final String _duracion;


  Tratamiento(this._id,this._especialidad,this._precio,this._duracion);
  Tratamiento.fromJson(Map<String, dynamic> json)
      : _id = json['tratam_id'],
        _especialidad = json['descripcion'],
        _precio = json['precio'],
        _duracion = json['duracion'];

  int get Id => _id;
  String get NombreEspecialidad => _especialidad;
  String get Precio => _precio;
  String get Duracion => _duracion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tratam_id'] = this._id;
    data['descripcion'] = this._especialidad;
    data['precio'] = this._precio;
    data['duracion'] = this._duracion;
    return data;
  }
}
