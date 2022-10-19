class UserModel {
  UserModel.init() {
    this.nama_user = 'Coffe Name';
    // this.subdivisi = '';
    // this.location = '';
    // this.status = '';
    // this.description = '';
    // this.target = '';
    // this.date_visit = '';
    // this.stk_numbers = '';
    // this.data_gambar = '';
    // this.id_user = '';
    // this.qty = 0;
  }

  // ignore: non_constant_identifier_names
  late String id_user, nama_user, password, subdivisi;
  // late int qty;

  UserModel.fromjson(Map<String, dynamic> json) {
    this.id_user = json["id_user"];
    this.nama_user = json["nama_user"];
    this.password = json["password"];
    this.subdivisi = json["subdivisi"];
    // this.qty = json["qty"] == '' ? 0 : int.parse(json["qty"]);
  }
  static List<UserModel> userlist = [];
}
