import 'dart:async';
import 'package:flutter_app/services/Metodos_http.dart';
import 'package:flutter_app/models/User.dart';

class RestDatasource {
  Metodos_http _netUtil = new Metodos_http();
  static final BASE_URL = "http://YOUR_BACKEND_IP/login_app_backend";
  static final LOGIN_URL = BASE_URL + "/login.php";
  static final _API_KEY = "somerandomkey";

  Future<User> login(String correo, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "token": _API_KEY,
      "correo": correo,
      "contrasena": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.fromJson(res["user"]);
    });
  }
}