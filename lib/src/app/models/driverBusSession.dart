import 'dart:convert';
import 'dart:core';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:crypto/crypto.dart';

class DriverBusSession {
  String sessionID;
  String busID;
  int type; //0: lượt đi, //1: lượt về
  int totalChildrenRegistered;
  int totalChildrenInBus;
  int totalChildrenLeave;
  int totalChildrenPick;
  int totalChildrenDrop;
  List<Children> listChildren;
  List<ChildDrenStatus> childDrenStatus;
  List<ChildDrenRoute> childDrenRoute;
  List<RouteBus> listRouteBus;
  bool status; // false: chưa hoàn thành, true: hoàn thành
  DriverBusSession({
    this.childDrenRoute,
    this.sessionID,
    this.busID,
    this.type,
    this.listChildren,
    this.childDrenStatus,
    this.listRouteBus,
    this.totalChildrenRegistered,
    this.totalChildrenInBus,
    this.totalChildrenLeave,
    this.status,
  });

  DriverBusSession.fromJsonController({
    String busID,
    int type,
    String date,
    List<Children> listChildren,
    List<ChildDrenStatus> childDrenStatus,
    List<ChildDrenRoute> childDrenRoute,
    List<RouteBus> listRouteBus,
  }) {
    this.busID = busID;
    this.type = type;
    this.sessionID = md5.convert(utf8.encode("$busID$date$type")).toString();
    this.totalChildrenRegistered = listChildren.length;
    this.totalChildrenInBus = 0;
    this.totalChildrenLeave = 0;
    this.totalChildrenPick = 0;
    this.totalChildrenDrop = 0;
    this.listChildren = listChildren;
    this.childDrenStatus = childDrenStatus;
    this.childDrenRoute = childDrenRoute;
    this.listRouteBus = listRouteBus;
    this.status = false;
  }
  fromJson(Map<dynamic, dynamic> json) {
    List list = [];
    sessionID = json['sessionID'];
    busID = json['busID'];
    list = json['listChildren'];
    listChildren = list.map((item) => Children.fromJson(item)).toList();
    type = json['type'];
    list = json['childDrenStatus'];
    childDrenStatus =
        list.map((item) => ChildDrenStatus.fromJson(item)).toList();
    list = json['childDrenRoute'];
    childDrenRoute = list.map((item) => ChildDrenRoute.fromJson(item)).toList();
    list = json['listRouteBus'];
    listRouteBus = list.map((item) => RouteBus.fromJson(item)).toList();
    totalChildrenRegistered = json['totalChildrenRegistered'];
    totalChildrenInBus = json['totalChildrenInBus'];
    totalChildrenLeave = json['totalChildrenLeave'];
    status = json['status'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionID'] = this.sessionID;
    data['busID'] = this.busID;
    data['listChildren'] =
        this.listChildren.map((item) => item.toJson()).toList();
    data['type'] = this.type;
    data['childDrenStatus'] =
        this.childDrenStatus.map((item) => item.toJson()).toList();
    data['childDrenRoute'] =
        this.childDrenRoute.map((item) => item.toJson()).toList();
    data['listRouteBus'] =
        this.listRouteBus.map((item) => item.toJson()).toList();
    data['totalChildrenRegistered'] = this.totalChildrenRegistered;
    data['totalChildrenInBus'] = this.totalChildrenInBus;
    data['totalChildrenLeave'] = this.totalChildrenLeave;
    data['status'] = this.status;
    return data;
  }

  static List<DriverBusSession> list = [
    DriverBusSession(
        sessionID: "S01",
        busID: "52G-12345",
        type: 0,
        listChildren: Children.list,
        childDrenStatus: ChildDrenStatus.list,
        childDrenRoute: ChildDrenRoute.list,
        listRouteBus: RouteBus.getListRouteBusByType(RouteBus.list, 0)),
    DriverBusSession(
        sessionID: "S02",
        busID: "52G-12345",
        type: 1,
        listChildren: Children.list,
        childDrenStatus: ChildDrenStatus.list,
        childDrenRoute: ChildDrenRoute.list,
        listRouteBus: RouteBus.getListRouteBusByType(RouteBus.list, 1)),
  ];

  //Cập nhật status trường hợp nhấn vào pick và drop
  static updateChildrenStatusIdByPickDrop(
      {DriverBusSession driverBusSession,
      ChildDrenStatus childDrenStatus,
      bool update = true}) {
    if (update) {
      switch (childDrenStatus.typePickDrop) {
        case 0: //pick
          childDrenStatus.statusID = 1;
          driverBusSession.childDrenStatus.forEach((item) {
            if (item.childrenID == childDrenStatus.childrenID)
              item.statusID = 1;
          });
          break; //drop
        case 1:
          childDrenStatus.statusID = driverBusSession.type == 0 ? 2 : 4;
          driverBusSession.childDrenStatus.forEach((item) {
            if (item.childrenID == childDrenStatus.childrenID)
              item.statusID = driverBusSession.type == 0 ? 2 : 4;
          });
          break;
        default:
      }
    } else {
      switch (childDrenStatus.typePickDrop) {
        case 0: //pick
          childDrenStatus.statusID = 0;
          driverBusSession.childDrenStatus.forEach((item) {
            if (item.childrenID == childDrenStatus.childrenID)
              item.statusID = 0;
          });
          break; //drop
        case 1:
          childDrenStatus.statusID = 1;
          driverBusSession.childDrenStatus.forEach((item) {
            if (item.childrenID == childDrenStatus.childrenID &&
                item.routeBusID == childDrenStatus.routeBusID)
              item.statusID = 1;
          });
          break;
        default:
      }
    }
  }

  //Cập nhật status trường hợp nghỉ
  static updateChildrenStatusIdByLeave(
      {DriverBusSession driverBusSession, ChildDrenStatus childDrenStatus}) {
    childDrenStatus.statusID = 3;
    driverBusSession.childDrenStatus.forEach((item) {
      if (item.childrenID == childDrenStatus.childrenID) item.statusID = 3;
    });
  }
}

class ChildDrenStatus {
  int id; //map với picking transport info
  int childrenID;
  int statusID; //map với field state cua picking transport info
  int routeBusID;
  int typePickDrop; // 0 là pick, 1 là drop

