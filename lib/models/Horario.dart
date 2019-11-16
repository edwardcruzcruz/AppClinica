class Horario {
  final int _id_horario;
  final String _fecha;
  final int _hora;
  final int _id_doctor;

  Horario(this._id_horario,this._fecha,this._hora,this._id_doctor);
  Horario.fromJson(Map<String, dynamic> json):
        _id_horario= json['horarios_id'],
         _fecha= json['fecha'],
        _hora = json['hora'],
        _id_doctor= json['doctor'];

  int get IdHorario => _id_horario;
  String get Fecha => _fecha;
  int get Hora => _hora;
  int get IdDoctor => _id_doctor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horarios_id']=this._id_horario;
    data['fecha']=this._fecha;
    data['hora']=this._hora;
    data['persona']=this._id_doctor;
    return data;
  }
}