
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  ApprovalIdcashCustomer {
    ApprovalIdcashCustomer({
    required this.nokartu,
    required this.nama,
    required this.nohp,
    required this.email,
    required this.saldo,
    required this.saldo_pemakaian,
  });

  // ignore: non_constant_identifier_names
  
  final String nokartu, nama, nohp, email, saldo;
  final int  saldo_pemakaian; 

  
    factory   ApprovalIdcashCustomer.fromjson(Map<String, dynamic> json1,) =>   ApprovalIdcashCustomer(
    nokartu : json1["nokartu"],
    nama : json1["nama"],
    nohp : json1["nohp"],
    email : json1["email"],
    saldo : json1["saldo"],
    saldo_pemakaian : json1["saldo_pemakaian"],
    );
    
  static List<  ApprovalIdcashCustomer> approvalidcashcust = [];
  
}