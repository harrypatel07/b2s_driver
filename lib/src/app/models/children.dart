import 'dart:typed_data';

import 'package:b2s_driver/src/app/models/parent.dart';
import 'package:b2s_driver/src/app/models/res-partner.dart';

class Children {
  int id;
  dynamic name;
  dynamic photo;
  dynamic location = 'HCM, VN.';
  dynamic gender;
  dynamic genderId;
  dynamic age;
  bool primary;
  dynamic schoolName = "";
  dynamic schoolId;
  dynamic phone;
  dynamic email;
  dynamic parentId;
  dynamic paidTicket;
  dynamic lat;
  dynamic lng;
  dynamic classes;
  dynamic birthday;
  Parent parent;
  Children(
      {this.id,
      this.name,
      this.photo,
      this.location = "HCM",
      this.gender,
      this.genderId,
      this.age,
      this.primary,
      this.schoolName,
      this.schoolId,
      this.phone,
      this.email,
      this.parentId,
      this.paidTicket,
      this.lat,
      this.lng,
      this.classes,
      this.birthday,
      this.parent});

  Children.fromJsonController(Map<dynamic, dynamic> partner) {
    this.id = partner["id"];
    this.schoolName = (partner["school"] is bool) ? "" : partner["school"];
    this.phone = (partner["phone"] is bool) ? "" : partner["phone"];
    this.name = (partner["name"] is bool) ? "" : partner["name"];
    this.birthday = partner["date_of_birth"];
    this.email = (partner["email"] is bool) ? "" : partner["email"];
    this.photo = partner["image"];
    this.classes = (partner["class"] is bool) ? "" : partner["class"];
    if (this.birthday != null) if (!(this.birthday is bool)) {
      var date = DateTime.parse(this.birthday);
      var dateNow = DateTime.now();
      this.age = dateNow.year - date.year;
    }
    this.genderId =
        (partner["title"]["id"] is bool) ? "" : partner["title"]["id"];
    this.gender =
        (partner["title"]["name"] is bool) ? "" : partner["title"]["name"];
    var _parent = partner["parent_id"];
    if (_parent["id"] is bool)
      this.parent = Parent.newInstance();
    else
      this.parent = Parent.newInstance(
          id: _parent["id"],
          email: _parent["email"],
          phone: _parent["phone"],
          name: _parent["name"],
          photo: _parent["image"]);
  }

  Children.fromResPartner(ResPartner resPartner, {bool primary}) {
    id = resPartner.id;
    name = resPartner.name;
    photo = resPartner.image;
    location = resPartner.contactAddress;
    if (resPartner.title is List) {
      gender = resPartner.title[1];
      genderId = resPartner.title[0];
    }
    if (resPartner.xSchool is List) {
      schoolName = resPartner.xSchool[1];
      schoolId = resPartner.xSchool[0];
      classes = resPartner.xClass;
    }
    email = resPartner.email;
    phone = resPartner.phone;
    paidTicket = false;

    if (resPartner.parentId is List) parentId = resPartner.parentId[0];
    this.primary = primary;
    birthday = resPartner.wkDob;
    if (this.birthday != null) if (!(this.birthday is bool)) {
      var date = DateTime.parse(this.birthday);
      var dateNow = DateTime.now();
      this.age = dateNow.year - date.year;
    }
  }

  Children.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['photo'] is List) {
      List photoUint8 = json['photo'];
      photoUint8 = photoUint8.cast<int>();
      photo = Uint8List.fromList(photoUint8);
    } else if (!(json['photo'] is bool)) photo = json['photo'];
    location = json['location'];
    gender = json['gender'];
    genderId = json['genderId'];
    age = json['age'];
    primary = json['primary'];
    schoolName = json['schoolName'];
    schoolId = json['schoolId'];
    phone = json['phone'];
    email = json['email'];
    parentId = json['parentId'];
    paidTicket = json['paidTicket'];
    lat = json['lat'];
    lng = json['lng'];
    classes = json['classes'];
    birthday = json['birthday'];
    parent = Parent.fromJson(json['parent']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["photo"] = this.photo;
    data["location"] = this.location;
    data["gender"] = this.gender;
    data["genderId"] = this.genderId;
    data["age"] = this.age;
    data["primary"] = this.primary;
    data["schoolName"] = this.schoolName;
    data["schoolId"] = this.schoolId;
    data["classes"] = this.classes;
    data["phone"] = this.phone;
    data["email"] = this.email;
    data["parentId"] = this.parentId;
    data["paidTicket"] = this.paidTicket;
    data["lat"] = this.lat;
    data["lng"] = this.lng;
    data["birthday"] = this.birthday;
    data["parent"] = this.parent.toJson();
    return data;
  }

  static final List<Children> list = [
    Children(
        id: 1,
        name: 'Boy A',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-2539.jpg",
        gender: 'F',
        age: 12,
        primary: true,
        schoolName: "VStar school"),
    Children(
        id: 2,
        name: 'Girl B',
        photo:
            "https://shalimarbphotography.com/wp-content/uploads/2018/06/SBP-0800.jpg",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
    Children(
        id: 3,
        name: 'Girl C',
        photo: "http://all4desktop.com/data_images/original/4240052-child.jpg",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
    Children(
        id: 4,
        name: 'Girl D',
        photo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlkl0i-KXPeU1RWvA1RZ8XzctHaKrFV_iiMlBCQIJieWhai02Q",
        gender: 'F',
        age: 10,
        primary: false,
        schoolName: "VStar school"),
  ];

  static List<Children> setChildrenPrimary(
      List<Children> list, int childrenID) {
    for (var item in list) {
      if (item.id == childrenID)
        item.primary = true;
      else
        item.primary = false;
    }
    return list;
  }

  static List<Children> getListChildrenPaidTicket(List<Children> list) {
    return list.where((child) => child.paidTicket == true).toList();
  }

  static Children getChildrenPrimary(List<Children> list) {
    return list.firstWhere((child) => child.primary == true,
        orElse: () => null);
  }

  static List<Children> getChildrenNotPrimary(List<Children> list) {
    return list.where((child) => child.primary == false).toList();
  }

  static List<Children> getChildrenByListID(
      List<Children> listChildren, List<int> listId) {
    List<Children> listResult = [];
    for (var id in listId) {
      var child = listChildren.singleWhere((child) => child.id == id);
      if (child != null) listResult.add(child);
    }
    return listResult;
  }
}
