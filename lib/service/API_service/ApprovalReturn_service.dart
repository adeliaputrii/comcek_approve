part of 'API_service.dart';



class APIApprovalReturnService{
  
  Future<int> ApprovalReturn({
    // required String status,
    required List<ApprovalReturnModel> approve_return,
  })async{
    try{
      var datajson = {};
      // datajson['status'] = status;
  for(var i = 0; i < approve_return.length; i++){
  var strKeyUntukNotrx = 'no_trx[$i]';
  var strKeyUntukNocp = 'nocp[$i]';
  datajson[strKeyUntukNotrx] = '${approve_return[i].no_trx.toString()}';
  datajson[strKeyUntukNocp] = '${approve_return[i].nocp.toString()}';
}
final Responseku = await http.post(Uri.parse(BaseUrl.urlApprovalReturn), body: datajson);
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