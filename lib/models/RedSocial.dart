class RedSocial {
  final int _id;
  final String _nombre;
  final String _link;

  RedSocial(this._id,this._nombre,this._link);
  RedSocial.fromJson(Map<String, dynamic> json):
        _id= json['id'],
        _nombre= json['nombre'],
        _link = json['link'];

  int get IdHorario => _id;
  String get GetNombre => _nombre;
  String get GetLink => _link;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['nombre']=this._nombre;
    data['link']=this._link;
    return data;
  }
}