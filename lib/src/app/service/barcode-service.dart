import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class BarCodeService {
  static Future<String> scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        print("The user did not grant the camera permission!");
        return null;
      } else {
        print('Unknown error: $e');
        return null;
      }
    } on FormatException {
      print(
          'null (User returned using the "back"-button before scanning anything. Result)');
      return null;
    } catch (e) {
      print('Unknown error: $e');
      return null;
    }
  }
}
