class PuntuacionClass{
  final int _id;
  final int _calificacion;

  PuntuacionClass(this._id, this._calificacion);
  PuntuacionClass.fromJson(Map<String, dynamic> json)
      : _id = json['pk'],
        _calificacion = json['calificacion'];

  int get Id => _id;
  int get Calificacion => _calificacion;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk']=this._id;
    data['calificacion']=this._calificacion;
    return data;
  }
}