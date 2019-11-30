class Especialidad{
  final int _id;
  final String _especialidad;


  Especialidad(this._id,this._especialidad);
  Especialidad.fromJson(Map<String, dynamic> json)
      : _id = json['especialidad_id'],
        _especialidad = json['nombEspe'];

  int get Id => _id;
  String get NombreEspecialidad => _especialidad;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['especialidad_id'] = this._id;
    data['nombEspe'] = this._especialidad;
    return data;
  }
}
