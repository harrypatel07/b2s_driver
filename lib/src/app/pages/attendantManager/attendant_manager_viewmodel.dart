import 'dart:async';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bottom_sheet_viewmodel_abstract.dart';
import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/pages/home/home_page.dart';
import 'package:b2s_driver/src/app/pages/locateBus/connectQRscanDevices/connect_qrscan_devices_page.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page.dart';
import 'package:b2s_driver/src/app/service/barcode-service.dart';
import 'package:b2s_driver/src/app/service/bluetooh-barcode-service.dart';
import 'package:b2s_driver/src/app/widgets/ts24_utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AttendantManagerViewModel extends BottomSheetViewModelBase {
  BluetoothBarcodeService barcodeService = BluetoothBarcodeService();
  BluetoothDevice bluetoothDeviceConnected;
  StreamSubscription streamQrCode;
  StreamSubscription streamBluetoothAvailable;
  StreamSubscription streamConnectedDevice;
  bool isBluetoothOn = false;
  AttendantManagerViewModel() {
    listenBluetoothAvailable();
    listenBluetoothDeviceConnected();
  }
  int countChildrenPickDrop(int routeBusId, int typePickDrop) {
    int count = 0;
    driverBusSession.childDrenStatus.forEach((status) {
      if (status.routeBusID == routeBusId &&
          status.typePickDrop == typePickDrop &&
          status.statusID != 3) count++;
    });
    return count;
  }

  onTapFinish() async {
    if (driverBusSession.totalChildrenPick ==
            driverBusSession.totalChildrenDrop &&
        (driverBusSession.totalChildrenPick +
                driverBusSession.totalChildrenLeave) ==
            driverBusSession.totalChildrenRegistered) {
      driverBusSession.status = true;
      loading = true;
      this.updateState();
      //Kiểm tra driver đã hoàn thành chuyến
      List<int> listIdPicking =
          driverBusSession.childDrenStatus.map((item) => item.id).toList();
      bool checkFinished =
          await checkSessionFinishedByAnotherRole(listIdPicking);
      loading = false;
      this.updateState();
      if (!checkFinished) {
        String barcode = await BarCodeService.scan();
        print(barcode);
        if (barcode != null) {
          if (checkTicketCodeWhenTapFinished(barcode)) {
            driverBusSession.clearLocal();
            api.updateUserRoleFinishedBusSession(listIdPicking, 1);
          } else
            return false;
        } else
          return false;
      } else
        driverBusSession.clearLocal();
      Navigator.pushReplacementNamed(context, TabsPage.routeName,
          arguments: TabsArgument(routeChildName: AttendantPage.routeName));
    } else
      LoadingDialog.showMsgDialog(context,
          'Chưa hoàn thành tất cả các trạm, không thể kết thúc chuyến.');
  }

  Future<bool> checkSessionFinishedByAnotherRole(
      List<int> listIdPicking) async {
    //Kiểm tra attendant đã hoàn thành chuyến
    bool result = await api.checkUserRoleFinishedBusSession(listIdPicking);
    return result;
  }

  showNotifyCantBack() {
    LoadingDialog().showMsgDialogWithCloseButton(context,
        "Chuyến xe vẫn chưa hoàn thành, bạn không thể thực hiện thao tác này.");
  }

  onTapBackButton() {
    var listCheck = driverBusSession.childDrenStatus
        .where((status) => status.statusID != 0)
        .toList();
    if (listCheck.length == 0 || listCheck == null) {
      if (Navigator.canPop(context))
        Navigator.pop(context);
      else
        Navigator.pushReplacementNamed(context, TabsPage.routeName,
            arguments: TabsArgument(routeChildName: HomePage.routeName));
    } else
      showNotifyCantBack();
  }

  onTapSettingBluetoothDevice() {
    Navigator.pushNamed(context, ConnectQRScanDevicesPage.routeName,
            arguments: this.bluetoothDeviceConnected)
        .then((bluetoothDevice) {
      listenBluetoothAvailable();
      if (bluetoothDevice != null) {
        this.bluetoothDeviceConnected = bluetoothDevice;
        this.updateState();
        listenQrCode(bluetoothDevice);
      } else
        this.updateState();
    });
  }

  listenBluetoothAvailable() {
    if (streamBluetoothAvailable != null) streamBluetoothAvailable.cancel();
    streamBluetoothAvailable =
        barcodeService.checkBluetoothAvaiable().listen((onData) {
      if (onData != isBluetoothOn) {
        isBluetoothOn = onData;
        if (!onData) {
          ToastController.show(
              context: context,
              message:
                  "Bluetooth chưa bật hoặc thiết bị không có chức năng bluetooth.",
              duration: Duration(seconds: 2));
        }
        this.updateState();
      }
    });
  }

  listenBluetoothDeviceConnected() {
    if (streamConnectedDevice != null) streamConnectedDevice.cancel();
    streamConnectedDevice =
        barcodeService.getConnectedDevice().listen((onData) {
      if ((this.bluetoothDeviceConnected == null ||
              this.bluetoothDeviceConnected != onData) &&
          onData != null) {
        this.bluetoothDeviceConnected = onData;
        this.updateState();
        listenQrCode(this.bluetoothDeviceConnected);
      }
    });
//    barcodeService.getConnectedDevice().then((bluetoothDevice){
//      if(bluetoothDevice != null)
//        listenQrCode(bluetoothDevice);
//    });
  }

  listenQrCode(BluetoothDevice bluetoothDevice) {
    if (streamQrCode != null) streamQrCode.cancel();
    streamQrCode = barcodeService
        .listenDataQrCode(device: this.bluetoothDeviceConnected)
        .listen((onData) {
      if (onData.length > 0) listenQRcodeDevice(onData);
      print(onData);
    });
  }
}
