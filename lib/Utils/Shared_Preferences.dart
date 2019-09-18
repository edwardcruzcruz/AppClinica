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

  /*Metodo post para acceder al correo*/
  void save_user(String content){
    _preferences.setString("token", content);
  }
  void save_email(String content){
    _preferences.setString("email", content);
  }

  void delete_user(){
    _preferences.remove("token");
  }
  void delete_email(){
    _preferences.remove("email");
  }
}