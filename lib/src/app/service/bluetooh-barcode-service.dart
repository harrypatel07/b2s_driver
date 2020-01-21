import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothBarcodeService {
  final String _serviceUUID = "d973f2e0-b19e-11e2-9e96-0800200c9a66";
  final String _characteristicUUID = "d973f2e1-b19e-11e2-9e96-0800200c9a66";
  final Duration durationScan = Duration(seconds: 10);
  final List<String> _deviceName = ["BLE-Chat", "B2S-Scanner"];
  StreamController<String> _streamController =
      StreamController<String>.broadcast();
  Stream<String> get _streamListenDataQRCode => _streamController.stream;

  StreamController<bool> _streamControllerBluetoothState =
      StreamController<bool>.broadcast();
  Stream<bool> get _streamListenBluetoothState =>
      _streamControllerBluetoothState.stream;

  StreamController<BluetoothDevice> _streamControllerConnectedDevice =
      StreamController<BluetoothDevice>.broadcast();
  Stream<BluetoothDevice> get _streamListenConnectedDevice =>
      _streamControllerConnectedDevice.stream;

  StreamSubscription _streamIsScanning;
  StreamSubscription _streamDeviceState;
  StreamSubscription _streamCharacteristic;
  StreamSubscription _streamBluetoothState;
  StreamSubscription _streamConnectedDevice;
  bool isScanning = false;
  FlutterBlue instance;
  Timer _timer;
  String _qrString = "";
  BluetoothBarcodeService() {
    instance = FlutterBlue.instance;
    _streamIsScanning = instance.isScanning.listen((result) {
      isScanning = result;
    });
  }

  onDispose() {
    _streamIsScanning.cancel();
    if (_streamDeviceState != null) _streamDeviceState.cancel();
    if (_streamCharacteristic != null) _streamCharacteristic.cancel();
    if (_streamBluetoothState != null) _streamBluetoothState.cancel();
    if (_streamConnectedDevice != null) _streamConnectedDevice.cancel();
    _streamController.close();
    _streamControllerBluetoothState.close();
    _streamControllerConnectedDevice.close();

    if (_timer != null) _timer.cancel();
  }

  Future<dynamic> startScan() {
    return instance.startScan(
      scanMode: ScanMode.balanced,
      timeout: durationScan,
    );
  }

  Stream<List<ScanResult>> scanResult() {
    if(isScanning == false)
      this.startScan();
    return instance.scanResults;
  }

  bool checkTargetDeive(ScanResult sr) {
    bool result = false;
    for (var item in _deviceName) {
      if (sr.device.name == item) {
        result = true;
        break;
      }
    }
    return result;
  }

  Stream<String> listenDataQrCode({BluetoothDevice device}) {
    if (_streamDeviceState != null) _streamDeviceState.cancel();
    _streamDeviceState = device.state.listen((onData) async {
      if (onData == BluetoothDeviceState.connected) {
        _qrString = "";
        List<BluetoothService> services = await device.discoverServices();
        services.forEach((service) {
          if (service.uuid.toString() == _serviceUUID) {
            service.characteristics.forEach((characteristic) async {
              if (characteristic.uuid.toString() == _characteristicUUID) {
                await characteristic.setNotifyValue(true);
                if (_streamCharacteristic != null)
                  _streamCharacteristic.cancel();
                _streamCharacteristic = characteristic.value.listen((value) {
                  if (_timer != null) _timer.cancel();
                  print(value);
                  _timer = Timer.periodic(Duration(milliseconds: 200), (t) {
                    if (_qrString.length > 0)
                      _qrString = _qrString.replaceAll("\r", "");
                    _streamController.add(_qrString);
                    _qrString = "";
                    _timer.cancel();
                  });
                  _qrString += utf8.decode(value).trim();
                });
              }
            });
          }
        });
      }
    });
    return _streamListenDataQRCode;
  }

  Stream<bool> checkBluetoothAvaiable() {
    if (_streamBluetoothState != null) _streamBluetoothState.cancel();
    _streamBluetoothState = instance.state.listen((onData) {
      if (onData == BluetoothState.on)
        _streamControllerBluetoothState.add(true);
      else
        _streamControllerBluetoothState.add(false);
    });
    return _streamListenBluetoothState;
  }

  Stream<BluetoothDevice> getConnectedDevice() {
    if (_streamConnectedDevice != null) _streamConnectedDevice.cancel();
    _streamConnectedDevice = Stream.periodic(Duration(seconds: 2))
        .asyncMap((_) => instance.connectedDevices)
        .listen((onData) {
      if (onData.length > 0)
        onData.forEach((f) {
          for (var item in _deviceName) {
            if (f.name == item) {
              // device = f;
              _streamControllerConnectedDevice.add(f);
              if (_streamConnectedDevice != null)
                _streamConnectedDevice.cancel();
              break;
            }
          }
        });
    });
    return _streamListenConnectedDevice;
  }
}
