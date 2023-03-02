import 'dart:convert';
import 'package:myactivity_project/service/service_api/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServicesLog {


  static Future<http.Response> login(
    String user_name,
     String password,
     String progname, 
     String versi, 
     String date_run, 
     String info1, 
     String info2, 
     String userid, 
     String toko, 
     String devicename,) async {
    Map data = {
      'user_name' : user_name,
      'password' : password,
      'progname' : progname,
      'versi' : versi,
      'date_run' : date_run,
      'info1' : info1,
      'info2' : info2,
      'userid' : userid,
      'toko' : toko,
      'devicename' : devicename,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURLog);
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    final sharedPref = await SharedPreferences.getInstance();
    final myMapsPref = json.encode({
      'user_name': user_name,
    });
    
    sharedPref.setString('authData', myMapsPref);
    print('cingcai 111');
    print(response.body);
    return response;
  }

   

}