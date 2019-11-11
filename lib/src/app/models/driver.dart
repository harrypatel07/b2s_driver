import 'dart:convert';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/fleet-vehicle.dart';
import 'package:b2s_driver/src/app/models/res-partner.dart';

class Driver {
  int id;
  dynamic name;
  dynamic photo;
  dynamic gender;
  dynamic genderId;
  dynamic phone;
  dynamic vehicleId;
  dynamic vehicleName;
  List<FleetVehicle> listVehicle;

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
      {this.id,
      this.name,
      this.photo,
      this.gender,
      this.phone,
      this.listVehicle,
      this.vehicleId,
      this.vehicleName}) {
    id = id;
    name = name;
    photo = photo;
    phone = phone;
    gender = gender;
    listVehicle = listVehicle;
    vehicleId = vehicleName;
    vehicleId = vehicleId;
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
    // if (resPartner.vehicleIds is List) vehicleId = resPartner.vehicleIds[0];
  }

  fromResPartner(ResPartner resPartner) {
    id = resPartner.id;
    name = resPartner.name;
    photo = resPartner.image;
    if (resPartner.title is List) {
      gender = resPartner.title[1];
      genderId = resPartner.title[0];
    }
    phone = resPartner.phone;
    // if (resPartner.vehicleIds is List) vehicleId = resPartner.vehicleIds[0];
  }

  Driver.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    gender = json['gender'];
    genderId = json['genderId'];
    phone = json['phone'];
    vehicleId = json['vehicleId'];
    vehicleName = json['vehicleName'];
    List list = json['listVehicle'];
    listVehicle = list.map((item) => FleetVehicle.fromJson(item)).toList();
  }

  fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    gender = json['gender'];
    genderId = json['genderId'];
    phone = json['phone'];
    vehicleId = json['vehicleId'];
    vehicleName = json['vehicleName'];
    List list = json['listVehicle'];
    listVehicle = list.map((item) => FleetVehicle.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["photo"] = this.photo;
    data["gender"] = this.gender;
    data["genderId"] = this.genderId;
    data["phone"] = this.phone;
    // data["vehicleId"] = this.vehicleId;
    // data["vehicleName"] = this.vehicleName;
    data['listVehicle'] =
        this.listVehicle.map((item) => item.toJson()).toList();
    return data;
  }

  Future<dynamic> saveLocal() async {
    return localStorage.setItem(Driver.aliasName, json.encode(this));
  }

  Future<dynamic> clearLocal() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Driver.aliasName) != null) {
        localStorage.deleteItem(Driver.aliasName);
        _singleton = null;
      }
    }
  }

  Future<Driver> reloadData() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(Driver.aliasName) != null) {
        print(jsonDecode(localStorage.getItem(Driver.aliasName)));
        this.fromJson(jsonDecode(localStorage.getItem(Driver.aliasName)));

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
