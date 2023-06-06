// import 'dart:convert';
// import 'package:myactivity_project/service/service_api/global.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthServices {
//   // static Future<http.Response> register(
//   //     String name, String username, String password) async {
//   //   Map data = {
//   //     "name": name,
//   //     "username": username,
//   //     "password": password,
//   //   };
//   //   var body = json.encode(data);
//   //   var url = Uri.parse(baseURL + 'auth/signin');
//   //   http.Response response = await http.post(
//   //     url,
//   //     headers: headers,
//   //     body: body,
//   //   );
//   //   print(response.body);
//   //   return response;
//   // }

//   static Future<http.Response> login(String user_name, String password) async {
//     Map data = {
//       "user_name": user_name,
//       "password": password,
//     };
//     var body = json.encode(data);
//     var url = Uri.parse(baseURL + 'v1/auth/signin');
//     http.Response response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );
//     final sharedPref = await SharedPreferences.getInstance();
//     final myMapsPref = json.encode({
//       'user_name': user_name,
//     });
    
//     sharedPref.setString('authData', myMapsPref);
//     print('cingcai 111');
//     print(response.body);
//     return response;
//   }

   

// }