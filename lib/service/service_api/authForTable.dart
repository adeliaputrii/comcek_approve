import 'dart:convert';
import 'package:myactivity_project/service/service_api/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServicesForTable {

  static Future<http.Response> table(String sku) async {
    Map data = {
      "sku": sku,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'v1/activity/tbl_commcheck');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    final sharedPref = await SharedPreferences.getInstance();
    final myMapsPref = json.encode({
      'sku': sku,
    });
    
    sharedPref.setString('authData', myMapsPref);
    print('cingcai 111');
    print(response.body);
    return response;
  }

   

}