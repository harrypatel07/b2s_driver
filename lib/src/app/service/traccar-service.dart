import 'dart:convert';
import 'dart:io';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/models-traccar/devices.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:b2s_driver/src/app/models/models-traccar/position.dart';

class TracCarService {
  static String _urlOsmAnd = "traccar.bus2school.vn";
  static String _url = "http://traccar.bus2school.vn/api";
  static String _username = "bus2school";
  static String _password = "bus2school";
  static String _basicAuth =
      'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
  static Map<String, String> _headers = {
    HttpHeaders.authorizationHeader: _basicAuth,
    HttpHeaders.contentTypeHeader: "application/json"
  };
  static Map<String, dynamic> _body;

  static String _formatRequestOsmAnd(
      {String url, Positions position, String alarm}) {
    _body = position.toJsonOsmAnd();
    if (alarm != null) _body["alarm"] = alarm;
    var uri = Uri.http(_urlOsmAnd, "", _body);
    return uri.toString();
  }

  static String _convertSerialize(Map<String, dynamic> obj) {
    var str = "";
    obj.forEach((key, value) {
      if (str != "") {
        str += "&";
      }
      if (value is List) {
        value.asMap().forEach((index, element) {
          if (element is String)
            element = "'$element'";
          else if (element is List) {
            element.asMap().forEach((indexChild, elementChild) {
              if (elementChild is String) elementChild = "'$elementChild'";
              element[indexChild] = elementChild;
            });
          }
          value[index] = element;
        });
      }
      str += key + "=" + Uri.encodeComponent(value.toString());
    });
    return str;
  }

  static Future<dynamic> _updatePosition(Positions position) async {
    String url = _formatRequestOsmAnd(position: position);
    return http.post(url, headers: _headers).then((http.Response response) {
      return true;
    }).catchError((error) {
      return null;
    });
  }

  static Future<bool> _createDevice(Device device) async {
    _body = new Map();
    _body = device.toJson();
    return http
        .post("$_url/devices", body: jsonEncode(_body), headers: _headers)
        .then((http.Response response) {
      return true;
    }).catchError((error) {
      return false;
    });
  }

  static initDeviceTracCar() async {
    Device device = Device();
    Driver driver = Driver();
    device.uniqueId = driver.vehicleName;
    device.name = driver.vehicleNameTracCar;
    await _createDevice(device);
  }

  static updateDeviceTracCar(Position position, [String sessionId = ""]) async {
    Positions positions = Positions();
    Driver driver = Driver();
    positions.deviceId = driver.vehicleName;
    positions.latitude = position.latitude;
    positions.longitude = position.longitude;
    positions.speed = position.speed;
    positions.sessionId = sessionId;
    await _updatePosition(positions);
  }

  static Future<Device> getDeviceByUniqueId(String uniqueId) async {
    _body = new Map();
    _body["uniqueId"] = uniqueId;
    var device = Device();
    return http
        .get("$_url/devices?${_convertSerialize(_body)}", headers: _headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          List<Device> listDevice =
              list.map((item) => Device.fromJson(item)).toList();
          device = listDevice[0];
        }
      }
      return device;
    }).catchError((error) {
      return device;
    });
  }

  ///Hàm lấy danh sách vị trí của xe theo sessionId
  ///@params
  ///
  ///String date format (yyyy-mm-dd)
  static Future<List<Positions>> getPositions(
      {String sessionId, String uniqueId, String date}) async {
    List<Positions> listResult = new List();
    var device = await getDeviceByUniqueId(uniqueId);
    var fromDate = DateTime.parse("$date 00:00:00").toIso8601String();
    var toDate = DateTime.parse("$date 23:59:59").toIso8601String();
    if (device.id == null) return listResult;
    _body = new Map();
    _body["deviceId"] = device.id;
    _body["from"] = fromDate.substring(0, fromDate.length) + "Z";
    _body["to"] = toDate.substring(0, toDate.length) + "Z";

    return http
        .get("$_url/positions?${_convertSerialize(_body)}", headers: _headers)
        .then((http.Response response) {
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        if (list.length > 0) {
          listResult = list.map((item) => Positions.fromJson(item)).toList();
          listResult = listResult
              .where(
                  (positions) => positions.attributes["sessionId"] == sessionId)
              .toList();
        }
      }
      return listResult;
    }).catchError((error) {
      return listResult;
    });
  }
}
