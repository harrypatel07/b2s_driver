import 'dart:convert';

import 'package:b2s_driver/src/app/models/childrenBusSession.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:crypto/crypto.dart';

class BusSession {
  String id; //map với picking transport info
  String notification;
  int statusId;
  int childrenId;
  BusSession({this.id, this.notification, this.statusId, this.childrenId});

  BusSession.fromChildrenStatus(ChildDrenStatus childDrenStatus,
      [String notification = ""]) {
    this.notification = notification;
    this.statusId = childDrenStatus.statusID;
    this.childrenId = childDrenStatus.childrenID;
    this.notification = "";
    this.id = md5
        .convert(
            utf8.encode("${childDrenStatus.id}${childDrenStatus.childrenID}"))
        .toString();
  }
  BusSession.fromChildrenBusSession(ChildrenBusSession childrenBusSession) {
    this.notification = childrenBusSession.notification;
    this.statusId = childrenBusSession.status.statusID;
    this.childrenId = childrenBusSession.child.id;
    this.id = md5
        .convert(utf8.encode(
            "${childrenBusSession.sessionID}${childrenBusSession.child.id}"))
        .toString();
  }

  BusSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notification = json['notification'];
    childrenId = json['childrenId'];
    statusId = json['statusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notification'] = this.notification;
    data['childrenId'] = this.childrenId;
    data['statusId'] = this.statusId;
    return data;
  }
}
