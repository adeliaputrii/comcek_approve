import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiBookmark {
  final String sku;
  final String toko;
  final String m1;
  final String hbeli;
  final String hjual;
  final String hjual_baru;
  final String date_cr;
  final String time_cr;
  final String user_cr;
  final String is_approv;
  final String date_approve;
  final String user_approv;


  

  ApiBookmark({
    required this.sku,
    required this.toko,
    required this.m1,
    required this.hbeli,
    required this.hjual,
    required this.hjual_baru,
    required this.date_cr,
    required this.time_cr,
    required this.user_cr,
    required this.is_approv,
    required this.date_approve,
    required this.user_approv,

  });

  factory ApiBookmark.fromJson(Map<String, dynamic> json) {
    return ApiBookmark(
      sku: json['sku'],
      toko: json['toko'],
      m1: json['m1'],
      hbeli: json['hbeli'],
      hjual: json['hjual'],
      hjual_baru: json['hjual_baru'],
      date_cr: json['date_cr'],
      time_cr: json['time_cr'],
      user_cr: json['user_cr'],
      is_approv: json['is_approv'],
      date_approve: json['date_approve'],
      user_approv: json['user_approv'],
    );
  }
   
}
   Future<ApiBookmark> getUsers() async {
    final response = await http.get(
      Uri.parse('https://android-api.ramayana.co.id:8304/api/v1/activity/tbl_commcheck')
    );
    if(response.statusCode == 200) {
      return ApiBookmark.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Faied to load post');
    }
   }
  
