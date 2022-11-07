import 'package:shared_preferences/shared_preferences.dart';
 const String email='Email';
class AppPrefreances{
  static SharedPreferences? sharedPreferences;
 static  init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  void saveEmail(String userEmail){
   sharedPreferences?.setString(email, userEmail);
  }
  Future<String?> getEmail()async{
   return  sharedPreferences?.getString(email)??'';
  }

}