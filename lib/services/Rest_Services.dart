import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/Utils/Constantes.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/AgendarResponse.dart';
import 'package:flutter_app/models/Carrito.dart';
import 'package:flutter_app/models/Cita2.dart';
import 'package:flutter_app/models/Clinica.dart';
import 'package:flutter_app/models/CitaCompleta.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Cuenta.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/HistorialClinico.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/models/HorarioRango.dart';
import 'package:flutter_app/models/Noticia.dart';
import 'package:flutter_app/models/Receta.dart';
import 'package:flutter_app/models/RegisterUser.dart';
import 'package:flutter_app/services/Metodos_http.dart';
import 'package:flutter_app/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class RestDatasource {

  Metodos_http _netUtil = new Metodos_http();
  static final BASE_URL = Constantes.serverdomain;
  static final LOGIN_URL = BASE_URL + Constantes.urilogin;
  static final LOGINFB_URL = BASE_URL + Constantes.uriloginfb;
  static final PERFIL_URL = BASE_URL + Constantes.uriClientes;
  static final SAVE_URL = BASE_URL + Constantes.uriregistrar;
  static final SAVEFB_URL = BASE_URL + Constantes.uriregistrarFb;
  static final DOCTORES_URL= BASE_URL + Constantes.uriDoctores;
  static final HORARIOID_URL= BASE_URL + Constantes.uriHorarioID;
  static final HORARIO_DOCTORES_URL= BASE_URL + Constantes.uriHorariosDoctores;
  static final HISTORIAL_URL= BASE_URL + Constantes.uriHistorialporID;
  static final CUENTAS_ASOCIADAS_URL= BASE_URL + Constantes.uriCuentasAsociadas;
  static final ESPECIALIDADES_URL=BASE_URL + Constantes.uriEspecialidad;
  static final CITAS_URL=BASE_URL + Constantes.uriCitas;
  static final CITA_URL=BASE_URL + Constantes.uriCita;
  static final CITA_URL_UPDATE=BASE_URL + Constantes.uriCitaId;
  static final INFO_URL=BASE_URL + Constantes.uriInfo;
  static final SUGERENCIA_URL=BASE_URL + Constantes.uriSugerncia;
  static final NOTICIAS_URL=BASE_URL + Constantes.uriNoticias;
  static final CARRITO_URL=BASE_URL + Constantes.uriCarrito;
  static final COMENTAR_CITA_URL=BASE_URL + Constantes.uricometario;
  static final CALIFICAR_CITA_URL=BASE_URL + Constantes.uripuntuacion;
  static final RECETA_USUARIO_URL=BASE_URL + Constantes.uriRecetaUsuario;
  static final SHOP_URL=BASE_URL + Constantes.uriShop;
  static final PREPARE_SHOP_URL=BASE_URL + Constantes.uriPrepareShop;

  String _API_KEY = "";
  final JsonDecoder _decoder = new JsonDecoder();
  var storageService = locator<Var_shared>();

  Future<http.Response> perfil(int id,Cuenta usuario) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*return http.get(
      PERFIL_URL,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );*/
    return http.patch(PERFIL_URL+id.toString()+"/",headers: {HttpHeaders.contentTypeHeader: "application/json", // application/json
      HttpHeaders.authorizationHeader: "token $_API_KEY"},body: utf8.encode(json.encode(usuario.toJson()))).then((dynamic response) {//cuentamodifi.toJson()
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }
  Future<http.Response> delete_AsoAccount(int idUser) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return http.delete(PERFIL_URL+idUser.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }
  Future<User> perfilfb(String email) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*return http.get(
      PERFIL_URL,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );*/
    return _netUtil.get(PERFIL_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}//
    ).then((dynamic res) {
      User response=null;
      if(res!=null){
        var usuarios = res.map((i)=>User.fromJson(i)).toList();
        for(final usuario in usuarios){
          //print(usuario.Correo);
          if(email==usuario.Correo){
            response= usuario;
          }
        }
        return response;
      }
      return null;
    });
  }
  Future<User> getUser(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*return http.get(
      PERFIL_URL,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );*/
    return _netUtil.get(PERFIL_URL+id.toString(),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}//
    ).then((dynamic res) {
      User response=null;
      if(res!=null){
        response = User.fromJson(res);
        print("##################################################");
        print(response);
        return response;
      }
      return null;
    });
  }
  Future<User> perfilfbByFLName(String FName,String LName) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*return http.get(
      PERFIL_URL,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );*/
    return _netUtil.get(PERFIL_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}//
    ).then((dynamic res) {
      User response=null;
      if(res!=null){
        var usuarios = res.map((i)=>User.fromJson(i)).toList();
        for(final usuario in usuarios){
          //print(usuario.Correo);
          if(FName==usuario.Nombre && LName==usuario.Apellido){
            response= usuario;
          }
        }
        return response;
      }
      return null;
    });
  }

  Future<List<Especialidad>> ListaEspecialidad() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(ESPECIALIDADES_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      List<Especialidad> response=new List<Especialidad>();
      if(res!=null){
        var especialidades = res.map((i)=>Especialidad.fromJson(i)).toList();
        for(final especialidad in especialidades){
            response.add(especialidad);
        }
        return response;
      }
      return null;
    });
  }

  Future<List<Doctor>> doctoresEspecialidad(int especialidad) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(DOCTORES_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      List<Doctor> response=new List<Doctor>();
      if(res!=null){
        var doctores = res.map((i)=>Doctor.fromJson(i)).toList();
        for(final doctor in doctores){
          print(especialidad);
          print(doctor.Especialidad);
          if(especialidad==doctor.Especialidad){
            print("hola");
            response.add(doctor);
          }
        }
        return response;
      }
      return null;
    });
  }

  Future<Doctor> doctoresId(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(DOCTORES_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      Doctor response=null;
      if(res!=null){
        var doctores = res.map((i)=>Doctor.fromJson(i)).toList();
        for(final doctor in doctores){
          if(id==doctor.Id){
            print("hola");
            response=doctor;
          }
        }
        return response;
      }
      return null;
    });
  }

  Future<HorarioRango> HorarioId(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return _netUtil.get(HORARIOID_URL+id.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      HorarioRango hr=HorarioRango.fromJson(res);
      //HorarioRango horario=new HorarioRango(int.parse(res.id), res.horaInicio.toString(), res.horaFin.toString());
      if(hr!=null){
        return hr;
      }
      return null;
    });
  }

  Future<List<CitaCompleta>> ListarCitas() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return _netUtil.get(CITAS_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      print(res);
      List<CitaCompleta> response=new List<CitaCompleta>();
      if(res!=null){
        var citas = res.map((i)=>CitaCompleta.fromJson(i)).toList();
        for(final cita in citas){
          response.add(cita);
        }
        return response;
      }
      return null;
    });
  }

  Future<http.Response> save_puntuacion(int idCita,double puntuacion) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "calificacion": puntuacion,
      "id_cita": idCita,
      "id_cliente": storageService.getIdPadre
    };

    return http.post(CALIFICAR_CITA_URL,
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final int statusCode = res.statusCode;
      print(statusCode);
      print(res.body);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<http.Response> save_comentario(int idCita,String descripcion) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "descripcion": descripcion,
      "id_cita": idCita,
      "id_cliente": storageService.getIdPadre
    };
    print(map);
    return http.post(COMENTAR_CITA_URL,
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final int statusCode = res.statusCode;
      print(statusCode);
      print(res.body);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<AgendarResponse> save_cita(int idPaciente,int idEspecialidad, int idTratamiento,int idHorario,int IdDoctor) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
        "cliente": idPaciente,
        "especialidad": idEspecialidad,
        "tratameinto": idTratamiento,
        "fechaHora": idHorario,
        "doctor":IdDoctor,
        "is_finished":false,
        "recordatorio":false
    };

    return http.post(CITA_URL,
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final int statusCode = res.statusCode;
      print(statusCode);
      print(res.body);
      var enc=json.decode(res.body);
      print(enc);
      final int cita_id=enc['cita_id'];
      var response=AgendarResponse(cita_id,statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }
  //
  Future<http.Response> save_shop(int idPaciente, int idTratamiento,int IdCita) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "id_Cliente": idPaciente,
      "id_Tratamiento": idTratamiento,
      "valorFaltante": 0,
      "cita_id":IdCita,
    };

    return http.post(SHOP_URL,
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final int statusCode = res.statusCode;
      print("*********************************************");
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<http.Response> save_sugerencia(int idPaciente,String modelo, String Sugerencia) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "id_Cliente": idPaciente,
      "modeloCelular": modelo,
      "sugerencia": Sugerencia,
      //"is_finished":true;
    };

    return http.post(SUGERENCIA_URL,
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<Horario> HorarioDoctorbyId(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return _netUtil.get(HORARIO_DOCTORES_URL+id.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      Horario hr=Horario.fromJson(res);
      //HorarioRango horario=new HorarioRango(int.parse(res.id), res.horaInicio.toString(), res.horaFin.toString());
      print("//////////////////////////////////////////////////////////////////");
      print(hr.Hora);
      if(hr!=null){
        return hr;
      }
      return null;
    });
  }
  /*acaaaaa*/
  Future<List<HistorialClinico>> HistorialId(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return _netUtil.get(HISTORIAL_URL+id.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      print(res);
      List<HistorialClinico> response=new List<HistorialClinico>();
      if(res!=null){
        var historiales = res.map((i)=>HistorialClinico.fromJson(i)).toList();
        for(final historial in historiales){
          response.add(historial);
        }
        return response;
      }
      return null;
      //print(res.toString());
      /*HistorialClinico hr=HistorialClinico.fromJson(res);
      //HorarioRango horario=new HorarioRango(int.parse(res.id), res.horaInicio.toString(), res.horaFin.toString());
      if(hr!=null){
        return hr;
      }
      return null;*/
    });
  }

  Future<http.Response> CambiarDisponibilidadHorarioDoctor(int id,Horario horario) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "fecha": horario.Fecha,
      "hora": horario.Hora,
      "doctor": horario.IdDoctor,
      "is_available": horario.IsAvaliable==true?false:true,
      //"is_finished":true;
    };
    print("*-*****-*-*-*-*-*-*-*-*-*-*-*-*-*-");
    print(map);
    return http.put(HORARIO_DOCTORES_URL+id.toString()+"/",
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      print(resp);
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<http.Response> CambiarDisponibilidadHorarioDoctorPatch(int id) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "is_available": true,
      //"is_finished":true;
    };

    return http.patch(HORARIO_DOCTORES_URL+id.toString()+"/",
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<List<Horario>> HorarioDoctor(int idDoctor) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(HORARIO_DOCTORES_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      List<Horario> response=new List<Horario>();
      if(res!=null){
        var horarios = res.map((i)=>Horario.fromJson(i)).toList();
        for(final horario in horarios){
          //print(especialidad);
          //print(doctor.Especialidad);
          if(idDoctor==horario.IdDoctor){
            //print("hola");
            response.add(horario);
          }
        }
        return response;
      }
      return null;
    });
  }

  Future<Cuenta> CuentasByMaster(int idPadre) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(CUENTAS_ASOCIADAS_URL+idPadre.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      //print(res.toString());
      Cuenta acc=Cuenta.fromJson(res);
      //HorarioRango horario=new HorarioRango(int.parse(res.id), res.horaInicio.toString(), res.horaFin.toString());
      if(acc!=null){
        return acc;
      }
      return null;
    });
  }
  Future<List<Clinica>> InfoClinica() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(INFO_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      List<Clinica> response=new List<Clinica>();
      if(res!=null){
        var infos = res.map((i)=>Clinica.fromJson(i)).toList();
        for(final info in infos){
          //print(especialidad);
          //print(doctor.Especialidad);
          response.add(info);
        }
        return response;
      }
      return null;
      //print(res.body);
      Clinica acc=null;
      return res.map((i)=>Clinica.fromJson(i)).toList();
    });
  }
  Future<List<Noticia>> ListaNoticias() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(NOTICIAS_URL,
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      List<Noticia> response=new List<Noticia>();
      if(res!=null){
        var especialidades = res.map((i)=>Noticia.fromJson(i)).toList();
        for(final especialidad in especialidades){
          response.add(especialidad);
        }
        return response;
      }
      return null;
    });
  }

  Future<http.Response> postLogin(String username, String password) {
    return http
        .post(LOGIN_URL, body: {
          //"token": _API_KEY,
          "username": username,
          "password": password
        }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(res);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }

  Future<http.Response> postLoginFB(String token) {
    return http
        .post(LOGINFB_URL, body: {
      //"token": _API_KEY,
      "access_token": token,
      "code": ""
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }

  Future<http.Response> save_user(UserR usuario) {
    /*Map<String,dynamic> body=  {
      "nombre": lastname,
      "apellido": name,
      "telefono": NTelefono,
      "direccion": Direccion,
      "fechaNacimiento": FeNacimiento,
      "sexo": Genero,
      "cedula":cedula,
      "email": correo,
      "password": password1
    };*/
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json ',
    };
    return http.post(SAVE_URL,headers: headers,body: jsonEncode(usuario.toJson())).then((dynamic response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);
      print(res);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });

  }

  Future<http.Response> edit_user(int id,Cuenta cuentamodifi) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*Map<String,dynamic> body=  {
      'id' : cuentamodifi.Id,
      'nombre' : cuentamodifi.Nombre,
      'apellido' : cuentamodifi.Apellido,
      'email' : cuentamodifi.Correo,
      'sexo' : cuentamodifi.Sexo,
      'telefono' : cuentamodifi.Telefono,
      'direccion' : cuentamodifi.Direccion,
      'fechaNacimiento' : cuentamodifi.FechaNacimiento,
      'cedula' : cuentamodifi.Cedula,
      'id_padre' : cuentamodifi.ListCuentasAsociads
    };*/
    return http.patch(CUENTAS_ASOCIADAS_URL+id.toString()+"/",headers: {HttpHeaders.contentTypeHeader: "application/json", // application/json
      HttpHeaders.authorizationHeader: "token $_API_KEY"},body: utf8.encode(json.encode(cuentamodifi.toJson()))).then((dynamic response) {//cuentamodifi.toJson()
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }
  Future<http.Response> save_userfb(String name,String lastname,String NTelefono,String Direccion, String FeNacimiento,String Genero,String cedula, String correo,String id_padre) {

    Map<String,dynamic> body=  {
      "nombre": name,
      "apellido": lastname,
      "email": correo,
      "id_Sexo": Genero,
      "telefono": NTelefono,
      "direccion": Direccion,
      "fechaNacimiento": FeNacimiento,
      "cedula":cedula,
      "id_Padre":id_padre,
    };
    Map<String,String> headers = {
      'Content-type' : 'application/x-www-form-urlencoded',
    };
    Map<String, String> headers1 = {"Content-type": "application/json",'Accept': 'application/json',};
    /*return http.post(SAVEFB_URL,headers: headers,body: body).then((dynamic response) {
      final int statusCode = response.statusCode;
      //print(statusCode);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });*/
    return http.post(SAVEFB_URL,headers: headers, body: body)/*.then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(res);
      if (statusCode < 201 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    })*/;
    /*return http
        .post(SAVE_URL,body: {
          "nombre": lastname,
          "username": name,
          "telefono": NTelefono,
          "direccion": Direccion,
          "fechaNacimiento": FeNacimiento,
          "sexo": Genero,
          "email": correo,
          "id_padre": id_padre,
          "password1": password1,
          "password2": password2
        }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });*/
  }

  Future<List<CarritoCompra>> ListaCarritos() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(CARRITO_URL+storageService.getIdPadre.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      List<CarritoCompra> response=new List<CarritoCompra>();
      if(res!=null){
        var carritos = res.map((i)=>CarritoCompra.fromJson(i)).toList();
        print("------------------------");
        for(final carrito in carritos){
          carrito.seleccionado(false);
          print(carrito.toString());
          response.add(carrito);
        }

        return response;
      }
      return null;
    });
  }

  Future<http.Response> delete_cita(int idCita) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "is_finished": true
    };

    return http.patch(CITA_URL_UPDATE+idCita.toString()+"/",
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<http.Response> update_cita(int idPaciente,int idEspecialidad, int idTratamiento,int idHorario,int IdDoctor,int idCita) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "fechaHora": idHorario,
      //"is_finished":true;
    };

    return http.patch(CITA_URL_UPDATE+idCita.toString()+"/",
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }
  Future<http.Response> update_cita_recordatorio(int idCita,bool recordatorio) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
      "recordatorio": recordatorio
    };

    return http.patch(CITA_URL_UPDATE+idCita.toString()+"/",
        body: utf8.encode(json.encode(map)),
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      final String resp = res.body;
      final int statusCode = res.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<Cita2> get_cita(int idCita) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];

    return _netUtil.get(CITA_URL_UPDATE+idCita.toString()+"/",
        headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"}
    ).then((dynamic res) {
      Cita2 hr=Cita2.fromJson(res);
      //HorarioRango horario=new HorarioRango(int.parse(res.id), res.horaInicio.toString(), res.horaFin.toString());
      if(hr!=null){
        return hr;
      }
      return null;
    });
  }

  Future<List<Receta>> ListarRecetas(int idUsuario) {
    var queryParameters = {
      'usuario': '8',
    };
    Uri uri =
    Uri.https('jacelly.pythonanywhere.com','/api/v1/receta/', queryParameters);
    print("*************************URI**********************************");
    print(uri);
    print("***********************************************************");
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(RECETA_USUARIO_URL+idUsuario.toString(),//idUsuario.toString()+"/",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"
        }
    ).then((dynamic res) {
      List<Receta> response=new List<Receta>();

      if(res!=null){
        print("*************************RES**********************************");
        print(res);
        var recetas = res.map((i)=>Receta.fromJson(i)).toList();
        print("*************************RECETAS**********************************");
        print(recetas);
        for(final receta in recetas){
          print(receta);
          if(receta.RecetaPorCita.length>0){
            response.add(receta);
          }
        }
        print("***********************************************************");
        print(response);
        return response;
      }
      print("***************************NULL********************************");
      return null;
    });
  }

  Future<List<Receta>> ListarRecetasCitas(int idUsuario) {
    var queryParameters = {
      'usuario': idUsuario.toString(),
    };
    Uri uri =
    Uri.https('jacelly.pythonanywhere.com','/api/v1/receta/', queryParameters);
    print("*************************URI**********************************");
    print(uri);
    print("***********************************************************");
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(RECETA_USUARIO_URL+idUsuario.toString(),//idUsuario.toString()+"/",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"
        }
    ).then((dynamic res) {
      List<Receta> response=new List<Receta>();

      if(res!=null){
        print("*************************RES**********************************");
        print(res);
        var recetas = res.map((i)=>Receta.fromJson(i)).toList();
        print("*************************RECETAS**********************************");
        print(recetas);
        for(final receta in recetas){
          print(receta.IsFinished);
          if(!receta.IsFinished){
            response.add(receta);
          }
        }
        print("***********************************************************");
        print(response);
        return response;
      }
      print("***************************NULL********************************");
      return null;
    });
  }

  Future<List<Receta>> ListarRecetasCitasAnteriores(int idUsuario) {
    var queryParameters = {
      'usuario': idUsuario.toString(),
    };
    Uri uri =
    Uri.https('jacelly.pythonanywhere.com','/api/v1/receta/', queryParameters);
    print("*************************URI**********************************");
    print(uri);
    print("***********************************************************");
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get(RECETA_USUARIO_URL+idUsuario.toString(),//idUsuario.toString()+"/",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"
        }
    ).then((dynamic res) {
      List<Receta> response=new List<Receta>();

      if(res!=null){
        print("*************************RES ANTERIORES**********************************");
        print(res);
        var recetas = res.map((i)=>Receta.fromJson(i)).toList();
        print("*************************CITAS ANTERIORES**********************************");
        print(recetas);
        for(final receta in recetas){
          print(receta);
          if(receta.IsFinished){
            response.add(receta);
          }
        }
        print("*************************LAREPUTAMADRE**********************************");
        print(response);
        return response;
      }
      print("***************************NULL********************************");
      return null;
    });
  }

  Future<String> getPagosVentana() {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return _netUtil.get3("http://192.168.1.8:8000/Pagos/pruebaPago/",//idUsuario.toString()+"/",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json", // or whatever
          HttpHeaders.authorizationHeader: "token $_API_KEY"
        }
    )
        .then((dynamic res) {
      var document = parse(res);
      print(document.outerHtml);
      //print(res);
      if(res!=null){
        print("*************************RES HTML**********************************");
        print(res);
        return res;
      }
      print("***************************NULL********************************");
      return null;
    });
  }

  Future<http.Response> actualizar_shop(int shop,bool pago_creado) {
    Map<String,dynamic> body=  {
      "id": shop,
      "pago_creado":pago_creado
    };
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json ',
    };
    return http.post(PREPARE_SHOP_URL,headers: headers,body: utf8.encode(json.encode(body))).then((dynamic response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);
      print(res);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });

  }
}
