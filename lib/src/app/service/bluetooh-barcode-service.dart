import 'dart:async';
import 'dart:convert';

import 'package:flutter_blue/flutter_blue.dart';

class BluetoothBarcodeService {
  final String _serviceUUID = "d973f2e0-b19e-11e2-9e96-0800200c9a66";
  final String _characteristicUUID = "d973f2e1-b19e-11e2-9e96-0800200c9a66";
  final Duration _durationScan = Duration(seconds: 4);
  final List<String> _deviceName = ["BLE-Chat", "B2S-Scanner"];
  StreamController _streamController = StreamController.broadcast();
  Stream<String> get _streamListenDataQRCode => _streamController.stream;
  FlutterBlue instance;
  Timer _timer;
  String _qrString = "";
  BluetoothBarcodeService() {
    instance = FlutterBlue.instance;
  }

  onDispose() {
    _streamController.close();
    if (_timer != null) _timer.cancel();
  }

  Future<dynamic> startScan() {
    return instance.startScan(
      scanMode: ScanMode.balanced,
      timeout: _durationScan,
    );
  }

  Stream<List<ScanResult>> scanResult() {
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
    device.state.listen((onData) async {
      if (onData == BluetoothDeviceState.connected) {
        List<BluetoothService> services = await device.discoverServices();
        services.forEach((service) {
          if (service.uuid.toString() == _serviceUUID) {
            service.characteristics.forEach((characteristic) async {
              if (characteristic.uuid.toString() == _characteristicUUID) {
                await characteristic.setNotifyValue(true);
                characteristic.value.listen((value) {
                  if (_timer != null) _timer.cancel();
                  print(value);
                  _timer = Timer.periodic(Duration(milliseconds: 200), (t) {
                    _streamController.add(_qrString);
                    _qrString = "";
                    _timer.cancel();
                  });
                  _qrString += utf8.decode(value);
                });
              }
            });
          }
        });
      }
    });
    return _streamListenDataQRCode;
  }
}
