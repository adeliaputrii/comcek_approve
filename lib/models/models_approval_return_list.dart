import 'package:shared_preferences/shared_preferences.dart';

class  ApprovalReturnMenu{
  String? menu;
  String? toko;
  static List<String> approvalmenu = [];
  static List<String> idcashmenu = [];
  

  static Future sharedPref() async {
   final prefs = await SharedPreferences.getInstance();
   var toko = prefs.getString("toko");
   return toko;
 }
  
}