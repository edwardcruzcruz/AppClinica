import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Metodos_http {
  // next three lines makes this class a Singleton
  static Metodos_http _instance = new Metodos_http.internal();
  Metodos_http.internal();
  factory Metodos_http() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url,{Map headers}) {
    return http.get(url,headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);
      print(res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}