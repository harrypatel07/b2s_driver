import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';
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
      title: "Home",
      iconData: Icons.home,
      page: HomePage(),
      routeChildName: HomePage.routeName,
    ),
    Menu(
      index: 1,
      title: "Locate bus",
      iconData: FontAwesomeIcons.bus,
      page: LocateBusPage(),
      routeChildName: LocateBusPage.routeName,
    ),
  ];
}