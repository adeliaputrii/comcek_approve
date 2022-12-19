part of 'SP_service.dart';

class TableData {
  static const String logstatus = "_statuslog_str";
  static const String isAdmin_str = "is_admin_str";
  static const String sku_str = "sku_str";
  static const String toko_str = "toko_str";
  static const String m1_str = "m1_str";
  static const String hbeli_str = "hbeli_str";
  static const String hjual_str = "hjual_str";
  static const String hjual_baru_str = "hjual_baru_str";
  static const String date_cr_str = "date_cr_str";
  static const String time_cr_str = "time_cr_str";
  static const String user_cr_str = "user_cr_str";
  static const String is_approv_str = "is_approv_str";
  static const String date_approve_str = "date_approve_str";
  static const String user_approv_str = "user_approv_str";

  static bool _isAdmin = false;
  static bool _statuslog = false;
  static String _sku = '';
  static String _toko = '';
  static String _m1 = '';
  static String _hbeli = '';
  static String _hjual = '';
  static String _hjual_baru = '';
  static String _date_cr = '';
  static String _time_cr = '';
  static String _user_cr = '';
  static String _is_approv = ''; 
  static String _date_approve= '';
  static String _user_approv= '';

  bool getAdminStatus() {
    return _isAdmin;
  }

  bool getStatusLog() {
    return _statuslog;
  }

  String getSKu() {
    return _sku;
  }

  String getToko() {
    return _toko;
  }

  String getM1() {
    return _m1;
  }

  String getHbeli() {
    return _hbeli;
  }

  String getHjual() {
    return _hjual;
  }

  String getHjualB() {
    return _hjual_baru;
  }

  String getDateCr() {
    return _date_cr;
  }

  String getTimeCr() {
    return _time_cr;
  }

  String getUserCr() {
    return _user_cr;
  }

  String getIsAppv() {
    return _is_approv;
  }

  String getDateAppv() {
    return _date_approve;
  }

   String getUserAppv() {
    return _user_approv;
  }

  void printdevinfo() {
    print("\n\n======[info]=======]");
    print("SKU             : $_sku");
    print("Toko            : $_toko");
    print("M1              : $_m1");
    print("Harga Beli      : $_hbeli");
    print("Harga Jual      : $_hjual");
    print("Harga Jual Baru : $_hjual_baru");
    print("Date Create     : $_date_cr");
    print("Time Create     : $_time_cr");
    print("User Create     : $_user_cr");
    print("Is Approve      : $_is_approv");
    print("Date Approve    : $_date_approve");
    print("User Approve    : $_user_approv");
  }

  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Data Avail';
    pref.setString(TableData.sku_str, nodata);
    pref.setString(TableData.toko_str, nodata);
    pref.setString(TableData.m1_str, nodata);
    pref.setString(TableData.hbeli_str, nodata);
    pref.setString(TableData.hjual_str, nodata);
    pref.setString(TableData.hjual_baru_str, nodata);
    pref.setString(TableData.date_cr_str, nodata);
    pref.setString(TableData.time_cr_str, nodata);
    pref.setString(TableData.user_cr_str, nodata);
    pref.setString(TableData.is_approv_str, nodata);
    pref.setString(TableData.date_approve_str, nodata);
    pref.setString(TableData.user_approv_str, nodata);
    pref.setBool(TableData.isAdmin_str, false);
    pref.setBool(TableData.logstatus, false);
    await getPref();
    print('[Account dev] : Data wiped out');
    printdevinfo();
    return;
  }

  Future<void> setUser({required Map data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(TableData.logstatus, true);
    pref.setString(TableData.sku_str, data['data']['sku'].toString());
    pref.setString(TableData.toko_str, data['data']['toko'].toString());
    pref.setString(TableData.m1_str, data['data']['m1'].toString());
    pref.setString(TableData.hbeli_str, data['data']['hbeli'].toString());
    pref.setString(TableData.hjual_str, data['data']['hjual'].toString());
    pref.setString(TableData.hjual_baru_str, data['data']['hjual_baru'].toString());
    pref.setString(TableData.date_cr_str, data['data']['date_cr'].toString());
    pref.setString(TableData.time_cr_str, data['data']['time_cr'].toString());
    pref.setString(TableData.user_cr_str, data['data']['user_cr'].toString());
    pref.setString(TableData.is_approv_str, data['data']['is_approv'].toString());
    pref.setString(TableData.date_approve_str, data['data']['date_approve'].toString());
    pref.setString(TableData.user_approv_str, data['data']['user_approv'].toString());
    await getPref();
    print('[LOGIN INFO] : Updated..!');
    printdevinfo();
    return;
  }

  Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _sku = pref.getString(sku_str).toString();
    _toko = pref.getString(toko_str).toString();
    _m1 = pref.getString(m1_str).toString();
    _hbeli = pref.getString(hbeli_str).toString();
    _hjual = pref.getString(hjual_str).toString();
    _hjual_baru = pref.getString(hjual_baru_str).toString();
    _date_cr = pref.getString(date_cr_str).toString();
    _time_cr = pref.getString(time_cr_str).toString();
    _user_cr = pref.getString(user_cr_str).toString();    
    _is_approv = pref.getString(is_approv_str).toString();  
    _date_approve = pref.getString(date_approve_str).toString();  
    _user_approv = pref.getString(user_approv_str).toString();  
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

