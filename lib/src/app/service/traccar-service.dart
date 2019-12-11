import 'dart:convert';
import 'dart:io';
import 'package:b2s_driver/src/app/models/models-traccar/devices.dart';
import 'package:http/http.dart' as http;
import 'package:b2s_driver/src/app/models/models-traccar/position.dart';

class TracCarService {
  static String _urlOsmAnd = "traccar.bus2school.vn";
  static String _url = "http://traccar.bus2school.vn/api";
  static String _username = "";
  static String _password = "";
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

  static Future<dynamic> updatePosition(Positions position) async {
    String url = _formatRequestOsmAnd(position: position);
    return http.post(url, headers: _headers).then((http.Response response) {
      return true;
    }).catchError((error) {
      return null;
    });
  }

  static Future<dynamic> createDevice(Device device) async {
    _body = new Map();
    _body["body"] = device.toJson();
    return http
        .post("$_url/devices?${_convertSerialize(_body)}", headers: _headers)
        .then((http.Response response) {
      return true;
    }).catchError((error) {
      return null;
    });
  }
}
