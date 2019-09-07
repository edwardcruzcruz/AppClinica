class Cita {
  final String paciente;
  final String especialidad;
  final String tipo_Consulta;
  final String hora;//esto es..(abajo)
  final String fecha;//un modelo mas llamado horarios, tipo programacion con un solo horario en una emisora de radio
  final String tiempo_duracion;//tiempo por cita --> es proporcional a la especialidad y tipo de consulta


  Cita({this.paciente, this.especialidad,this.tipo_Consulta,this.hora,this.fecha,this.tiempo_duracion});
  Cita.fromJson(Map<String, dynamic> json)
      : paciente = json['paciente'],
        especialidad = json['especialidad']
        tipo_Consulta= json['tipo_Consulta'],
        hora = json['hora'],
        fecha = json['fecha'],
        tiempo_duracion = json['tiempo_duracion'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paciente']=this.paciente;
    data['especialidad']=this.especialidad;
    data['tipo_Consulta']=this.tipo_Consulta;
    data['hora']=this.hora;
    data['fecha']=this.fecha;
    data['tiempo_duracion']=this.tiempo_duracion;
    return data;
  }
}