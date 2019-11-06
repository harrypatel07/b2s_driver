import 'package:b2s_driver/src/app/models/res-partner.dart';

class Driver {
  int id;
  dynamic name;
  dynamic photo;
  dynamic gender;
  dynamic genderId;
  dynamic phone;
  static dynamic aliasName = "Driver";
  static Driver _singleton;

  factory Driver() {
    if (_singleton != null)
      return _singleton;
    else
      return _singleton = new Driver._internal();
  }

  Driver._internal();

  Driver.newInstance(
      {this.id, this.name, this.photo, this.gender, this.phone}) {
    id = id;
    name = name;
    photo = photo;
    phone = phone;
    gender = gender;
  }

  Driver.fromResPartner(ResPartner resPartner) {
    id = resPartner.id;
    name = resPartner.name;
    photo = resPartner.image;
    if (resPartner.title is List) {
      gender = resPartner.title[1];
      genderId = resPartner.title[0];
    }
    phone = resPartner.phone;
  }

  Driver.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    gender = json['gender'];
    genderId = json['genderId'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["photo"] = this.photo;
    data["gender"] = this.gender;
    data["genderId"] = this.genderId;
    data["phone"] = this.phone;
    return data;
  }

  static final List<Driver> list = [
    Driver.newInstance(
        id: 1,
        name: 'Driver 1',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-2539.jpg",
        gender: 'F',
        phone: "0907488458"),
    Driver.newInstance(
        id: 2,
        name: 'Driver 2',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        gender: 'F',
        phone: "0905123456"),
  ];
}
