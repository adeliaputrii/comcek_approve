
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class SearchToko {
  SearchToko({
    required this.store_code,
    required this.store_name,
    required this.address,
    required this.city,
    required this.store_type,
    required this.regional,
    required this.latitude,
    required this.longitude,
    required this.korem,
    required this.ka_toko,
    required this.dm,
    required this.status,
    required this.country,
    required this.province,
    required this.store_code1,
    required this.date_created,
    required this.user_created,
    required this.date_modified,
    required this.user_modified,
    required this.dkk,
    required this.team10,
    required this.sdm_wilayah,
    required this.id_korem,
    required this.npwp_wilayah,
    required this.kode_wilayah,
    required this.classs,
    required this.tot_user_void
  });

  // ignore: non_constant_identifier_names
  
  final String 
  store_code,
  store_name, 
  address,
  city,
  store_type,
  regional,
  latitude,
  longitude,
  korem,
  ka_toko,
  dm,
  status,
  country,
  province,
  store_code1,
  date_created,
  user_created,
  date_modified,
  user_modified,
  dkk,
  team10,
  sdm_wilayah,
  id_korem,
  npwp_wilayah,
  kode_wilayah,
  classs,
  tot_user_void
  ;
  
    factory SearchToko.fromjson(Map<String, dynamic> json1,) => SearchToko(
    store_code : json1["store_code"],
    store_name : json1["store_name"],
    address : json1["address"],
    city: json1["city"],
    store_type: json1["store_type"],
    regional: json1["regional"],
    latitude: json1["latitude"],
    longitude: json1["longitude"],
    korem: json1["korem"],
    ka_toko: json1["ka_toko"],
    dm: json1["dm"],
    status: json1["status"],
    country: json1["country"],
    province: json1["province"],
    store_code1: json1["store_code1"],
    date_created: json1["date_created"],
    user_created: json1["user_created"],
    date_modified: json1["date_modified"],
    user_modified: json1["user_modified"],
    dkk: json1["dkk"],
    team10: json1["team10"],
    sdm_wilayah: json1["sdm_wilayah"],
    id_korem: json1["id_korem"],
    npwp_wilayah: json1["npwp_wilayah"],
    kode_wilayah: json1["kode_wilayah"],
    classs: json1["class"],
    tot_user_void: json1["tot_user_void"],

    );
    
  static List<SearchToko> searchtoko = [];
  
}