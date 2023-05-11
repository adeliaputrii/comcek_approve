import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class ApprovalReturnModel {
  ApprovalReturnModel({
    required this.tanggal,
    required this.toko,
    required this.no_trx,
    required this.nocp,
    required this.amaount,
    required this.status,
    required this.date_cr,
    required this.date_upd,
    required this.id_kasir,
    required this.nama_kasir,
    this.isSelected = false,
    this.isSelectedCont = false,
  });

  // ignore: non_constant_identifier_names
  
  final String tanggal, toko, no_trx, nocp, amaount, status, date_cr, date_upd, id_kasir, nama_kasir;
  bool isSelected;
  bool isSelectedCont;

  
    factory ApprovalReturnModel.fromjson(Map<String, dynamic> json1,) => ApprovalReturnModel(
    tanggal : json1["tanggal"],
    toko : json1["toko"],
    no_trx : json1["no_trx"],
    nocp : json1["nocp"],
    amaount : json1["amaount"],
    status: json1["status"],
    date_cr : json1["date_cr"],
    date_upd : json1["date_upd"],
    id_kasir : json1["id_kasir"],
    nama_kasir : json1["nama_kasir"],
    );
    
  static List<ApprovalReturnModel> approvalreturn = [];
  
}