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