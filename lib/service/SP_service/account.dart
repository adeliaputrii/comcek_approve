part of 'SP_service.dart';
class UserData {
  static const String logstatus = "_statuslog_str";
  static const String user_id_str = "user_id_str";
  static const String user_name_str = "user_name_str";
  static const String user_email_str = "user_email_str";
  static const String user_address_str = "user_address_str";
  static const String user_phone_str = "user_phone_str";
  static const String user_pass_str = "password_str";
  static const String isAdmin_str = "is_admin_str";
  static const String username_str = "username_str";
  static const String user_picUrl_str = "userpic_url_str";

  static bool _isAdmin = false;
  static bool _statuslog = false;
  static String _userName = '';
  static String _userNameOfUser = '';
  static String _userAdress = '';
  static String _userEmail = '';
  static String _userPassword = '';
  static String _userPhone = '';
  static String _userPicUrl = '';
  static String _userID = ''; 
  bool getAdminStatus() {
    return _isAdmin;
  }

  bool getStatusLog() {
    return _statuslog;
  }

  String getUserPassword() {
    return _userPassword;
  }

  String getUserID() {
    return _userID;
  }

  String getUsernameID() {
    return _userName;
  }

  String getnameofUser() {
    return _userNameOfUser;
  }

  String getEmail() {
    return _userEmail;
  }

  String getPhone() {
    return _userPhone;
  }

  String getPicurl() {
    return _userPicUrl;
  }

  String getAdress() {
    return _userAdress;
  }

  void printdevinfo() {
    print("\n\n======[info]=======]");
    print("ID       : $_userID");
    print("Username : $_userName");
    print("Name     : $_userNameOfUser");
    print("Email    : $_userEmail");
    print("Phone    : $_userPhone");
    print("adress   : $_userAdress");
    print("Password : $_userPassword");
    print("Pic URL  : $_userPicUrl");
    print("Log stat : $_statuslog");
    print("Admin    : $_isAdmin");
  }

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Data Avail';
    pref.setString(UserData.user_id_str, nodata);
    pref.setString(UserData.username_str, nodata);
    pref.setString(UserData.user_name_str, nodata);
    pref.setString(UserData.user_email_str, nodata);
    pref.setString(UserData.user_pass_str, nodata);
    pref.setString(UserData.user_phone_str, nodata);
    pref.setString(UserData.user_picUrl_str, nodata);
    pref.setString(UserData.user_address_str, nodata);
    pref.setBool(UserData.isAdmin_str, false);
    pref.setBool(UserData.logstatus, false);
    await getPref();
    print('[Account dev] : Data wiped out');
    printdevinfo();
    return;
  }

  Future<void> setUser({required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(UserData.logstatus, true);
    pref.setString(UserData.user_id_str, data['id_user']);
    pref.setString(UserData.username_str, data['nama_user']);  
    pref.setString(UserData.user_address_str, data['subdivisi']);    
    if (data['akses'] == 'adm') {
      pref.setBool(UserData.isAdmin_str, true);
    } else {
      pref.setBool(UserData.isAdmin_str, false);
    }
    await getPref();
    print('[LOGIN INFO] : Updated..!');
    printdevinfo();
    return;
  }

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _userID = pref.getString(user_id_str).toString();
    _userName = pref.getString(username_str).toString();
    _userNameOfUser = pref.getString(user_name_str).toString();
    _userPassword = pref.getString(user_pass_str).toString();
    _userEmail = pref.getString(user_email_str).toString();
    _userPicUrl = pref.getString(user_picUrl_str).toString();
    _userPhone = pref.getString(user_phone_str).toString();    
    _userAdress = pref.getString(user_address_str).toString();    
    if (pref.getBool(logstatus) == null || pref.getBool(logstatus) == false) {
      _statuslog = false;
    } else {
      _statuslog = true;
    }
    if (pref.getBool(isAdmin_str) == null ||
        pref.getBool(isAdmin_str) == false) {
      _isAdmin = false;
    } else {
      _isAdmin = true;
    }
    return;
  }
}
