import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper{

  static void storeIslogin(val)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("islogin", val);
  }
  static void storeName(val) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", val);
  }
  static void clearAll() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  static void clearOne(name) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(name);
  }
}