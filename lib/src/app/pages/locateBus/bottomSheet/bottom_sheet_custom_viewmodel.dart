import 'dart:async';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/service/barcode-service.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:flutter/cupertino.dart';

class BottomSheetCustomViewModel extends ViewModelBase {
  LocateBusPageViewModel localBusViewModel;
  List<ChildDrenStatus> listChildrenStatus = List();
  StreamSubscription streamCloud;
  BottomSheetCustomViewModel();

  @override
  dispose() {
    if (streamCloud != null) streamCloud.cancel();
    super.dispose();
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

  onTapLeave(
      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
        item.childrenID == children.id && item.routeBusID == routeBus.id);
    DriverBusSession.updateChildrenStatusIdByLeave(
        driverBusSession: driverBusSession, childDrenStatus: childrenStatus);
    //Đồng bộ firestore
    cloudService.busSession.updateBusSessionFromChildrenStatus(childrenStatus);
//    updateStatusLeaveChildren(childrenStatus.id);
    this.updateState();
    if (localBusViewModel != null) {
      localBusViewModel.onCreateDriverBusSessionReport();
      localBusViewModel.updateState();
    }
  }

  onTapPickUpLocateBus(
      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
        item.childrenID == children.id && item.routeBusID == routeBus.id);
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID != 0)
      return;
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID != 1)
      return;
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID == 0) {
      localBusViewModel.driverBusSession.totalChildrenPick++;
//      updateStatusPickChildren(childrenStatus.id);
    }
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID == 1) {
      localBusViewModel.driverBusSession.totalChildrenDrop++;
//      updateStatusDropChildren(childrenStatus.id);
    }
    DriverBusSession.updateChildrenStatusIdByPickDrop(
        driverBusSession: driverBusSession, childDrenStatus: childrenStatus);

    //Đồng bộ firestore
    cloudService.busSession.updateBusSessionFromChildrenStatus(childrenStatus);

    this.updateState();
    if (localBusViewModel != null) {
//      localBusViewModel.driverBusSession.totalChildrenInBus += 1;
      localBusViewModel.onCreateDriverBusSessionReport();
      localBusViewModel.updateState();
    }
  }

  updateStatusLeaveChildren(int childrenStatusId) {
    // List<int> listIdPicking = List();
    // listIdPicking.add(childrenStatusId);
    api.updateLeaveByIdPicking([childrenStatusId]).then((r) {
      if (r)
        print('Success');
      else
        print('fails');
    });
  }

  updateStatusPickChildren(int childrenStatusId) {
    // List<int> listIdPicking = List();
    // listIdPicking.add(childrenStatusId);
    api.updateStatusPickByIdPicking([childrenStatusId]).then((r) {
      if (r)
        print('Success');
      else
        print('fails');
    });
  }

  updateStatusDropChildren(int childrenStatusId) {
    List<int> listIdDropping = List();
    listIdDropping.add(childrenStatusId);
    api.updateStatusDropByIdChildren(listIdDropping).then((r) {
      if (r)
        print('Success');
      else
        print('fails');
    });
  }

  onTapFinishRoute() {
    if (!localBusViewModel.routeBus.status) {
      var listPick = listChildrenStatus
          .where((statusBus) =>
              statusBus.statusID == 0 && statusBus.typePickDrop == 0)
          .toList();
      var listDrop = listChildrenStatus
          .where((statusBus) =>
              statusBus.statusID == 1 && statusBus.typePickDrop == 1)
          .toList();
      if ((listChildrenStatus[0].typePickDrop == 0 && listPick.length > 0) ||
          (listChildrenStatus[0].typePickDrop == 1 && listDrop.length > 0))
        ToastController.show(
            context: context,
            message: 'Vẫn còn học sinh, ban chưa thể hoàn thành.',
            duration: Duration(milliseconds: 1000));
      else {
        localBusViewModel.routeBus.status = true;
        var route = localBusViewModel.driverBusSession.listRouteBus.singleWhere(
            (routeBus) => routeBus.id == localBusViewModel.routeBus.id);
        route.status = true;
        Navigator.pop(context, true);
      }
    }
  }

  Future onTapScanQRCode() async {
    String barCode = await BarCodeService.scan();
    if (barCode != null) return 0;
  }
//  onTapChangeChildrenStatus(DriverBusSession driverBusSession,
//      Children children, RouteBus routeBus, int statusID) {
//    var childrenStatus = driverBusSession.childDrenStatus.singleWhere((item) =>
//    item.childrenID == children.id && item.routeBusID == routeBus.id);
//    childrenStatus.statusID = statusID;
//    cloudSerivce.busSession.updateDriverBusSession(driverBusSession);
//    cloudSerivce.busSession.updateStatusChildrenBus(children, childrenStatus);
//    this.updateState();
//  }

  listenData() async {
    if (streamCloud != null) streamCloud.cancel();
    streamCloud = await cloudService.busSession
        .listenBusSessionForDriver(localBusViewModel.driverBusSession, () {
      this.updateState();
      localBusViewModel.onCreateDriverBusSessionReport();
      localBusViewModel.updateState();
    });
  }
}
