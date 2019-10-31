import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_app/Utils/Constantes.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Cita.dart';
import 'package:flutter_app/models/Doctor.dart';
import 'package:flutter_app/models/Especialidad.dart';
import 'package:flutter_app/models/Horario.dart';
import 'package:flutter_app/services/Metodos_http.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Utils/Shared_Preferences.dart';

class RestDatasource {

  Metodos_http _netUtil = new Metodos_http();
  static final BASE_URL = Constantes.serverdomain;
  static final LOGIN_URL = BASE_URL + Constantes.urilogin;
  static final PERFIL_URL = BASE_URL + Constantes.uriClientes;
  static final SAVE_URL = BASE_URL + Constantes.uriregistrar;
  static final DOCTORES_URL= BASE_URL + Constantes.uriDoctores;
  static final HORARIO_DOCTORES_URL= BASE_URL + Constantes.uriHorariosDoctores;
  static final ESPECIALIDADES_URL=BASE_URL + Constantes.uriEspecialidad;
  static final CITAS_URL=BASE_URL + Constantes.uriCitas;

  String _API_KEY = "";
  final JsonDecoder _decoder = new JsonDecoder();
  var storageService = locator<Var_shared>();

  Future<User> perfil(String email) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    /*return http.get(
      PERFIL_URL,
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );*/
    return _netUtil.get(PERFIL_URL,
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
         HttpHeaders.authorizationHeader: "token $_API_KEY"}
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
  Future<List<Doctor>> doctoresEspecialidad(String especialidad) {
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
  Future<http.Response> save_cita(int idPaciente,int idEspecialidad, int idTratamiento,int idHorario,int IdDoctor) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    Map map = {
        "cliente": idPaciente,
        "especialidad": idEspecialidad,
        "tratameinto": idTratamiento,
        "fechaHora": idHorario,
        "doctor":IdDoctor
    };

    return http.post(CITAS_URL,
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
  /*Future<http.Response> save_cita(Cita cita) {
    _API_KEY=_decoder.convert(storageService.getuser)['token'];
    return http.post(CITAS_URL,
        body: {
        "cliente": cita.Paciente,
        "especialidad": cita.Especialidad,
        "tratameinto": "Reparación de dientes",
        "fechaHora": cita.Fecha,
        "doctor":cita.IdDoctor
        },
        headers: {HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded", // or whatever
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
  }*/
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

  Future<http.Response> postLogin(String username, String password) {
    return http
        .post(LOGIN_URL, body: {
          //"token": _API_KEY,
          "username": username,
          "password": password
        }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
  }
  Future<http.Response> save_user(String name,String lastname,String NTelefono,String Direccion, String FeNacimiento, String Genero, String correo,String password1) {
      Map<String,dynamic> body=  {
        "nombre": lastname,
        "apellido": name,
        "telefono": NTelefono,
        "direccion": Direccion,
        "fechaNacimiento": FeNacimiento,
        "sexo": Genero,
        "email": correo,
        "password": password1
      };
    Map<String,String> headers = {
      'Content-type' : 'application/x-www-form-urlencoded',
      'Accept': 'application/x-www-form-urlencoded',
    };
    return http.post(SAVE_URL,body: body).then((dynamic response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);

      if (statusCode < 200 || statusCode > 400 ) {
        throw new Exception("Error while fetching data");
      }
      return response;
    });
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
}