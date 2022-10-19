class Activityy {
  int? id_act;
  String? nik;
  String? fullname;
  String? subdivisi;
  String? location;
  String? status;
  String? description;
  String? target;
  String? dateVisit;
  String? stkNumbers;

  Activityy({
    this.id_act,
    this.nik,
    this.fullname,
    this.subdivisi,
    this.location,
    this.status,
    this.description,
    this.target,
    this.dateVisit,
    this.stkNumbers,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id_act != null) {
      map['id_act'] = id_act;
    }
    map['nik'] = nik;
    map['fullname'] = fullname;
    map['subdivisi'] = subdivisi;
    map['location'] = location;
    map['status'] = status;
    map['description'] = description;
    map['target'] = target;
    map['dateVisit'] = dateVisit;
    map['stkNumbers'] = stkNumbers;

    return map;
  }

  Activityy.fromMap(Map<String, dynamic> map) {
    this.id_act = map['id_act'];
    this.nik = map['nik'];
    this.fullname = map['fullname'];
    this.subdivisi = map['subdivisi'];
    this.location = map['location'];
    this.status = map['status'];
    this.description = map['description'];
    this.target = map['target'];
    this.dateVisit = map['dateVisit'];
    this.stkNumbers = map['stkNumbers'];
  }
}
