import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter_app/Utils/Constantes.dart';
import 'package:flutter_app/Utils/service_locator.dart';
import 'package:flutter_app/services/Metodos_http.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/Utils/Shared_Preferences.dart';

class RestDatasource {
  // the unique ID of the application
  static const String _applicationId = "my_application_id";
  // the mobile device unique identity
  String _deviceIdentity = "";

  Metodos_http _netUtil = new Metodos_http();
  static final BASE_URL = Constantes.serverdomain;
  static final LOGIN_URL = BASE_URL + Constantes.urilogin;
  static final PERFIL_URL = BASE_URL + Constantes.uriClientes;
  static final SAVE_URL = BASE_URL + Constantes.uriregistrar;
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
  /*Future<http.Response> perfil(String email) async {
    //_API_KEY=_decoder.convert(storageService.getuser)['token'];
    _API_KEY="1f4179e022fec16c6869ceee02738bb7e6b976ba";
    Dio dio = Dio();
    Dio tokenDio = new Dio();
    String csrftoken;
    tokenDio.options = dio.options;
    //options.headers["csrfToken"]=_API_KEY;
    //var response = await Dio().post("http://etcruz.pythonanywhere.com/api/emisora/13/segmentos",
      //options: {csrftoken=options.headers["csrfToken"]=_API_KEY}
    //);
    //var csrf = await getCsrftoken();

    var response = await dio.post("http://etcruz.pythonanywhere.com/api/emisora/13/segmentos",
      options: new Options(
        headers: ,
          contentType: ContentType.parse("application/x-www-form-urlencoded")),
    );

    print("StatusCode: ");
    print(response.statusCode);
    print("Response cookie: ");   //THESE ARE NOT PRINTED
    print(response.headers);
    print(response.data);
    //return response;
  }*/
  Future<http.Response> perfil() {
    _API_KEY="1f4179e022fec16c6869ceee02738bb7e6b976ba";
    Map<String, String> headers = {"Content-type": "application/json"};
    return http.get(
      'http://etcruz.pythonanywhere.com/api/emisora/13/segmentos',
      // Send authorization headers to the backend.
      headers: {HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "token $_API_KEY"},
    );
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
  Future<http.Response> save_user(String username,String correo,String password) {
    return http
        .post(SAVE_URL,body: {
          "nombre": username,
          "email": correo,
          "password1": password,
          "password2": password
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