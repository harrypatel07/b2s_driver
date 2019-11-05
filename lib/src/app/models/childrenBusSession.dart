import 'package:b2s_driver/src/app/models/picking-transport-info.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:b2s_driver/src/app/models/children.dart';

import 'driver.dart';

@JsonSerializable(nullable: false)
class ChildrenBusSession {
  String sessionID;
  Children child;
  List<RouteBus> listRouteBus;
  Driver driver;
  StatusBus status;
  dynamic schoolName;
  dynamic notification;

  ChildrenBusSession.fromPickingTransportInfo({
    PickingTransportInfo pti,
    Children objChildren,
    Driver objDriver,
  }) {
    sessionID = pti.id.toString();
    //Kiểm tra chuyến đi hay chuyền về
    var _type = 0;
    if (pti.deliveryId is List) {
      if (pti.deliveryId[1].toString().contains("OUT")) _type = 1;
    }
    if (objChildren != null) {
      child = objChildren;
      schoolName = child.schoolName;
    }
    if (objDriver != null) driver = objDriver;
    notification = "";

    PickingTransportInfo_State.values.forEach((value) {
      if (Common.getValueEnum(value) == pti.state)
        switch (value) {
          case PickingTransportInfo_State.draft:
            status = StatusBus.list[0];
            break;
          case PickingTransportInfo_State.halt:
            status = StatusBus.list[1];

            break;
          case PickingTransportInfo_State.done:
            if (_type == 0)
              status = StatusBus.list[2];
            else
              status = StatusBus.list[4];
            break;
          case PickingTransportInfo_State.cancel:
            status = StatusBus.list[3];
            break;
          default:
        }
    });
  }
  fromJson(Map<dynamic, dynamic> json) {
    sessionID = json['sessionID'];
    child = Children.fromJson(json['child']);
    List list = json['listRouteBus'];
    listRouteBus = list.map((item) => RouteBus.fromJson(item)).toList();
    driver = Driver.fromJson(json['driver']);
    status = StatusBus.fromJson(json['status']);
    schoolName = json['schoolName'];
    notification = json['notification'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionID'] = this.sessionID;
    data['child'] = this.child.toJson();
    data['listRouteBus'] =
        this.listRouteBus.map((item) => item.toJson()).toList();
    data['driver'] = this.driver.toJson();
    data['status'] = this.status.toJson();
    data['schoolName'] = this.schoolName;
    data['notification'] = this.notification;
    return data;
  }

  ChildrenBusSession(
      {this.sessionID,
      this.child,
      this.listRouteBus,
      this.driver,
      this.status,
      this.schoolName,
      this.notification}); //
  static List<ChildrenBusSession> list = [
    ChildrenBusSession(
        sessionID: "S01",
        child: Children.list[0],
        listRouteBus: RouteBus.list,
        driver: Driver.list[0],
        status: StatusBus.list[0],
        schoolName: "VStar School",
        notification: "Xe sắp đến đón trong 10 phút"),
    ChildrenBusSession(
      sessionID: "S02",
      child: Children.list[1],
      listRouteBus: RouteBus.list,
      driver: Driver.list[1],
      status: StatusBus.list[0],
      schoolName: "VStar School",
      notification: "Xe sắp đến đón trong 10 phút",
    )
  ];
}
