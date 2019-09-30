import 'package:b2s_driver/src/app/pages/busAttendance/bus_attendance_page.dart';
import 'package:b2s_driver/src/app/pages/leave/leave_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/notification/notification_page.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({@required this.name, @required this.color, this.routeName});

  final Color color;
  final String name;
  final String routeName;

  static final List<Category> categories = [
    Category(
      name: "My students",
      color: Colors.teal,
      routeName: BusAttendancePage.routeName,
    ),
    Category(
      name: "Locale bus map",
      color: Colors.red,
      routeName: LocateBusPage.routeName,
    ),
    Category(name: "History trips", color: Colors.blue),
    Category(
        name: "Notification",
        color: Colors.yellow,
        routeName: NotificationPage.routeName),
    Category(
      name: "Leave",
      color: Colors.purple,
      routeName: LeavePage.routeName,
    ),
    Category(
      name: "Message",
      color: Colors.brown,
      routeName: MessagePage.routeName,
    ),
  ];
}
