import 'dart:async';
import 'dart:ffi';

import 'package:b2s_driver/src/app/app_localizations.dart';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/picking-transport-info.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/ticketCode.dart';
import 'package:b2s_driver/src/app/pages/attendantManager/attendant_manager_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/service/barcode-service.dart';
import 'package:b2s_driver/src/app/service/text-to-speech-service.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/popupConfirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class BottomSheetCustomViewModel extends ViewModelBase {
  BottomSheetViewModelBase bottomSheetViewModelBase;
  AttendantManagerViewModel attendantManagerViewModel;
  List<ChildDrenStatus> listChildrenStatus = List();
  StreamSubscription streamCloud;
  bool isUpdatedLocation = false;
  Driver driver = Driver();
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
    //Push thông báo
    api.postNotificationChangeStatus(children, childrenStatus);
//    updateStatusLeaveChildren(childrenStatus.id);
    api.updatePickingTransportInfo(
        PickingTransportInfo.fromChildrenStatus(childrenStatus));
    driverBusSession.saveLocal();
    this.updateState();
    if (bottomSheetViewModelBase != null) {
      bottomSheetViewModelBase.onCreateDriverBusSessionReport();
      bottomSheetViewModelBase.updateState();
    }
  }

  onTapPickUpLocateBus(
      DriverBusSession driverBusSession, Children children, RouteBus routeBus) {
    var childrenStatus = driverBusSession.childDrenStatus.firstWhere(
        (item) =>
            item.childrenID == children.id && item.routeBusID == routeBus.id,
        orElse: () => null);
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID != 0)
      return;
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID != 1)
      return;
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID == 0) {
      bottomSheetViewModelBase.driverBusSession.totalChildrenPick++;
      TextToSpeechService.speak('học sinh ${children.name} đã lên xe.');
      updateStatusPickChildren(childrenStatus.id);
      //Update tọa độ xe đến trạm
      api.updatePickingRouteByDriver(childrenStatus.pickingRoute, 0);
    }
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID == 1) {
      bottomSheetViewModelBase.driverBusSession.totalChildrenDrop++;
      TextToSpeechService.speak('học sinh ${children.name} đã xuống xe.');
      updateStatusDropChildren(childrenStatus.id);
      //Update tọa độ xe đến trạm
      api.updatePickingRouteByDriver(childrenStatus.pickingRoute, 1);
    }
    DriverBusSession.updateChildrenStatusIdByPickDrop(
        driverBusSession: driverBusSession, childDrenStatus: childrenStatus);

    //Đồng bộ firestore
    cloudService.busSession.updateBusSessionFromChildrenStatus(childrenStatus);
    //Push thông báo
    api.postNotificationChangeStatus(children, childrenStatus);
    driverBusSession.saveLocal();
    this.updateState();
    if (bottomSheetViewModelBase != null) {
//      localBusViewModel.driverBusSession.totalChildrenInBus += 1;
      bottomSheetViewModelBase.onCreateDriverBusSessionReport();
      bottomSheetViewModelBase.updateState();
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
    if (!bottomSheetViewModelBase.routeBus.status) {
      var listPick = listChildrenStatus
          .where((statusBus) =>
              (statusBus.statusID == 0) && statusBus.typePickDrop == 0)
          .toList();
      var listDrop = listChildrenStatus
          .where((statusBus) =>
              (statusBus.statusID == 1 || statusBus.statusID == 0) &&
              statusBus.typePickDrop == 1)
          .toList();
      if (listDrop.length > 0 || listPick.length > 0)
        ToastController.show(
            context: context,
            message: 'Vẫn còn học sinh, ban chưa thể hoàn thành.',
            duration: Duration(milliseconds: 1000));
      else {
        bottomSheetViewModelBase.routeBus.status = true;
        var route = bottomSheetViewModelBase.driverBusSession.listRouteBus
            .singleWhere((routeBus) =>
                routeBus.id == bottomSheetViewModelBase.routeBus.id);
        route.status = true;
        bottomSheetViewModelBase.driverBusSession.saveLocal();
        Navigator.pop(context, true);
      }
    }
  }

  Future onTapScanQRCode(DriverBusSession driverBusSession, Children children,
      RouteBus routeBus) async {
    String qrResult = await BarCodeService.scan();
    if (qrResult != null) {
      // onTapPickUpLocateBus(driverBusSession, children, routeBus);
      TicketCode ticketCode = TicketCode();
      bool checkCode = ticketCode.checkTicketCode(qrResult);
      if (checkCode) {
        if (qrResult == children.ticketCode)
          onTapPickUpLocateBus(driverBusSession, children, routeBus);
        else
          return LoadingDialog.showMsgDialog(context,
              "Mã vé này không phải của em ${children.name}.Xin vui lòng kiểm tra lại.");
      } else {
        return LoadingDialog.showMsgDialog(
            context, "Mã vé này không hợp lệ.Xin vui lòng thử lại.");
      }
    }
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
    streamCloud = await cloudService.busSession.listenBusSessionForDriver(
        bottomSheetViewModelBase.driverBusSession, () {
      this.updateState();
      bottomSheetViewModelBase.onCreateDriverBusSessionReport();
      bottomSheetViewModelBase.driverBusSession.saveLocal();
      bottomSheetViewModelBase.updateState();
    });
  }

  onTapUpdateLocation(CallbackUpdateLocation callbackUpdateLocation) {
    popupConfirm(
        context: context,
        title: 'THÔNG BÁO',
        desc:
            'Xác nhận cập nhật tọa độ điểm đón số ${bottomSheetViewModelBase.position}',
        yes: 'Có',
        no: 'Không',
        onTap: () async {
          var myLoc = await Location().getLocation();
          bottomSheetViewModelBase.routeBus.lat = myLoc.latitude;
          bottomSheetViewModelBase.routeBus.lng = myLoc.longitude;
          LoadingDialog.showLoadingDialog(context, "Đang cập nhật tọa độ");
          var result =
              await api.updateCoordRouteBus(bottomSheetViewModelBase.routeBus);
          LoadingDialog.hideLoadingDialog(context);
          if (result) {
            isUpdatedLocation = true;
            callbackUpdateLocation(true);
            LoadingDialog.showLoadingDialog(
                context, "Cập nhật tọa độ thành công");
          } else {
            LoadingDialog.showLoadingDialog(
                context, "Cập nhật tọa độ thất bại");
          }
          Future.delayed(Duration(seconds: 1)).then((result) {
            LoadingDialog.hideLoadingDialog(context);
            Navigator.pop(context);
          });
        });
  }
}
