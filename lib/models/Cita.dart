class Cita {
  final String _paciente;
  final String _especialidad;
  final String _tratamiento;
  final String _fecha;//un modelo mas llamado horarios, tipo programacion con un solo horario en una emisora de radio
  final String _iddoctor;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta


  Cita(this._paciente, this._especialidad,this._tratamiento,this._fecha,this._iddoctor);
  Cita.fromJson(Map<String, dynamic> json)
      : _paciente = json['cliente'],
        _especialidad = json['especialidad'],
        _tratamiento=json['tratamiento'],
        _fecha = json['fechaHora'],
        _iddoctor= json['IdDoctor'];


  String get Paciente => _paciente;
  String get Especialidad => _especialidad;
  String get Tratamiento => _tratamiento;
  String get Fecha => _fecha;
  String get IdDoctor=> _iddoctor;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cliente']=this._paciente;
    data['especialidad']=this._especialidad;
    data['tratamiento']=this._tratamiento;
    data['fechaHora']=this._fecha;
    data['Doctor']=this._iddoctor;
    return data;
  }
}