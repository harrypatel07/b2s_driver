import 'dart:convert';
import 'dart:core';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/picking-route.dart';
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
  static dynamic aliasName = "DriverBusSession";
  DriverBusSession({
    this.sessionID,
    this.busID,
    this.type,
    this.totalChildrenRegistered,
    this.totalChildrenInBus,
    this.totalChildrenLeave,
    this.totalChildrenPick,
    this.totalChildrenDrop,
    this.listChildren,
    this.childDrenStatus,
    this.listRouteBus,
    this.childDrenRoute,
    this.status,
  });

  DriverBusSession.fromJsonController(
      {String busID,
      int type,
      String date,
      List<Children> listChildren,
      List<ChildDrenStatus> childDrenStatus,
      List<ChildDrenRoute> childDrenRoute,
      List<RouteBus> listRouteBus,
      bool status = false}) {
    this.busID = busID;
    this.type = type;
    this.sessionID = md5
        .convert(utf8.encode("$busID$date${listRouteBus[0].time}$type"))
        .toString();
    this.totalChildrenRegistered = listChildren.length;
    this.totalChildrenInBus = 0;
    this.totalChildrenLeave = 0;
    this.totalChildrenPick = 0;
    this.totalChildrenDrop = 0;
    this.listChildren = listChildren;
    this.childDrenStatus = childDrenStatus;
    this.childDrenRoute = childDrenRoute;
    this.listRouteBus = listRouteBus;
    this.status = status;
  }
  fromJson(Map<dynamic, dynamic> json) {
    List list = [];
    sessionID = json['sessionID'];
    busID = json['busID'];
    type = json['type'];
    totalChildrenRegistered = json['totalChildrenRegistered'];
    totalChildrenInBus = json['totalChildrenInBus'];
    totalChildrenLeave = json['totalChildrenLeave'];
    totalChildrenPick = json['totalChildrenPick'];
    totalChildrenDrop = json['totalChildrenDrop'];
    list = json['listChildren'];
    listChildren = list.map((item) => Children.fromJson(item)).toList();
    list = json['childDrenStatus'];
    childDrenStatus =
        list.map((item) => ChildDrenStatus.fromJson(item)).toList();
    list = json['childDrenRoute'];
    childDrenRoute = list.map((item) => ChildDrenRoute.fromJson(item)).toList();
    list = json['listRouteBus'];
    listRouteBus = list.map((item) => RouteBus.fromJson(item)).toList();
    status = json['status'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionID'] = this.sessionID;
    data['busID'] = this.busID;
    data['type'] = this.type;
    data['totalChildrenRegistered'] = this.totalChildrenRegistered;
    data['totalChildrenInBus'] = this.totalChildrenInBus;
    data['totalChildrenLeave'] = this.totalChildrenLeave;
    data['totalChildrenPick'] = this.totalChildrenPick;
    data['totalChildrenDrop'] = this.totalChildrenDrop;
    data['listChildren'] =
        this.listChildren.map((item) => item.toJson()).toList();
    data['childDrenStatus'] =
        this.childDrenStatus.map((item) => item.toJson()).toList();
    data['childDrenRoute'] =
        this.childDrenRoute.map((item) => item.toJson()).toList();
    data['listRouteBus'] =
        this.listRouteBus.map((item) => item.toJson()).toList();
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

  Future<dynamic> saveLocal() async {
    return localStorage.setItem(DriverBusSession.aliasName, json.encode(this));
  }

  Future<dynamic> clearLocal() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(DriverBusSession.aliasName) != null) {
        localStorage.deleteItem(DriverBusSession.aliasName);
      }
    }
  }

  Future<DriverBusSession> reloadData() async {
    bool ready = await localStorage.ready;
    if (ready) {
      if (localStorage.getItem(DriverBusSession.aliasName) != null) {
        print(jsonDecode(localStorage.getItem(DriverBusSession.aliasName)));
        this.fromJson(
            jsonDecode(localStorage.getItem(DriverBusSession.aliasName)));

        return this;
      }
    }
    return this;
  }

  Future<bool> checkDriverBusSessionExists() async {
    await reloadData();
    if (sessionID != null) return true;
    return false;
  }
}

class ChildDrenStatus {
  int id; //map với picking transport info
  int childrenID;
  int statusID; //map với field state cua picking transport info
  int routeBusID;
  int typePickDrop; // 0 là pick, 1 là drop
  String note; // PH- TX - QLĐĐ
  PickingRoute pickingRoute;
  ChildDrenStatus(
      {this.id,
      this.childrenID,
      this.statusID,
      this.routeBusID,
      this.typePickDrop,
      this.note,
      this.pickingRoute});

  ChildDrenStatus.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    childrenID = json['childrenID'];
    statusID = json['statusID'];
    routeBusID = json['routeBusID'];
    typePickDrop = json['typePickDrop'];
    note = json['note'];
    pickingRoute = PickingRoute.fromJson(json['pickingRoute']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["childrenID"] = this.childrenID;
    data["statusID"] = this.statusID;
    data["routeBusID"] = this.routeBusID;
    data["typePickDrop"] = this.typePickDrop;
    data["note"] = this.note;
    data["pickingRoute"] = this.pickingRoute.toJson();
    return data;
  }

  static List<ChildDrenStatus> getListChildrenStatusByTypeAndRouteBusId(
      List<ChildDrenStatus> list, int type, int routeBusID) {
    return list
        .where((item) =>
            item.routeBusID == routeBusID && item.typePickDrop == type)
        .toList();
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

  static List<int> getListChildrenIdByTypeAndRouteBusId(
      List<ChildDrenStatus> listChildrenStatus,
      int _typePickDrop,
      int _routeBusID) {
    List<int> listChildrenId;
    listChildrenId = listChildrenStatus
        .where((item) =>
            item.typePickDrop == _typePickDrop &&
            item.routeBusID == _routeBusID)
        .toList()
        .map((item) => item.childrenID)
        .toList();
    return listChildrenId;
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
