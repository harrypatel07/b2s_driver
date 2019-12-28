import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/pages/schedule/schedule_page.dart';
import 'package:b2s_driver/src/app/pages/user/user_page.dart';
import 'package:flutter/material.dart';

class Menu {
  Menu(
      {@required this.title,
      @required this.iconData,
      this.index,
      this.page,
      this.routeChildName});
  int index;
  String title;
  IconData iconData;
  Widget page;
  String routeChildName;
  static List<Menu> tabMenu = <Menu>[
    Menu(
      index: 0,
      title: "Lịch trình",
      iconData: Icons.home,
      page: SchedulePage(),
      routeChildName: SchedulePage.routeName,
    ),
    Menu(
      index: 1,
      title: "Người dùng",
      iconData: Icons.person,
      page: UserPage(),
      routeChildName: UserPage.routeName,
    ),
  ];

  static List<Menu> tabMenuAttendant = <Menu>[
    Menu(
      index: 0,
      title: "Lịch trình",
      iconData: Icons.home,
      page: AttendantPage(),
      routeChildName: AttendantPage.routeName,
    ),
    Menu(
      index: 1,
      title: "Người dùng",
      iconData: Icons.person,
      page: UserPage(),
      routeChildName: UserPage.routeName,
    ),
  ];
}
