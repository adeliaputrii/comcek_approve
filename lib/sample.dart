import 'dart:ffi';

class Item {
    Item({
      required this.id,
      required this.sku,
      required this.toko,
      required this.m1,
      required this.hb,
      required this.hj,
      required this.hjBaru,
      required this.datecr,
      required this.timecr,
      required this.usercr,
      required this.isapv,
      required this.dateapv,
      required this.userapv,
      required this.isSelected,
    });
  
    int id;
    String sku;
    String toko;
    String m1;
    String hb;
    String hj;
    String hjBaru;
    String datecr;
    String timecr;
    String usercr;
    String isapv;
    String dateapv;
    String userapv;
    bool isSelected;
  }