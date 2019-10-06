import 'dart:core';

import 'package:b2s_driver/src/app/models/children.dart';

class DriverBusSession {
   String sessionID;
   String busID;
   int type; //0: lượt đi, //1: lượt về
   List<Children> listChildren;
   List<ChildDrenStatus> childDrenStatus;
   List<ChildDrenRoute> childDrenRoute;

  DriverBusSession(
      {this.childDrenRoute,
      this.sessionID,
      this.busID,
      this.type,
      this.listChildren,
      this.childDrenStatus});
  static List<DriverBusSession> list = [
    DriverBusSession(
        sessionID: "S01",
        busID: "52G-12345",
        type: 0,
        listChildren: Children.list,
        childDrenStatus: ChildDrenStatus.list,
        childDrenRoute: ChildDrenRoute.list),
    DriverBusSession(
        sessionID: "S02",
        busID: "52G-12345",
        type: 1,
        listChildren: Children.list,
        childDrenStatus: ChildDrenStatus.list,
        childDrenRoute: ChildDrenRoute.list),
  ];
}

class ChildDrenStatus {
  final int id;
  final int childrenID;
  int statusID; //remove final to do change status 0->1 in code

  ChildDrenStatus({this.id, this.childrenID, this.statusID});
  static List<ChildDrenStatus> list = [
    ChildDrenStatus(id: 1, childrenID: 1, statusID: 0),
    ChildDrenStatus(id: 2, childrenID: 2, statusID: 0),
    ChildDrenStatus(id: 3, childrenID: 3, statusID: 0),
    ChildDrenStatus(id: 4, childrenID: 4, statusID: 0),
  ];

  static int getStatusIDByChildrenID(List<ChildDrenStatus> list, int childrenID) {
    var statusID = 0;
    final _childrenStatus =  list.firstWhere((item) => item.childrenID == childrenID,  orElse: () => null);
    if(_childrenStatus != null) statusID = _childrenStatus.statusID;
    return statusID;
  }
}

class ChildDrenRoute {
  final int id;
  final List<int> listChildrenID;
  final int routeBusID;

  ChildDrenRoute({this.id, this.listChildrenID, this.routeBusID});
  static List<ChildDrenRoute> list = [
    ChildDrenRoute(id: 1, listChildrenID: [1, 2], routeBusID: 1),
    ChildDrenRoute(id: 2, listChildrenID: [3, 4], routeBusID: 2),
       ChildDrenRoute(id: 2, listChildrenID: [3, 4], routeBusID: 3),
  ];

  static ChildDrenRoute getChilDrenRouteByRouteID(
      List<ChildDrenRoute> list, routeBusID) {
     ChildDrenRoute _childrenRoute;
     _childrenRoute = list.firstWhere((item) => item.routeBusID == routeBusID,  orElse: () => null);
    // if(_childrenRoute == null) _childrenRoute = ChildDrenRoute();
     return _childrenRoute;
  }
}

class RouteBus {
  final int id;
  final String date;
  final String time;
  final String routeName;
  final int type; //0: lượt đi, //1: lượt về
  final bool status; // hoàn thành
  final double lat;
  final double lng;
  RouteBus(
      {this.id,
      this.date,
      this.time,
      this.routeName,
      this.type,
      this.status,
      this.lat,
      this.lng});

  static List<RouteBus> list = [
    RouteBus(
      id: 1,
      date: "2019-09-09",
      time: "07:00 am",
      routeName: "12 cách mạng tháng tám",
      type: 0,
      status: true,
      lat: 0,
      lng: 0,
    ),
    RouteBus(
      id: 2,
      date: "2019-09-09",
      time: "07:10 am",
      routeName: "285/95 cách mạng tháng 8",
      type: 0,
      status: true,
      lat: 0,
      lng: 0,
    ),
    RouteBus(
      id: 3,
      date: "2019-09-09",
      time: "07:30 am",
      routeName: "Trường quốc tế việt úc",
      type: 0,
      status: false,
      lat: 0,
      lng: 0,
    ),
    RouteBus(
      id: 4,
      date: "2019-09-09",
      time: "04:00 pm",
      routeName: "Trường quốc tế việt úc",
      type: 1,
      status: false,
      lat: 0,
      lng: 0,
    ),
    RouteBus(
      id: 5,
      date: "2019-09-09",
      time: "04:30 pm",
      routeName: "285/95 cách mạng tháng 8",
      type: 1,
      status: false,
      lat: 0,
      lng: 0,
    ),
  ];

  static List<RouteBus> getListRouteBusByType(
      List<RouteBus> listRouteBus, int type) {
    return listRouteBus.where((item) => item.type == type).toList();
  }
}

class StatusBus {
  final int statusID;
  final String statusName;
  final int statusColor;

  StatusBus(this.statusID, this.statusName, this.statusColor);
  static List<StatusBus> list = [
    StatusBus(0, "Đang chờ", 0xFF8FD838),
    StatusBus(1, "Đang trong chuyến", 0xFF8FD838),
    StatusBus(2, "Đã tới trường", 0xFF3DABEC),
    StatusBus(3, "Nghỉ học", 0xFFE80F0F),
    StatusBus(4, "Đã về nhà", 0xFF6F32A0),
  ];
  static getStatusByID(List<StatusBus> list, id) {
    return list.singleWhere((item) => item.statusID == id);
  }
}
