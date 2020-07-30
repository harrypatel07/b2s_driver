import 'dart:async';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/models/ticketCode.dart';
import 'package:b2s_driver/src/app/pages/bottomSheet/bottom_sheet_custom.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/service/cloudFirestore-service.dart';
import 'package:b2s_driver/src/app/service/text-to-speech-service.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetViewModelBase extends ViewModelBase {
  DriverBusSession driverBusSession;
  CloudFiresStoreService cloudSerivce = CloudFiresStoreService();
  BottomSheetViewModelBase();
  int position;
  RouteBus routeBus;
  StreamSubscription streamCloud;
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
  dispose() {
    if (streamCloud != null) streamCloud.cancel();
    super.dispose();
  }

  onCreateDriverBusSessionReport() {
    //listChildrenPaidTicket = Children.getListChildrenPaidTicket(driverBusSession.listChildren);
    driverBusSession.totalChildrenLeave = getCountChildrenByStatusBusId(3);
    driverBusSession.totalChildrenInBus = getCountChildrenByStatusBusId(1);
    driverBusSession.totalChildrenPick = getCountChildrenByStatusBusId(1) +
        getCountChildrenByStatusBusId(2) +
        getCountChildrenByStatusBusId(4);
    driverBusSession.totalChildrenDrop =
        getCountChildrenByStatusBusId(2) + getCountChildrenByStatusBusId(4);
  }

  int getCountChildrenByStatusBusId(statusBusId) {
    int sum = 0;
    driverBusSession.listChildren.forEach((child) {
      List<ChildDrenStatus> checkConstraint = driverBusSession.childDrenStatus
          .where((status) =>
              status.childrenID == child.id && status.statusID == statusBusId)
          .toList();
      if (checkConstraint.length > 0) sum++;
    });
    return sum;
  }

  onTap(RouteBus _route, int _pos) {
    this.position = _pos;
    this.routeBus = _route;
    if (_pos >= 2) {
      if (countRouteBusNotFinishPrev(_pos) == 0)
        showBottomSheet(_pos);
      else {
        LoadingDialog()
            .showMsgDialogWithButton(context, getTextPopupConfirm(_pos))
            .then((result) {
          try {
            if (result) showBottomSheet(_pos);
          } catch (e) {}
        });
      }
    } else
      showBottomSheet(_pos);
  }

  String getTextPopupConfirm(int pos) {
    String listPoint = '';
    for (int i = 0; i < pos - 1; i++)
      if (!driverBusSession.listRouteBus[i].status) {
        (i > 0 && i < pos - 1)
            ? listPoint == ''
                ? listPoint += '${i + 1}'
                : listPoint += ' - ${i + 1}'
            : listPoint += '${i + 1}';
      }
    var many = '';
    if (countRouteBusNotFinishPrev(pos) > 1) {
      many = 'các ';
      return """Bạn chưa hoàn thành $manyđiểm trước đó:
  $listPoint
Bạn có muốn tiếp tục?
""";
    } else
      return """Bạn chưa hoàn thành $manyđiểm trước đó: $listPoint
Bạn có muốn tiếp tục?
""";
  }

  int countRouteBusNotFinishPrev(int pos) {
    int count = 0;
    for (int i = 0; i < pos - 1; i++)
      if (!driverBusSession.listRouteBus[i].status) count++;
    return count;
  }

  void showBottomSheet(int pos) {
    try {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext bc) {
            return BottomSheetCustom(
                arguments: BottomSheetCustomArgs(viewModel: this));
          }).then((_) {
        this.updateState();
      });
    } catch (e) {
//      print(e);
    }
  }

  listenData() async {
    if (streamCloud != null) streamCloud.cancel();
    streamCloud = await cloudService.busSession
        .listenBusSessionForDriver(this.driverBusSession, () {
      this.updateState();
      this.onCreateDriverBusSessionReport();
      this.driverBusSession.saveLocal();
      this.updateState();
    });
  }

  bool checkTicketCodeWhenTapFinished(String qrResult) {
    TicketCode ticketCode = TicketCode();
    bool checkCode = ticketCode.checkTicketCode(qrResult);
    Driver driver = Driver();

    if (checkCode) {
      var _vehicle =
          driver.listVehicle.firstWhere((item) => item.id == driver.vehicleId);
      if (_vehicle.xQrCode != null && qrResult == _vehicle.xQrCode)
        return true;
      else {
        TextToSpeechService.speak(
            "Mã này không phải của xe ${driver.vehicleName}.Xin vui lòng kiểm tra lại.");
        LoadingDialog.showMsgDialog(context,
            "Mã này không phải của xe ${driver.vehicleName}.Xin vui lòng kiểm tra lại.");
        return false;
      }
    } else {
      TextToSpeechService.speak("Mã này không hợp lệ.Xin vui lòng thử lại.");
      LoadingDialog.showMsgDialog(
          context, "Mã này không hợp lệ.Xin vui lòng thử lại.");
      return false;
    }
  }

  Future<bool> checkSessionFinishedByAnotherRole(
      List<int> listIdPicking) async {
    //Kiểm tra attendant đã hoàn thành chuyến
    bool result = await api.checkUserRoleFinishedBusSession(listIdPicking);
    return result;
  }

  //-----Handler QRcodeDevice-----//
  listenQRcodeDevice(String qrCodeResult) {
    TicketCode ticketCode = TicketCode();
    bool checkCode = ticketCode.checkTicketCode(qrCodeResult);
    if (checkCode) {
      String firstCharCode = qrCodeResult.substring(0, 1);
      switch (firstCharCode) {
        case "1": //Mã thẻ học sinh
          //Tìm học sinh có mã thẻ như qrCodeResult
          var children = driverBusSession.listChildren.firstWhere(
              (child) => child.ticketCode == qrCodeResult,
              orElse: () => null);
          if (children != null) {
            var childrenStatusPick = driverBusSession.childDrenStatus
                .firstWhere(
                    (stt) =>
                        stt.childrenID == children.id &&
                        stt.statusID != 3 &&
                        stt.statusID == 0 &&
                        stt.typePickDrop == 0,
                    orElse: () => null);
            if (childrenStatusPick != null) {
              //Kiểm tra trường hợp 1 học sinh quét nhìu lần liên tiếp,
              if (childrenStatusPick.timePickDrop == null)
                childrenStatusPick.timePickDrop = DateTime.now();

              return onTapPickUpLocateBus(
                  driverBusSession, children, childrenStatusPick);
            }
            var childrenStatusDrop = driverBusSession.childDrenStatus
                .firstWhere(
                    (stt) =>
                        stt.childrenID == children.id &&
                        stt.statusID != 3 &&
                        stt.statusID == 1 &&
                        stt.typePickDrop == 1,
                    orElse: () => null);

            if (childrenStatusDrop != null) {
              //Kiểm tra trường hợp 1 học sinh quét nhìu lần liên tiếp,
              childrenStatusPick = driverBusSession.childDrenStatus.firstWhere(
                  (stt) =>
                      stt.childrenID == children.id && stt.typePickDrop == 0,
                  orElse: () => null);
              if (childrenStatusPick != null) {
                if (childrenStatusPick.timePickDrop != null) if (DateTime.now()
                        .difference(childrenStatusPick.timePickDrop)
                        .inSeconds >
                    (60 * 3)) {
                } else {
                  TextToSpeechService.speak(
                      'Mã vé này đã được quét.Vui lòng bỏ qua.');
                  return LoadingDialog.showMsgDialog(
                      context, "'Mã vé này đã được quét.Vui lòng bỏ qua.",
                      showByBluetoothDevice: true);
                }
              }
              return onTapPickUpLocateBus(
                  driverBusSession, children, childrenStatusDrop);
            }
          } else {
            TextToSpeechService.speak(
                'Mã vé không có đăng ký trong chuyến xe này.');
            return LoadingDialog.showMsgDialog(
                context, "Mã vé không có đăng ký trong chuyến xe này.",
                showByBluetoothDevice: true);
          }
          break;
        case "2": // Mã thẻ xe
          _finishSessionByQrCode(qrCodeResult);
          break;
        default:
      }
    } else {
      TextToSpeechService.speak('Mã vé này không hợp lệ.Xin vui lòng thử lại.');
      return LoadingDialog.showMsgDialog(
          context, "Mã vé này không hợp lệ.Xin vui lòng thử lại.",
          showByBluetoothDevice: true);
    }
  }

  _finishSessionByQrCode(String qrCodeResult) async {
    if (driverBusSession.totalChildrenPick ==
            driverBusSession.totalChildrenDrop &&
        (driverBusSession.totalChildrenPick +
                driverBusSession.totalChildrenLeave) ==
            driverBusSession.totalChildrenRegistered) {
      driverBusSession.status = true;
      this.updateState();
      //Kiểm tra attendant đã hoàn thành chuyến
      List<int> listIdPicking =
          driverBusSession.childDrenStatus.map((item) => item.id).toList();
      bool checkFinished =
          await checkSessionFinishedByAnotherRole(listIdPicking);
      this.updateState();
      if (!checkFinished) {
        if (qrCodeResult != null) {
          if (checkTicketCodeWhenTapFinished(qrCodeResult)) {
            List<int> listIdPicking = driverBusSession.childDrenStatus
                .map((item) => item.id)
                .toList();
            api.updateUserRoleFinishedBusSession(listIdPicking, 0);
            driverBusSession.clearLocal();
          } else
            return false;
        } else
          return false;
      } else
        driverBusSession.clearLocal();
      TextToSpeechService.speak("Chuyến xe đã hoàn thành.Xin cám ơn.");
      Navigator.pushReplacementNamed(context, TabsPage.routeName,
          arguments: TabsArgument(routeChildName: HomePage.routeName));
    } else {
      TextToSpeechService.speak(
          "Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.");
      LoadingDialog.showMsgDialog(context,
          'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
    }
  }

  onTapPickUpLocateBus(DriverBusSession driverBusSession, Children children,
      ChildDrenStatus childrenStatus) {
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID != 0)
      return;
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID != 1)
      return;
    if (childrenStatus.typePickDrop == 0 && childrenStatus.statusID == 0) {
      driverBusSession.totalChildrenPick++;
      TextToSpeechService.speak('học sinh ${children.name} đã lên xe.');
      updateStatusPickChildren(childrenStatus.id);
      //Update tọa độ xe đến trạm
      api.updatePickingRouteByDriver(childrenStatus.pickingRoute, 0);
    }
    if (childrenStatus.typePickDrop == 1 && childrenStatus.statusID == 1) {
      driverBusSession.totalChildrenDrop++;
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

    this.onCreateDriverBusSessionReport();
    this.updateState();
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
}
