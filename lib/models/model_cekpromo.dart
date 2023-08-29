
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class CekHarga {
  CekHarga({
    required this.site,
    required this.site_maris,
    required this.md,
    required this.dept,
    required this.classe,
    required this.sclass,
    required this.article,
    required this.sku_code,
    required this.sku_desc_l,
    required this.sku_desc_s,
    required this.pricing,
    required this.defy,
    required this.hj_tgl_start,
    required this.hargajual,
    required this.defn,
    required this.date_update,
    required this.mclass,
    required this.def01,
    required this.def02,
    required this.def03,
    required this.avgcost,
    required this.empty01,
    required this.empty02,
    required this.uom_sales,
    required this.date_create,
    required this.defa1,
    required this.sku13,
    required this.pajak,
    required this.product_type,
    required this.empty03,
    required this.emptyn,
    required this.sku_timbangan,
    required this.expire_day,
    required this.promodisc1,
    required this.promodisc2,
    required this.promoprice1,
    required this.promodisc3,
    required this.tglml,
    required this.tglsd,
    required this.empty04,
    required this.old_harga_jual,
    required this.last_proses
  });

  // ignore: non_constant_identifier_names
  
  final String 
  site,
  site_maris, 
  md, 
  dept, 
  classe, 
  sclass, 
 article,
  sku_code,
  sku_desc_l,
  sku_desc_s,
  pricing,
  defy,
  hj_tgl_start,
  hargajual,
  defn,
  date_update,
  mclass,
  def01,
  def02,
  def03,
  avgcost,
  empty01,
  empty02,
  uom_sales,
  date_create,
  defa1,
  sku13,
  pajak,
  product_type,
  empty03,
  emptyn,
  sku_timbangan,
  expire_day,
  promodisc1,
  promodisc2,
  promoprice1,
  promodisc3,
  tglml,
  tglsd,
  empty04,
  old_harga_jual,
  last_proses;

  
    factory CekHarga.fromjson(Map<String, dynamic> json1,) => CekHarga(
    site : json1["site"],
    site_maris : json1["site_maris"],
    md : json1["md"],
    dept : json1["dept"],
    classe : json1["classe"],
    sclass: json1["sclass"],
    article : json1["article"],
    sku_code: json1["sku_code"],
    sku_desc_l : json1["sku_desc_l"],
    sku_desc_s : json1["sku_desc_s"],
    pricing : json1["pricing"],
    defy: json1["defy"],
    hj_tgl_start: json1["hj_tgl_start"],
    hargajual: json1["hargajual"],
    defn: json1["defn"],
    date_update: json1["date_update"],
    mclass: json1["mclass"],
    def01: json1["def01"],
    def02: json1["def02"],
    def03: json1["def03"],
    avgcost: json1["avgcost"],
    empty01: json1["empty01"],
    empty02: json1["empty02"],
    uom_sales: json1["uom_sales"],
    date_create: json1["date_create"],
    defa1: json1["defa1"],
    sku13: json1["sku13"],
    pajak: json1["pajak"],
    product_type: json1["product_type"], 
    empty03: json1["empty03"],
    emptyn: json1["emptyn"],
    sku_timbangan: json1["sku_timbangan"],
    expire_day: json1["expire_day"],
    promodisc1: json1["promodisc1"],
    promodisc2: json1["promodisc2"],
    promoprice1: json1["promoprice1"],
    promodisc3: json1["promodisc3"],
    tglml: json1["tglml"],
    tglsd: json1["tglsd"],
    empty04: json1["empty04"],
    old_harga_jual: json1["old_harga_jual"],
    last_proses: json1["last_proses"],
    );
    
  static List<CekHarga> cekharga = [];
  
}