  ChildDrenStatus(
      {this.id,
      this.childrenID,
      this.statusID,
      this.routeBusID,
      this.typePickDrop});

  ChildDrenStatus.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    childrenID = json['childrenID'];
    statusID = json['statusID'];
    routeBusID = json['routeBusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["childrenID"] = this.childrenID;
    data["statusID"] = this.statusID;
    data["routeBusID"] = this.routeBusID;
    return data;
  }

  static ChildDrenStatus getStatusByChildrenID(
      List<ChildDrenStatus> list, int childrenID, int routeBusID) {
    ChildDrenStatus status = ChildDrenStatus();
    final _childrenStatus = list.firstWhere(
        (item) =>
            item.childrenID == childrenID && item.routeBusID == routeBusID,
        orElse: () => null);
    if (_childrenStatus != null) status = _childrenStatus;
    return status;
  }

  static int getStatusIDByChildrenID(
      List<ChildDrenStatus> list, int childrenID, int routeBusID) {
    var statusID = 0;
    final _childrenStatus = list.firstWhere(
        (item) =>
            item.childrenID == childrenID && item.routeBusID == routeBusID,
        orElse: () => null);
    if (_childrenStatus != null) statusID = _childrenStatus.statusID;
    return statusID;
  }

  static List<ChildDrenStatus> list = [
    ChildDrenStatus(id: 1, childrenID: 3, statusID: 0, routeBusID: 1),
    ChildDrenStatus(id: 2, childrenID: 4, statusID: 0, routeBusID: 1),
    ChildDrenStatus(id: 3, childrenID: 1, statusID: 0, routeBusID: 2),
    ChildDrenStatus(id: 4, childrenID: 2, statusID: 0, routeBusID: 2),
    ChildDrenStatus(id: 6, childrenID: 1, statusID: 0, routeBusID: 4),
    ChildDrenStatus(id: 7, childrenID: 2, statusID: 0, routeBusID: 4),
  ];
}

class ChildDrenRoute {
  int id;
  List<int> listChildrenID;
  int routeBusID;

  ChildDrenRoute({this.id, this.listChildrenID, this.routeBusID});

  ChildDrenRoute.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    listChildrenID = json['listChildrenID'].cast<int>();
    routeBusID = json['routeBusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["listChildrenID"] = this.listChildrenID;
    data["routeBusID"] = this.routeBusID;
    return data;
  }

  static ChildDrenRoute getChilDrenRouteByRouteID(
      List<ChildDrenRoute> list, routeBusID) {
    ChildDrenRoute _childrenRoute;
    _childrenRoute = list.firstWhere((item) => item.routeBusID == routeBusID,
        orElse: () => null);
    // if(_childrenRoute == null) _childrenRoute = ChildDrenRoute();
    return _childrenRoute;
  }

  static List<ChildDrenRoute> list = [
    ChildDrenRoute(id: 1, listChildrenID: [3, 4], routeBusID: 1),
    ChildDrenRoute(id: 2, listChildrenID: [1, 2], routeBusID: 2),
    ChildDrenRoute(id: 3, listChildrenID: [1, 2], routeBusID: 4),
  ];
}
