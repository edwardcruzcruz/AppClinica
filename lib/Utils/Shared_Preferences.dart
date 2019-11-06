import 'package:shared_preferences/shared_preferences.dart';

class Var_shared{//singleton: una clase que solo pueda acceder a una sola instancia.. evitando instancias repetidas
// database table and column names
  static Var_shared _instance;
  static SharedPreferences _preferences;

  static Future<Var_shared> getInstance() async {
    if (_instance == null) {
      _instance = Var_shared();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  /*Metodo get para acceder al correo*/
  String get getuser {
    var token = _preferences.getString("token");
    if (token == null) {
      return null;
    }
    return token;
  }
  String get getEmail {
    var email = _preferences.getString("email");
    if (email == null) {
      return null;
    }
    return email;
  }
  int get getIdPadre {
    var padre = _preferences.getInt("idPadre");
    if (padre == null) {
      return null;
    }
    return padre;
  }
  String get getCuentaActual {
    var nombreCuenta = _preferences.getString("currentAccount");
    if (nombreCuenta == null) {
      return null;
    }
    return nombreCuenta;
  }
  int get getIdHijo {
    var padre = _preferences.getInt("idHijo");
    if (padre == null) {
      return null;
    }
    return padre;
  }

  String get getUsername {
    var username = _preferences.getString("username");
    if (username == null) {
      return null;
    }
    return username;
  }

  /*Metodo post para acceder al correo*/
  void save_user(String content){
    _preferences.setString("token", content);
  }
  void save_username(String content){
    _preferences.setString("username", content);
  }
  void save_currentAccount(String content){
    _preferences.setString("currentAccount", content);
  }
  void save_email(String content){
    _preferences.setString("email", content);
  }
  void save_idPadre(int content){
    _preferences.setInt("idPadre", content);
  }
  void save_idHijo(int content){
    _preferences.setInt("idHijo", content);
  }
  void delete_user(){
    _preferences.remove("token");
  }
  void delete_idPadre(){
    _preferences.remove("idPadre");
  }
  void delete_idHijo(){
    _preferences.remove("idHijo");
  }
  void delete_email(){
    _preferences.remove("email");
  }
  void delete_currentAccount(){
    _preferences.remove("currentAccount");
  }
  void delete_username(){
    _preferences.remove("username");
  }
}