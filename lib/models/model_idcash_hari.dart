import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  ApprovalIdcashCustomerTanggal {
   ApprovalIdcashCustomerTanggal({
    required this.tanggal,
    required this.no_struk,
    required this.nilai,
  });

  // ignore: non_constant_identifier_names
  
  final String tanggal, no_struk, nilai; 

  
    factory  ApprovalIdcashCustomerTanggal.fromjson(Map<String, dynamic> json1,) =>  ApprovalIdcashCustomerTanggal(
    tanggal : json1["tanggal"],
    no_struk : json1["no_struk"],
    nilai : json1["nilai"],
    );
    
  static List< ApprovalIdcashCustomerTanggal> approvalidcashtanggal = [];
  
}