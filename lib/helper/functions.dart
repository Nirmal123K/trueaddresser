import 'package:trueaddresser/imports.dart';

class HelperFunctions {
  static String userLoggedInKey = "USERLOGGEDINKEY";
  static String userUid;
  static saveUserLoggedInDeatils(
      { @required String userId}) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    pres.setString(userLoggedInKey, userUid);
  }

  static Future<String> getUserId()async{
     SharedPreferences pres = await SharedPreferences.getInstance();
    return pres.getString(userLoggedInKey);
  }
}
