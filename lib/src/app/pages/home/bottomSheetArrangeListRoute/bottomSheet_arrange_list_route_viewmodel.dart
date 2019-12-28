import 'dart:async';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:flutter/material.dart';

class BottomSheetArrangeListRouteViewModel extends ViewModelBase{
  BottomSheetViewModelBase bottomSheetViewModelBase;
  DriverBusSession driverBusSession;
  StreamSubscription streamCloud;
  List<ChildDrenStatus> listChildrenStatus = List();
  List<RouteBus> listRouteBus = List();
  BottomSheetArrangeListRouteViewModel();
  @override
  dispose() {
    if (streamCloud != null) streamCloud.cancel();
    super.dispose();
  }

//  listenData() async {
//    if (streamCloud != null) streamCloud.cancel();
//    streamCloud = await cloudService.busSession.listenBusSessionForDriver(
//        bottomSheetViewModelBase.driverBusSession, () {
//      this.updateState();
//      bottomSheetViewModelBase.onCreateDriverBusSessionReport();
//      bottomSheetViewModelBase.driverBusSession.saveLocal();
//      bottomSheetViewModelBase.updateState();
//    });
//  }
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
  onTap(int position){
    Navigator.pop(context,position);
  }
  onCreateListRouteBus(){
    driverBusSession.listRouteBus.forEach((routeBus){
      listRouteBus.add(routeBus);
    });
  }
  onTapSave() {
    driverBusSession.listRouteBus = listRouteBus;
    driverBusSession.saveLocal();
    Navigator.pop(context);
  }
}