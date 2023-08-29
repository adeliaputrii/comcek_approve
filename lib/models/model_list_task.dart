import 'package:flutter/cupertino.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class  MyactivityModelTask {
   MyactivityModelTask({
    required this.task_desc,
    required this.task_id,
  });

  // ignore: non_constant_identifier_names
  
  final String task_desc; 
  final String  task_id; 


  
    factory  MyactivityModelTask.fromjson(Map<String, dynamic> json1,) =>  MyactivityModelTask(
    task_id : json1["task_id"],
    task_desc : json1["task_desc"],
    );
    
  static List< MyactivityModelTask> myactivitytask = [];
  static List<String> addselectTask = [];
  
}