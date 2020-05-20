import 'dart:async';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/material.dart';

class BottomSheetArrangeListRouteViewModel extends ViewModelBase {
  BottomSheetViewModelBase bottomSheetViewModelBase;
  DriverBusSession driverBusSession;
  StreamSubscription streamCloud;
  List<ChildDrenStatus> listChildrenStatus = List();
  List<RouteBus> listRouteBus = List();
  bool isChanged = false;
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

  onTap(int position) {
    Navigator.pop(context, position);
  }

  onCreateListRouteBus() {
    driverBusSession.listRouteBus.forEach((routeBus) {
      listRouteBus.add(routeBus);
    });
  }

  onTapSave() async {
    Driver driver = Driver();
    List<int> listRouteId = List();
    listRouteId =
        listRouteBus.map((route) => int.parse(route.id.toString())).toList();
    if (driverBusSession.type == 0) {
      listRouteId.removeLast();
    } else {
      listRouteId.removeAt(0);
    }
    LoadingDialog.showLoadingDialog(context, "Đang thay đổi lịch trình");
    var result = await api.updateListRouteBus(
        listIdRouteBus: listRouteId,
        driverId: driver.id,
        vehicleId: driver.vehicleId,
        type: driverBusSession.type);
    print(result);
    if (result) {
      isChanged = true;
      driverBusSession.listRouteBus = listRouteBus;
      driverBusSession.saveLocal();
      LoadingDialog.hideLoadingDialog(context);
      Navigator.pop(context, isChanged);
    } else {
      LoadingDialog.showMsgDialog(context, "Không thể thay đổi lịch trình");
      Future.delayed(Duration(seconds: 1)).then((_) {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pop(context, isChanged);
      });
    }
  }
}
