
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  ApprovalIdcashCustomerTahun {
   ApprovalIdcashCustomerTahun({
    required this.tahun,
    required this.nokartu,
    required this.nilai,
  });

  // ignore: non_constant_identifier_names
  
  final String tahun, nokartu, nilai; 

  
    factory  ApprovalIdcashCustomerTahun.fromjson(Map<String, dynamic> json1,) =>  ApprovalIdcashCustomerTahun(
    tahun : json1["tahun"],
    nokartu : json1["nokartu"],
    nilai : json1["nilai"],
    );
    
  static List< ApprovalIdcashCustomerTahun> approvalidcashtahun = [];
  
}