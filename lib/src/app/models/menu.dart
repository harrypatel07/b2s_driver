import 'package:b2s_driver/src/app/pages/historyTrip/historyTrip_page.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';
import 'package:b2s_driver/src/app/pages/schedule/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      title: "Lịch sử chuyến",
      iconData: FontAwesomeIcons.bus,
      page: HistoryTripPage(),
      routeChildName: HistoryTripPage.routeName,
    ),
  ];
}
