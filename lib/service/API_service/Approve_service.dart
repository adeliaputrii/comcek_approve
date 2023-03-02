part of 'API_service.dart';

class APIApproveService{
  
  Future<int> ApproveSKU({
    required String user_approv,
    required String is_approv,
    required List<ApproveModel1>approvedModelsList,
  })async{
    try{
      var datajson = {};
      datajson['user_approv'] = user_approv;
      datajson['is_approv'] = is_approv;
  for(var i = 0; i < approvedModelsList.length; i++){
  var strKeyUntukId = 'id_komcek[$i]';
  var strKeyUntukStartDate = 'periode_start[$i]';
  var strKeyUntukEndDate = 'periode_end[$i]';
  datajson[strKeyUntukId] = '${approvedModelsList[i].id_komcek.toString()}';
  datajson[strKeyUntukStartDate] = approvedModelsList[i].startDate.text.toString();
  datajson[strKeyUntukEndDate] = approvedModelsList[i].endDate.text.toString();
}
final Responseku = await http.post(Uri.parse(BaseUrl.urlapprove), body: datajson);
var data = jsonDecode(Responseku.body);
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


// part of 'API_service.dart';

// class APILogService{
  
//   Future<int> LogActivity({
//     required String id_log,
//     required String user_name,
//     required String password,
//     required String progname, 
//     required String versi, 
//     required String date_run, 
//     required String info1, 
//     required String info2, 
//     required String userid, 
//     required String toko, 
//     required String devicename
//   })async{
//     try {
//       var datajson = {};
//       datajson['id_log'] = id_log;
//       datajson['user_name'] = user_name;
//       datajson['password'] = password;
//       datajson['progname'] = progname;
//       datajson['versi'] = versi;
//       datajson['date_run'] = date_run;
//       datajson['info1'] = info1;
//       datajson['info2'] = info2;
//       datajson['userid'] = userid;
//       datajson['toko'] = toko;
//       datajson['devicename'] = devicename;
// }
  
// final Responseku = await http.post(Uri.parse(BaseUrl.urllog), body: datajson);
// var data = jsonDecode(Responseku.body);
// if (data['status'] == 200) {
//   print('UPDATE SUCSESS');
//   print(datajson);
// }
// return 0; 
//     }on Exception{
//       return 3;
//     }
//   }
