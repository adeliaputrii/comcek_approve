class ApproveModel {
  ApproveModel.init() {
    this.toko = 'RB17';
  }

  // ignore: non_constant_identifier_names
  late String  toko, m1, hbeli, hjual, hjualBaru, date_cr, time_cr, user_cr, isapv, dateapv, userapv ;
  late int sku;

    ApproveModel.fromjson(Map<String, dynamic> json,) {
    this.sku = json["sku"];
    this.toko = json["toko"];
    this.m1 = json["m1"];
    this.hbeli = json["hbeli"];
    // this.qty = json["qty"] == '' ? 0 : int.parse(json["qty"]);
    this.hjual = json["hjual"];
    this.hjualBaru= json["hjual_baru"];
    this.date_cr = json["date_cr"];
    this.time_cr = json["time_cr"];
    this.user_cr = json["user_cr"];
    this.isapv = json["is_approv"];
    this.dateapv = json["date_approve"];
    this.userapv = json["user_approv"];
  }
  static List<ApproveModel> approvelist = [];
}