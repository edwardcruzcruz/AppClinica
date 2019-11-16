class HorarioRango {
  final int _id;
  final String _horaInicio;
  final String _horaFin;

  HorarioRango(this._id,this._horaInicio,this._horaFin);
  HorarioRango.fromJson(Map<String, dynamic> json):
        _id= json['id'],
        _horaInicio= json['horaInicio'],
        _horaFin = json['horaFin'];

  int get IdHorario => _id;
  String get HorarioInicio => _horaInicio;
  String get Horariofin => _horaFin;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['horaInicio']=this._horaInicio;
    data['horaFin']=this._horaFin;
    return data;
  }
}