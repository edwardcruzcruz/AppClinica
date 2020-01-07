
class odontograma{
  final int _id;
  final String _diente;
  final String _imagen;


  odontograma(this._id,this._diente,this._imagen);
  odontograma.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _diente = json['diente'],
        _imagen = json['imagen'];

  int get Id => _id;
  String get Diente => _diente;
  String get Imagen => _imagen;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['diente'] = this._diente;
    data['propiedad'] = this._imagen;
    return data;
  }
}
