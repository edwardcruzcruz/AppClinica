import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_app/Utils/Constantes.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/models/Doctor.dart';
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
  String _API_KEY = "";
  final JsonDecoder _decoder = new JsonDecoder();
  var storageService = locator<Var_shared>();

  Future<User> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(username+"hey");
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.fromJson(res["user"]);
    });
  }
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
  Future<http.Response> save_user(String name,String lastname,String NTelefono,String Direccion, String FeNacimiento, String Genero, String correo,String password1,String password2) {
    return http
        .post(SAVE_URL,body: {
          "nombre": lastname,
          "username": name,
          "telefono": NTelefono,
          "direccion": Direccion,
          "fechaNacimiento": FeNacimiento,
          "sexo": Genero,
          "email": correo,
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
    });
  }
}