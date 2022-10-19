class AktivitasModel {
  AktivitasModel.init() {
    this.fullname = 'Coffe Name';
  }

  // ignore: non_constant_identifier_names
  late String id_act, fullname, subdivisi, location, status, description, target, date_visit, stk_numbers, data_gambar, id_user ;
  // late int qty;

  AktivitasModel.fromjson(Map<String, dynamic> json) {
    this.id_act = json["id_act"];
    this.fullname = json["fullname"];
    this.subdivisi = json["subdivisi"];
    this.location = json["location"];
    // this.qty = json["qty"] == '' ? 0 : int.parse(json["qty"]);
    this.status = json["status"];
    this.description = json["description"];
    this.target = json["target"];
    this.date_visit = json["date_visit"];
    this.stk_numbers = json["stk_numbers"];
    this.data_gambar = json["data_gambar"];
    this.id_user = json["id_user"];
  }
  static List<AktivitasModel> aktivitaslist = [];
}