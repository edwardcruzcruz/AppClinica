class AgendarResponse {
final int _cita_id;
final int _response;


AgendarResponse(this._cita_id, this._response);
AgendarResponse.fromJson(Map<String, dynamic> json)
    : _cita_id = json['cliente'],
      _response = json['especialidad'];


int get Cita => _cita_id;
int get Response => _response;

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['cliente']=this._cita_id;
data['especialidad']=this._response;
return data;
}
}