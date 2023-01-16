part of 'API_service.dart';

class APIApproveService{
  
  Future<int> ApproveSKU({
    required String is_approv,
    required String user_approv,
    required List<ApproveModel1>approvedModelsList,
  })async{
    try{
      var datajson = {};
      datajson['is_approv'] = is_approv;
      datajson['user_approv'] = user_approv;
  for(var i = 0; i < approvedModelsList.length; i++){
  var strKeyUntukSku = 'sku[$i]';
  var strKeyUntukMd = 'm1[$i]';
  var strKeyUntukStartDate = 'periode_start[$i]';
  var strKeyUntukEndDate = 'periode_end[$i]';
  datajson[strKeyUntukSku] = '00${approvedModelsList[i].sku.toString()}';
  datajson[strKeyUntukMd] = approvedModelsList[i].m1;
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