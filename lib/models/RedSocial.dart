class RedSocial {
  final String _nombre;
  final String _link;

  RedSocial(this._nombre,this._link);
  RedSocial.fromJson(Map<String, dynamic> json):
        _nombre= json['nombre'],
        _link = json['link'];

  String get GetNombre => _nombre;
  String get GetLink => _link;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre']=this._nombre;
    data['link']=this._link;
    return data;
  }
}