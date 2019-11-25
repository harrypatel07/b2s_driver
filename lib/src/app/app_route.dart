import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/pages/attendantManager/attendant_manager_page.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/pages/historyTrip/historyTrip_page.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTrip_detail_page.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:b2s_driver/src/app/pages/locateBus/emergency/emergency_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page.dart';

import 'package:b2s_driver/src/app/pages/login/login_page.dart';
import 'package:b2s_driver/src/app/pages/message/ContactsPage/contacts_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageUser/message_user_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/message/profileMessageUser/profile_message_user_page.dart';
import 'package:b2s_driver/src/app/pages/schedule/schedule_page.dart';

import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/pages/user/edit_profile_driver/edit_profile_driver.dart';
import 'package:b2s_driver/src/app/pages/user/user_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> route = {
    '/': (context) => LoginPage(),
    LoginPage.routeName: (context) => LoginPage(),
    TabsPage.routeName: (context) =>
        TabsPage(ModalRoute.of(context).settings.arguments),
    HomePage.routeName: (context) => HomePage(
          driverBusSession: ModalRoute.of(context).settings.arguments,
        ),
    LocateBusPage.routeName: (context) => LocateBusPage(
          driverBusSession: ModalRoute.of(context).settings.arguments,
        ),
    EmergencyPage.routeName: (context) => EmergencyPage(),
    ProfileChildrenPage.routeName: (context) =>
        ProfileChildrenPage(args: ModalRoute.of(context).settings.arguments),
    HistoryTripPage.routeName: (context) => HistoryTripPage(),
    SchedulePage.routeName: (context) => SchedulePage(),
    BottomSheetCustom.routeName: (context) => BottomSheetCustom(
      arguments: ModalRoute.of(context).settings.arguments,
    ),
//    BottomSheetAttendantCustom.routeName: (context) => BottomSheetAttendantCustom(
//      arguments: ModalRoute.of(context).settings.arguments,
//    ),
    UserPage.routeName: (context) => UserPage(),
    MessagePage.routeName: (context) => MessagePage(),
    MessageDetailPage.routeName: (context) =>
        MessageDetailPage(chatting: ModalRoute.of(context).settings.arguments),
    MessageUserPage.routeName: (context) =>
        MessageUserPage(userId:ModalRoute.of(context).settings.arguments),
    ContactsPage.routeName: (context)=>ContactsPage(),
    ProfileMessageUserPage.routeName: (context) => ProfileMessageUserPage(userModel:ModalRoute.of(context).settings.arguments),
    EditProfileDriver.routeName: (context)=>EditProfileDriver(driver:ModalRoute.of(context).settings.arguments),
    HistoryTripDetailPage.routeName: (context)=>HistoryTripDetailPage(driverBusSession: ModalRoute.of(context).settings.arguments,),
    AttendantPage.routeName:(context) => AttendantPage(),
    AttendantManagerPage.routeName: (context) => AttendantManagerPage(driverBusSession: ModalRoute.of(context).settings.arguments,)
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
