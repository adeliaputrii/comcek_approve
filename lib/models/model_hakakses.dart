
import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class HakAkses {
  HakAkses({
    required this.id_master_menu,
    required this.name_menu,
    required this.icon_menu,
    required this.created_date,
    required this.updated_date,
    required this.routes,
    required this.before_modul,
    required this.is_active,
    required this.urutan
  });

  // ignore: non_constant_identifier_names
  
  final String 
  name_menu,
  icon_menu, 
  created_date, 
  updated_date, 
  routes, 
  before_modul, 
   
  urutan;
  
  final int id_master_menu, is_active;

  
    factory HakAkses.fromjson(Map<String, dynamic> json1,) => HakAkses(
    id_master_menu : json1["id_master_menu"],
    name_menu : json1["name_menu"],
    icon_menu : json1["icon_menu"],
    created_date : json1["created_date"],
    updated_date : json1["updated_date"],
    routes: json1["routes"],
    before_modul : json1["before_modul"],
    is_active : json1["is_active"],
    urutan : json1["urutan"],
    );
    
  static List<HakAkses> hakakses = [];
  static List hakaksesSubmenuComcek = []; 
  
}