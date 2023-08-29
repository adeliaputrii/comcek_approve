import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  MyactivityModel {
   MyactivityModel({
    required this.project_desc,
    required this.project_id,
    this.isSelected = false,
  });

  // ignore: non_constant_identifier_names
  
  final String project_desc; 
  final String  project_id; 
  bool isSelected;


  
    factory  MyactivityModel.fromjson(Map<String, dynamic> json1,) =>  MyactivityModel(
    project_id : json1["project_id"],
    project_desc : json1["project_desc"],
    );
    
  static List< MyactivityModel> myactivitymodel = [];
  static List<String> addSelect = [];
  
}