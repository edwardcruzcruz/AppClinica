
class AplicarTratamientoCliente{
  final int _id;
  final String _diente;
  final String _propiedad;
  final String _fecha;


  AplicarTratamientoCliente(this._id,this._diente,this._propiedad,this._fecha);
  AplicarTratamientoCliente.fromJson(Map<String, dynamic> json)
      : _id = json['tratamiento'],
        _diente = json['diente'],
        _propiedad = json['propiedad'],
        _fecha = json['fecha'];

  int get Id => _id;
  String get NombreEspecialidad => _diente;
  String get Precio => _propiedad;
  String get Duracion => _fecha;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tratamiento'] = this._id;
    data['diente'] = this._diente;
    data['propiedad'] = this._propiedad;
    data['fecha'] = this._fecha;
    return data;
  }
}
