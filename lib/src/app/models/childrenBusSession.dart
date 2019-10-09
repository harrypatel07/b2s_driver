import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:json_annotation/json_annotation.dart';

import 'children.dart';
import 'driver.dart';

@JsonSerializable(nullable: false)
class ChildrenBusSession {
  String sessionID;
  Children child;
  List<RouteBus> listRouteBus;
  Driver driver;
  StatusBus status;
  String schoolName;
  String notification;

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
