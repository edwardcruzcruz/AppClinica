import 'package:shared_preferences/shared_preferences.dart';

class Var_shared{//singleton: una clase que solo pueda acceder a una sola instancia.. evitando instancias repetidas
// database table and column names
  static Var_shared _instance;
  static SharedPreferences _preferences;
  static const String TokenSession = '';
  //static const String emailSession = '';

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
    var token = _preferences.getString(TokenSession);
    if (token == null) {
      return null;
    }
    return token;
  }
  /*String get getemail {
    var user = _preferences.getString(emailSession);
    if (user == null) {
      return null;
    }
    return user;
  }*/

  /*Metodo post para acceder al correo*/
  void save_user(String content){
    _preferences.setString(TokenSession, content);
  }
  /*void save_email(String content){
    _preferences.setString(emailSession, content);
  }*/

  void delete_user(){
    _preferences.remove(TokenSession);
  }
  /*void delete_email(){
    _preferences.remove(emailSession);
  }*/
}
