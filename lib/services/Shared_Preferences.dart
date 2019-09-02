import 'dart:convert';

import 'package:flutter_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
Future setupLocator() async {
  var instance = await Shared_Preferences.getInstance();
  locator.registerSingleton<Shared_Preferences>(instance);
}

class Shared_Preferences {//singleton: una clase que solo pueda acceder a una sola instancia.. evitando instancias repetidas
// database table and column names
  static Shared_Preferences _instance;
  static SharedPreferences _preferences;
  static const String UserKey = 'user';


  static Future<Shared_Preferences> getInstance() async {
    if (_instance == null) {
      _instance = Shared_Preferences();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }
  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }
    return User.fromJson(json.decode(userJson));
  }
  set user(User userToSave) {
    saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }
  dynamic _getFromDisk(String key) {
    var value  = _preferences.get(key);
    //print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }
  void saveStringToDisk(String key, String content){
    //print('(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences.setString(UserKey, content);
  }
}
