import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class HakAkses {
  HakAkses({
    required this.approvaReturn,
    required this.voidReturn,
    required this.idcash,
   
  });

  // ignore: non_constant_identifier_names
  
  final String approvaReturn, voidReturn, idcash;

  
    factory HakAkses.fromjson(Map<String, dynamic> json1,) => HakAkses(
    approvaReturn : json1["approval"],
    voidReturn : json1["void"],
    idcash: json1["idcash"],
    );
    
  static List<HakAkses> hakakses = [];
  
}