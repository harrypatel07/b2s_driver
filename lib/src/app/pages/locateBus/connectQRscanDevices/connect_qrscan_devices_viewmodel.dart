import 'dart:async';

import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/service/bluetooh-barcode-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectQRScanDeviceViewModel extends ViewModelBase {
  BluetoothBarcodeService barcodeService = BluetoothBarcodeService();
  List<BluetoothDevice> listBluetoothDeviceConnected = List();
  StreamSubscription streamBluetoothAvailable;
  BluetoothDevice bluetoothDevice;
  bool isBluetoothOn = false;
  bool isScanning = false;
  ConnectQRScanDeviceViewModel() {
    listenBluetoothAvailable();
    isScanning = true;
    Future.delayed(barcodeService.durationScan).then((_) {
      try {
        isScanning = false;
        this.updateState();
      } catch (e) {}
    });
  }

  @override
  dispose() {
    if (streamBluetoothAvailable != null) streamBluetoothAvailable.cancel();
    stopScan();
    // barcodeService.onDispose();
    super.dispose();
  }

  onTapDisconnectDevice(BluetoothDevice bluetoothDevice) async {
    await bluetoothDevice.disconnect();
    if (barcodeService.isScanning) await stopScan();
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      barcodeService.scanResult();
    });
  }

  onTapConnectDevice(ScanResult scanResult) async {
    await scanResult.device.connect();
    if (barcodeService.isScanning) await stopScan();
    // Future.delayed(Duration(milliseconds: 200)).then((_) {
    //   barcodeService.scanResult();
    // });
    Navigator.pop(context, scanResult.device);
  }

  Widget handleButtonConnectedDevices(
      AsyncSnapshot<BluetoothDeviceState> snapshot,
      BluetoothDevice bluetoothDevice) {
    VoidCallback onPressed;
    String text;
    switch (snapshot.data) {
      case BluetoothDeviceState.connected:
        onPressed = () => onTapDisconnectDevice(bluetoothDevice);
        text = 'NGẮT KẾT NỐI';
        break;
      case BluetoothDeviceState.disconnected:
        onPressed = () => bluetoothDevice.connect();
        text = 'KẾT NỐI';
        break;
      default:
        onPressed = null;
        text = snapshot.data.toString().substring(21).toUpperCase();
        break;
    }
    return FlatButton(
        color: Colors.black,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }

  stopScan() async {
    await barcodeService.instance.stopScan();
  }

  onTapRefresh() async {
    if (!isBluetoothOn) return;
    isScanning = true;
    this.updateState();
    if (barcodeService.isScanning) await stopScan();
    Future.delayed(Duration(milliseconds: 500)).then((_) {
      barcodeService.scanResult();
    });
    Future.delayed(barcodeService.durationScan).then((_) {
      try {
        isScanning = false;
        this.updateState();
      } catch (e) {}
    });
  }

  listenBluetoothAvailable() {
    if (streamBluetoothAvailable != null) streamBluetoothAvailable.cancel();
    streamBluetoothAvailable =
        barcodeService.checkBluetoothAvaiable().listen((onData) {
      if (onData != isBluetoothOn) {
        isBluetoothOn = onData;
        this.updateState();
      }
    });
  }
}
