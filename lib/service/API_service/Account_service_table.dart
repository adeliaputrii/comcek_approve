part of 'API_service_table.dart';


class APIUserServiceTable {
// //   static ApproveModel approveModel = ApproveModel.init();

// //   Future<int> tableApprove({
// //     required String sku
// //   }) async {
// //     try {
// //       final responseku = await http.post(Uri.parse(BaseUrl.table), body: {
// //         "sku": sku,
// //       });
// //       var data = jsonDecode(responseku.body);
// //       if (data['status'] == 200) {
// //         print("Login Success");
// //         print(data);
// //         await ApproveModel.fromjson(
// //           : data,
// //         );        
// //         return 0;
// //       } else {
// //         return 1; //invalid
// //       }
// //     } on Exception {
// //       return 3; //something went wrong
// //     }
// //   }
// // }

fetchProduk({
    required String m1
  }) async {
    ApproveModel.approvelist.clear();
    final responseku = await http.post(
      Uri.parse('https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
        body: {
          'm1' : m1
        });

    var data = jsonDecode(responseku.body);
   
    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApproveModel.approvelist.add(ApproveModel.fromjson(data['data'][i]));
      }
      print('check length ${ApproveModel.approvelist.length}');
      print(data['data'].toString());

    } else {
      print('NO DATA');
    }
  var result;
    print('jogja hebat');
     if (result == fetchProduk(m1: '084')) {
      print('jogja');
     }
     return result;
  }
}