import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  MyactivityEditModel {
   MyactivityEditModel({
    required this.user_modify,
    required this.user_create,
    required this.time_start,
    required this.time_end,
    required this.task_id,
    required this.projek_id,
    required this.myactivity_status,
    required this.myactivity_id,
    required this.myactivity_desc,
    required this.dokumen,
    required this.date_modify,
    required this.date_create,
  });

  // ignore: non_constant_identifier_names
  
  final String user_modify, user_create, time_start, time_end, task_id,
  projek_id, myactivity_status, myactivity_desc, dokumen,date_modify, date_create ; 
  final int  myactivity_id; 


  
    factory  MyactivityEditModel.fromjson(Map<String, dynamic> json1,) =>  MyactivityEditModel(
    user_modify: json1["user_modify"],
    user_create : json1["user_create"],
    time_start : json1["time_start"],
    time_end : json1["time_end"],
    task_id: json1["task_id"],
    projek_id: json1["projek_id"],
    myactivity_status : json1["myactivity_status"],
    myactivity_id : json1["myactivity_id"],
    myactivity_desc : json1["myactivity_desc"],
    dokumen : json1["dokumen"],
    date_modify : json1["date_modify"],
    date_create : json1["date_create"],
    
         
    );
    
  static List< MyactivityEditModel> myactivityedit = [];
}