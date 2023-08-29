part of 'API_service.dart';

class MyActivity{
  
  Future<int> MyActivityForm({
    required String user_create,
    required String myactivity_desc,
    required String time_start,
    required String time_end,
    required String task_id,
    required String project_id,
    required String myactivity_status,
    required String date_create,
    required String dokumen,
    /*

  */
  })async{
    try{
      var datajson = {};
      datajson['user_create'] = user_create;
      datajson['myactivity_desc'] = myactivity_desc;
      datajson['time_start'] = time_start;
      datajson['time_end'] = time_end;
      datajson['task_id'] = task_id;
      datajson['projek_id'] = project_id;
      datajson['myactivity_status'] = myactivity_status;
      datajson['date_create'] = date_create;
      datajson['dokumen'] = dokumen;
print('print');
final Responseku = await http.post(Uri.parse('${tipeurl}v1/activity/create_daily_activity'), body: datajson);
print('engga');
var data = jsonDecode(Responseku.body);
print('coba');
if (data['status'] == 200) {
  print('UPDATE SUCSESS');
  print(datajson);
}
return 0; 
    }on Exception{
      return 3;
    }
  }
}