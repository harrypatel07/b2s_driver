import 'dart:async';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/menu.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:b2s_driver/src/app/service/cloudFirestore-service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession;
  bool isShowListButton = false;
  TabsPageViewModel tabsPageViewModel;
  bool isLoadingData = false;
  List<Children> listChildrenSS1 = new List();
  List<Children> listChildrenSS2 = new List();
  String busId = "";
//  DriverBusSession driverBusSession;
  Driver driver = Driver();
  ScheduleViewModel(){
    onLoad(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }
  onLoad(String day){
    loading = true;
    api.getListDriverBusSession(vehicleId: driver.vehicleId,driverId: driver.id,date: day).then((value){
      listDriverBusSession = value;
      busId = value[0].busID;
      loading = false;
      this.updateState();
    });
    this.updateState();
  }

  List<Children> getListChildrenForTimeLine(
      DriverBusSession driverBusSession, int routeBusID) {
    List<Children> _listChildren = [];
    var _childrenRoute = ChildDrenRoute.getChilDrenRouteByRouteID(
        driverBusSession.childDrenRoute, routeBusID);
    if (_childrenRoute != null)
      _listChildren = Children.getChildrenByListID(
          driverBusSession.listChildren, _childrenRoute.listChildrenID);
    return _listChildren;
  }



  @override
  void dispose() {
    //streamCloud.cancel();
    super.dispose();
  }

  int getCountChildrenByStatus(
      List<ChildDrenStatus> listChildDrenStatus, int statusId, int type) {
    int sum = 0;
    if (type == DriverBusSession.list[0].type) {
      for (int i = 0; i < listChildrenSS1.length; i++)
        for (int j = 0; j < listChildDrenStatus.length; j++)
          if (listChildDrenStatus[j].statusID == statusId &&
              listChildrenSS1[i].id == listChildDrenStatus[j].id) sum++;
    } else {
      for (int i = 0; i < listChildrenSS2.length; i++)
        for (int j = 0; j < listChildDrenStatus.length; j++)
          if (listChildDrenStatus[j].statusID == statusId &&
              listChildrenSS2[i].id == listChildDrenStatus[j].id) sum++;
    }
    return sum;
  }

  void addChildrenByDriverBusSessionType(int type, Children children) {
    if (type == DriverBusSession.list[0].type) {
      if (constraint(listChildrenSS1, children)) listChildrenSS1.add(children);
    } else if (constraint(listChildrenSS2, children))
      listChildrenSS2.add(children);
  }

  bool constraint(List<Children> listChildren, Children children) {
    for (int i = 0; i < listChildren.length; i++)
      if (listChildren[i].id == children.id) return false;
    return true;
  }

  int getLengthListChildrenByBusSessionType(int type) {
    if (type == DriverBusSession.list[0].type)
      return listChildrenSS1.length;
    else
      return listChildrenSS2.length;
  }

  void listContentOnTap(Menu menu) {
    this.updateState();
    tabsPageViewModel = ViewModelProvider.of(context);
    if (tabsPageViewModel != null)
      tabsPageViewModel.onSlideMenuTapped(menu.index);
  }
  reloadData(bool isToday){
    if(isToday){
//      listenData();
      isLoadingData = true;
      listChildrenSS1 = List();
      listChildrenSS2 = List();
      listDriverBusSession[0].type = 0;
      listDriverBusSession[1].type = 1;
      isLoadingData = false;
    }
    else{
//      listenData();
      isLoadingData = true;
      listChildrenSS1 = List();
      listChildrenSS2 = List();
      listDriverBusSession[0].type = 1;
      listDriverBusSession[1].type = 0;
      isLoadingData = false;
    }
  }
  onTapItemPick(){
    Navigator.pushNamed(context, HomePage.routeName,
        arguments:
            listDriverBusSession[0]);
  }
  onTapItemDrop(){
    Navigator.pushNamed(context, HomePage.routeName,
        arguments:
            listDriverBusSession[1]);
  }
}
