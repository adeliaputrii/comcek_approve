part of 'API_service.dart';

class APIUserService {
  static UserData userData = UserData();

  Future<int> loginUser({
    required String user,
    required String pass,
  }) async {
    try {
      final responseku = await http.post(Uri.parse(BaseUrl.login), body: {
        "username": user.toLowerCase(),
        "password": pass,
      });
      var data = jsonDecode(responseku.body);
      if (data['result'] == 1) {
        print("Login Success");
        print(data);
        await userData.setUser(
          data: data,
        );        
        return 0;
      } else {
        return 1; //invalid
      }
    } on Exception {
      return 3; //something went wrong
    }
  }

  // Future<int> signUptoDatabase({
  //   @required fullname,
  //   @required email,
  //   @required phone,
  //   @required pass,
  //   @required username,
  // }) async {
  //   var uuid = Uuid();
  //   var piccode = uuid.v1();
  //   piccode = piccode.substring(1, 5);
  //   print('unicode  : $piccode');
  //   print('Registerr');
  //   //var defaultpic = ishavepicphoto ? "0" : "1";
  //   //FormData formdata = new FormData.fromMap({});
  //   try {
  //     final responseku = await http.post(Uri.parse(BaseUrl.SignUpUser), body: {
  //       "name": fullname,
  //       "email": email,
  //       "phone": phone,
  //       "pass": pass,
  //       "username": username.toLowerCase(),
  //       "Profile_pic_file": "Use Default Pic",
  //       "pic_default": '1',
  //       "ext": '1',
  //       "unique_code": piccode,
  //     });
  //     var data = jsonDecode(responseku.body);
  //     if (data['result'] == '1') {
  //       await fetchID();
  //       await setUserforNotification(username: username.toLowerCase());
  //       return 0;
  //     }
  //     if (data['result'] == '2') {
  //       return 2;
  //     } else {
  //       return 1;
  //     }
  //   } on Exception {
  //     return 1;
  //   }
  // }
}
