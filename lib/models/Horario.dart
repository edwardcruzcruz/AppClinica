class Horario {
  final String _fecha;
  final String _hora;
  final int _id_doctor;

  Horario(this._fecha,this._hora,this._id_doctor);
  Horario.fromJson(Map<String, dynamic> json):
         _fecha= json['fecha'],
        _hora = json['hora'],
        _id_doctor= json['persona'];

  String get Fecha => _fecha;
  String get Hora => _hora;
  int get IdDoctor => _id_doctor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fecha']=this._fecha;
    data['hora']=this._hora;
    data['persona']=this._id_doctor;
    return data;
  }
}