
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  ApprovalIdcashCustomerBulan {
    ApprovalIdcashCustomerBulan({
    required this.month,
    required this.nokartu,
    required this.nilai,
  });

  // ignore: non_constant_identifier_names
  
  final String month, nokartu, nilai; 

  
    factory   ApprovalIdcashCustomerBulan.fromjson(Map<String, dynamic> json1,) =>   ApprovalIdcashCustomerBulan(
    month : json1["month"],
    nokartu : json1["nokartu"],
    nilai : json1["nilai"],
    );
    
  static List<  ApprovalIdcashCustomerBulan> approvalidcashbulan = [];
  
}