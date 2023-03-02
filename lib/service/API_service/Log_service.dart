
part of 'API_service.dart';

class LogService{
  
  Future<int> LogActivity({
    required String id_log,
    required String user_name,
    required String password,
    required String progname, 
    required String versi, 
    required String date_run, 
    required String info1, 
    required String info2, 
    required String userid, 
    required String toko, 
    required String devicename,
  })async{
    try{
     
final Responseku = await http.post(Uri.parse(BaseUrl.urllog), 
body: {
      'id_log' : id_log,
      'user_name' : user_name,
      'password' : password,
      'progname' : progname,
      'versi' : versi,
      'date_run' : date_run,
      'info1' : info1,
      'info2' : info2,
      'userid' : userid,
      'toko' : toko,
      'devicename' : devicename,

});
var data = jsonDecode(Responseku.body);
if (data['status'] == 200) {
  print('UPDATE SUCSESS');
  print(data);
}
return 0; 
    }on Exception{
      return 3;
    }
  }
}