import 'dart:core';

import 'package:b2s_driver/src/app/models/children.dart';

class DriverBusSession {
  String sessionID;
  String busID;
  int type; //0: lượt đi, //1: lượt về
  List<Children> listChildren;
  List<ChildDrenStatus> childDrenStatus;
  List<ChildDrenRoute> childDrenRoute;
  List<RouteBus> listRouteBus;
  DriverBusSession(
      {this.childDrenRoute,
      this.sessionID,
      this.busID,
      this.type,
      this.listChildren,
      this.childDrenStatus,
      this.listRouteBus});

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
}

class ChildDrenStatus {
  int id; //map với field state cua picking transport info
  int childrenID;
  int statusID; //remove final to do change status 0->1 in code
  int routeBusID;
  ChildDrenStatus({
    this.id,
    this.childrenID,
    this.statusID,
    this.routeBusID,
  });

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

class RouteBus {
  int id;
  String date;
  String time;
  String routeName;
  int type; //0: lượt đi, //1: lượt về
  bool status; // hoàn thành
  double lat;
  double lng;
  RouteBus(
      {this.id,
      this.date,
      this.time,
      this.routeName,
      this.type,
      this.status,
      this.lat,
      this.lng});

  RouteBus.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    routeName = json['routeName'];
    type = json['type'];
    status = json['status'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["date"] = this.date;
    data["time"] = this.time;
    data["routeName"] = this.routeName;
    data["type"] = this.type;
    data["status"] = this.status;
    data["lat"] = this.lat;
    data["lng"] = this.lng;
    return data;
  }

  static List<RouteBus> list = [
    RouteBus(
      id: 1,
      date: "2019-09-09",
      time: "07:00 am",
      routeName: "200 võ thị sáu, p10, q3",
      type: 0,
      status: true,
      lat: 10.784144,
      lng: 106.687781,
    ),
    RouteBus(
      id: 2,
      date: "2019-09-09",
      time: "07:10 am",
      routeName: "285/94B cách mạng tháng tám, p12, q10",
      type: 0,
      status: true,
      lat: 10.776573,
      lng: 106.685157,
    ),
    RouteBus(
      id: 3,
      date: "2019-09-09",
      time: "07:30 am",
      routeName: "Trường quốc tế việt úc",
      type: 0,
      status: false,
      lat: 10.766937,
      lng: 106.663168,
    ),
    RouteBus(
      id: 4,
      date: "2019-09-09",
      time: "04:00 pm",
      routeName: "Trường quốc tế việt úc",
      type: 1,
      status: false,
      lat: 10.766937,
      lng: 106.663168,
    ),
    RouteBus(
      id: 5,
      date: "2019-09-09",
      time: "04:30 pm",
      routeName: "285/94 cách mạng tháng 8, p12, q10",
      type: 1,
      status: false,
      lat: 10.776573,
      lng: 106.685157,
    ),
  ];

  static List<RouteBus> getListRouteBusByType(
      List<RouteBus> listRouteBus, int type) {
    return listRouteBus.where((item) => item.type == type).toList();
  }
}
