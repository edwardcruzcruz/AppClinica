class Genero{
  final int _genero_id;
  final String _genero;


  Genero(this._genero_id,this._genero);
  Genero.fromJson(Map<String, dynamic> json)
      : _genero_id = json['genero_id'],
        _genero = json['genero'];

  int get Id => _genero_id;
  String get Getgenero => _genero;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genero_id'] = this._genero_id;
    data['genero'] = this._genero;
    return data;
  }
}
