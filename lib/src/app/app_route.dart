import 'package:b2s_driver/src/app/pages/busAttendance/bus_attendance_page.dart';
import 'package:b2s_driver/src/app/pages/history/history_page.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/leave/leave_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';
import 'package:b2s_driver/src/app/pages/login/login_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageUser/message_user_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/notification/notification_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> route = {
    '/': (context) => LoginPage(),
    LoginPage.routeName: (context) => LoginPage(),
    TabsPage.routeName: (context) =>
        TabsPage(ModalRoute.of(context).settings.arguments),
    HomePage.routeName: (context) => HomePage(),
    HistoryPage.routeName: (context) => HistoryPage(),
    LocateBusPage.routeName: (context) => LocateBusPage(),
    BusAttendancePage.routeName: (context) => BusAttendancePage(),
    LeavePage.routeName: (context) => LeavePage(),
    MessagePage.routeName: (context) => MessagePage(),
    MessageDetailPage.routeName: (context) =>
        MessageDetailPage(userId: ModalRoute.of(context).settings.arguments),
    MessageUserPage.routeName: (context) =>
        MessageUserPage(userId: ModalRoute.of(context).settings.arguments),
    NotificationPage.routeName: (context) => NotificationPage(),
  };
}

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _sendScreenView(PageRoute<dynamic> route) {
    var screenName = route.settings.name;
    switch (screenName) {
      case TabsPage.routeName:
        break;
      default:
    }
    print('screenName $screenName');

    // do something with it, ie. send it to your analytics service collector
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);

    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);

    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
