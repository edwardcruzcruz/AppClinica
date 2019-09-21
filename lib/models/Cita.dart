class Cita {
  final String _paciente;
  final String _especialidad;
  final String _hora;//esto es..(abajo)
  final String _fecha;//un modelo mas llamado horarios, tipo programacion con un solo horario en una emisora de radio
  final String _iddoctor;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta


  Cita(this._paciente, this._especialidad,this._hora,this._fecha,this._iddoctor);
  Cita.fromJson(Map<String, dynamic> json)
      : _paciente = json['paciente'],
        _especialidad = json['especialidad'],
        _hora= json['hora'],
        _fecha = json['fecha'],
        _iddoctor= json['IdDoctor'];


  String get Paciente => _paciente;
  String get Especialidad => _especialidad;
  String get Hora => _hora;
  String get Fecha => _fecha;
  String get IdDoctor=> _iddoctor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paciente']=this._paciente;
    data['especialidad']=this._especialidad;
    data['hora']=this._hora;
    data['fecha']=this._fecha;
    data['IdDoctor']=this._iddoctor;
    return data;
  }
}