class Horario {
  final int _id_horario;
  final String _fecha;
  final int _hora;
  final int _id_doctor;
  final bool _is_avaliable;

  Horario(this._id_horario,this._fecha,this._hora,this._id_doctor,this._is_avaliable);
  Horario.fromJson(Map<String, dynamic> json):
        _id_horario= json['horarios_id'],
         _fecha= json['fecha'],
        _hora = json['hora'],
        _id_doctor= json['doctor'],
        _is_avaliable= json['is_available'];

  int get IdHorario => _id_horario;
  String get Fecha => _fecha;
  int get Hora => _hora;
  int get IdDoctor => _id_doctor;
  bool get IsAvaliable => _is_avaliable;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['horarios_id']=this._id_horario;
    data['fecha']=this._fecha;
    data['hora']=this._hora;
    data['doctor']=this._id_doctor;
    data['is_available']=this._is_avaliable;
    return data;
  }
}