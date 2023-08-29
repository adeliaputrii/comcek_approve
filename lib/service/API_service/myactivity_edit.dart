part of 'API_service.dart';

class MyActivityEdit{
  
  Future<int> MyActivityEditForm({
    required String project_id,
    required String task_id,
    required String dokumen,
    required String date_create,
    required String user_create,
    required String time_start,
    required String time_end,
    required int myactivity_id,
    required String myactivity_desc,
    /*

  */
  })async{
    try{
      var datajson = {};
      datajson['projek_id'] = project_id;
      datajson['task_id'] = task_id;
      datajson['dokumen'] = dokumen;
      datajson['date_create'] = date_create;
      datajson['user_create'] = user_create;
      datajson['time_start'] = time_start;
      datajson['time_end'] = time_end;
      datajson['myactivity_id'] = myactivity_id;
      datajson['myactivity_desc'] = myactivity_desc;
print('print');
final Responseku = await http.post(Uri.parse('${tipeurl}v1/activity/updateDailyActivity'), body: datajson);
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