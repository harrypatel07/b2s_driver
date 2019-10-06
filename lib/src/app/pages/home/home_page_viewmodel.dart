import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:flutter/material.dart';

class HomePageViewModel extends ViewModelBase {
  List<DriverBusSession> listDriverBusSession = DriverBusSession.list;
    TabController tabController;
  HomePageViewModel();

  List<Children> getListChildrenForTimeLine(DriverBusSession driverBusSession, int routeBusID){
     List<Children> _listChildren = [];
     var _childrenRoute = ChildDrenRoute.getChilDrenRouteByRouteID(driverBusSession.childDrenRoute, routeBusID);
     if(_childrenRoute != null)
     _listChildren = Children.getChildrenByListID(driverBusSession.listChildren, _childrenRoute.listChildrenID);
     return _listChildren;
  }

  onTapPickUp(DriverBusSession driverBusSession, Children children) {
      var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) => item.childrenID == children.id);
      childrenStatus.statusID = 1;
      this.updateState();
  }
}