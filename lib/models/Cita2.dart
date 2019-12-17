class Cita2 {
  final int _cita_id;
  final int _cliente;
  final int _especialidad;
  final int _tratamiento;
  final int _fechaHora;
  final int _doctor;
  final bool _is_finished;
  final bool _recordatorio;


  Cita2(this._cita_id, this._cliente, this._especialidad, this._tratamiento,
      this._fechaHora, this._doctor, this._is_finished, this._recordatorio);

  int get cita_id => _cita_id;

  Cita2.fromJson(Map<String, dynamic> json)
      : _cita_id = json['cita_id'],
        _cliente = json['cliente'],
        _especialidad=json['especialidad'],
        _tratamiento = json['tratamiento'],
        _fechaHora= json['fechaHora'],
        _doctor= json['doctor'],
        _is_finished= json['is_finished'],
        _recordatorio= json['recordatorio'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cita_id']=this._cita_id;
    data['cliente']=this._cliente;
    data['especialidad']=this._especialidad;
    data['tratamiento']=this._tratamiento;
    data['fechaHora']=this._fechaHora;
    data['doctor']=this._doctor;
    data['is_finished']=this._is_finished;
    data['recordatorio']=this._recordatorio;
    return data;
  }

  int get cliente => _cliente;

  bool get recordatorio => _recordatorio;

  bool get is_finished => _is_finished;

  int get doctor => _doctor;

  int get fechaHora => _fechaHora;

  int get tratamiento => _tratamiento;

  int get especialidad => _especialidad;
}