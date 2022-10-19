class Kontak{
    int? id;
    String? name;
    String? mobileNo;
    String? nik;
    String? company;
    
    
    Kontak({this.id, this.name, this.mobileNo, this.nik, this.company});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
  
  if (id != null) {
          map['id'] = id;
        }
        map['name'] = name;
        map['mobileNo'] = mobileNo;
        map['nik'] = nik;
        map['company'] = company;
        
        return map;
    }
    
    Kontak.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.name = map['name'];
        this.mobileNo = map['mobileNo'];
        this.nik = map['nik'];
        this.company = map['company'];
    }
}