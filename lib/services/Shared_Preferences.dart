import 'package:shared_preferences/shared_preferences.dart';

class Var_shared{//singleton: una clase que solo pueda acceder a una sola instancia.. evitando instancias repetidas
// database table and column names
  static Var_shared _instance;
  static SharedPreferences _preferences;
  static const String UserSession = '';

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
    var user = _preferences.getString(UserSession);
    if (user == null) {
      return null;
    }
    return user;
  }

  /*Metodo post para acceder al correo*/
  void save_user(String content){
    _preferences.setString(UserSession, content);
  }

  void delete_user(){
    _preferences.remove(UserSession);
  }
}
