import 'package:shared_preferences/shared_preferences.dart';

class PrefService{
  Future createCache(String password) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("pass", password);
  }
  Future readCache(String password) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("pass");
    return cache;
  }
  Future removeCache(String password) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.remove("pass");
  }
}

