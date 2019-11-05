import 'dart:convert';
import 'dart:typed_data';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/res-partner.dart';

class Parent {
  int id;
  dynamic name;
  dynamic photo;
  dynamic email;
  dynamic phone;
  dynamic gender;
  dynamic genderId;
  dynamic contactAddress;
  dynamic lat;
  dynamic lng;
  List<Children> listChildren;
  static dynamic aliasName = "Parent";
  static Parent _singleton;

  factory Parent() {
    if (_singleton != null)
      return _singleton;
    else
      return _singleton = new Parent._internal();
  }

  Parent._internal();

  Parent.newInstance(
      {this.id,
      this.name,
      this.photo,
      this.email,
      this.phone,
      this.gender,
      this.contactAddress,
      this.lat,
      this.lng}) {
    id = id;
    name = name;
    photo = photo;
    email = email;
    phone = phone;
    gender = gender;
    contactAddress = contactAddress;
  }

  fromResPartner(ResPartner resPartner, List<ResPartner> child) {
    id = resPartner.id;
    name = resPartner.name;
    photo = resPartner.image;
    email = resPartner.email;
    phone = resPartner.phone;
    if (resPartner.title is List) {
      gender = resPartner.title[1];
      genderId = resPartner.title[0];
    }
    contactAddress = resPartner.contactAddress;
    int index = 0;
    listChildren = child.map((item) {
      bool primary = false;
      if (index == 0) primary = true;
      index++;
      return Children.fromResPartner(item, primary: primary);
    }).toList();
  }

  fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    List photoUint8 = json['photo'];
    photoUint8 = photoUint8.cast<int>();
    photo = Uint8List.fromList(photoUint8);
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    genderId = json['genderId'];
    contactAddress = json['contactAddress'];
    List list = json['listChildren'];
    listChildren = list.map((item) => Children.fromJson(item)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['genderId'] = this.genderId;
    data['contactAddress'] = this.contactAddress;
    data['listChildren'] =
        this.listChildren.map((item) => item.toJson()).toList();
    return data;
  }

  Future<dynamic> saveLocal() async {
    return localStorage.setItem(Parent.aliasName, json.encode(this));
  }

  Future<dynamic> clearLocal() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Parent.aliasName) != null) {
        localStorage.deleteItem(Parent.aliasName);
        _singleton = null;
      }
    }
  }

  Future<Parent> reloadData() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Parent.aliasName) != null) {
        print(jsonDecode(localStorage.getItem(Parent.aliasName)));
        this.fromJson(jsonDecode(localStorage.getItem(Parent.aliasName)));

        return this;
      }
    }
    return this;
  }

  Future<bool> checkParentExist() async {
    await reloadData();
    if (id != null) return true;
    return false;
  }

  static List<Parent> info = [
    Parent.newInstance(
        id: 1,
        name: 'Phu huynh',
        gender: "M",
        phone: "0907488458",
        photo:
            "https://health.uottawa.ca/sites/health.uottawa.ca/files/mparent.jpg")
  ];
}
