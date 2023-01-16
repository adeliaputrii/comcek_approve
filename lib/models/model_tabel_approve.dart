import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class ApproveModel1 {
  ApproveModel1({
    required this.sku,
    required this.toko,
    required this.m1,
    required this.hbeli,
    required this.hjual,
    required this.hjualBaru,
    required this.date_cr,
    required this.time_cr,
    required this.user_cr,
    required this.isapv,
    required this.dateapv,
    required this.userapv,
    this.item1 = '',
    this.item2 = '',
    this.value = false,
    this.isSelected = false,
    this.isSelectedCont = true,
  });

  // ignore: non_constant_identifier_names
  
  final String toko, m1, hbeli, hjual, hjualBaru, date_cr, time_cr, user_cr, isapv, dateapv, userapv;
  String  item1, item2;
  final int sku;
  bool isSelected;
  bool isSelectedCont;
  bool value;
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  
    factory ApproveModel1.fromjson(Map<String, dynamic> json1,) => ApproveModel1(
    sku : json1["sku"],
    toko : json1["toko"],
    m1 : json1["m1"],
    hbeli : json1["hbeli"],
    // .qty : json["qty"] :: '' ? 0 : int.parse(json["qty"]),
    hjual : json1["hjual"],
    hjualBaru: json1["hjual_baru"],
    date_cr : json1["date_cr"],
    time_cr : json1["time_cr"],
    user_cr : json1["user_cr"],
    isapv : json1["is_approv"],
    dateapv : json1["date_approve"],
    userapv : json1["user_approv"],
    );
    
  static List<ApproveModel1> approvelist1 = [];
  
}