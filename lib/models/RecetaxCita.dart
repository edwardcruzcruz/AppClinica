class RecetaxCita{
  final int _id;
  final String _medicina;
  final int _hora_Tratamiento;
  final int _duracion_Tratamiento_Dias;
  final bool _recordatorio;

  RecetaxCita(this._id,this._medicina, this._hora_Tratamiento,this._duracion_Tratamiento_Dias,this._recordatorio);
  RecetaxCita.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _medicina = json['medicina'],
        _hora_Tratamiento = json['hora_Tratamiento'],
        _duracion_Tratamiento_Dias=json['duracion_Tratamiento_Dias'],
        _recordatorio = json['recordatorio'];

  int get Id => _id;
  String get Medicina => _medicina;
  int get HoraTratamiento => _hora_Tratamiento;
  int get DuracionTratamiento => _duracion_Tratamiento_Dias;
  bool get Recordatorio => _recordatorio;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this._id;
    data['medicina']=this._medicina;
    data['hora_Tratamiento']=this._hora_Tratamiento;
    data['duracion_Tratamiento_Dias']=this._duracion_Tratamiento_Dias;
    data['recordatorio']=this._recordatorio;
    return data;
  }
}

