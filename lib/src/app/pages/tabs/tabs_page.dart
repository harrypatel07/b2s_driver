import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/menu.dart';
import 'package:b2s_driver/src/app/pages/sidemenu/sidemenu_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  static const String routeName = "/tabs";
  final TabsArgument args;
  TabsPage(this.args);
  @override
  _TabsPageState createState() => _TabsPageState();
}

class TabsArgument {
  final String routeChildName;
  TabsArgument({this.routeChildName});
}

class _TabsPageState extends State<TabsPage> {
  TabsPageViewModel viewModel = TabsPageViewModel();

  List<Widget> tabs = Menu.tabMenu.map((menu) => menu.page).toList();
  Driver driver = Driver();
  @override
  void initState() {
    //Kiểm tra user là attendant
    if (!driver.isDriver)
      tabs = Menu.tabMenuAttendant.map((menu) => menu.page).toList();
    super.initState();
    _navigateChild(widget.args);
  }

  _navigateChild(TabsArgument arg) {
    // switch (arg.routeChildName) {
    //   case HomePage.routeName:
    //     viewModel.currentTabIndex = 0;
    //     break;
    //   case HistoryPage.routeName:
    //     viewModel.currentTabIndex = 1;
    //     break;
    //   case LocateBusPage.routeName:
    //     viewModel.currentTabIndex = 2;
    //     break;
    //   case UserPage.routeName:
    //     viewModel.currentTabIndex = 3;
    //     break;
    // }
    if (driver.isDriver)
      Menu.tabMenu.asMap().forEach((index, menu) {
        if (arg.routeChildName == menu.routeChildName)
          viewModel.currentTabIndex = menu.index;
      });
    else
      Menu.tabMenuAttendant.asMap().forEach((index, menu) {
        if (arg.routeChildName == menu.routeChildName)
          viewModel.currentTabIndex = menu.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return Scaffold(
              key: viewModel.scaffoldTabbar,
              body: IndexedStack(
                index: viewModel.currentTabIndex,
                children: tabs,
              ),
              //drawer: SideMenuPage(),
              // bottomNavigationBar: BottomNavigationBar(
              //   onTap: viewModel.onTapped,
              //   currentIndex: viewModel.currentTabIndex,
              //   items: Menu.tabMenu
              //       .map((menu) =>
              //           BottomNavigationBarItem(icon:  new Icon(
              //     menu.iconData,
              //   ), title: Text(menu.title)))
              //       .toList(),
              // ),
              bottomNavigationBar: FancyBottomNavigation(
                key: viewModel.fancyKey,
                tabs: driver.isDriver
                    ? Menu.tabMenu
                        .map((menu) =>
                            TabData(iconData: menu.iconData, title: menu.title))
                        .toList()
                    : Menu.tabMenuAttendant
                        .map((menu) =>
                            TabData(iconData: menu.iconData, title: menu.title))
                        .toList(),
                onTabChangedListener: (index) {
                  viewModel.onTapped(index);
                },
              ),
            );
          }),
    );
  }
}
