import 'dart:convert';
import 'dart:io';

import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/models/bodyNotification.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

class OneSignalService {
  static final String _urlRest = "https://onesignal.com/api/v1/notifications";
  static Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Basic $oneSignal_restKey"
  };

  static Future setup(String appId) async {
    return OneSignal.shared.init(appId, iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
  }

  static notificationReceivedHandler(Function(OSNotification) callBack) {
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      callBack(notification);
    });
  }

  static notificationOpenedHandler(
      Function(OSNotificationOpenedResult) callBack) {
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult notification) {
      callBack(notification);
    });
  }

  static Future<Map<String, dynamic>> sendTags(
      Map<String, dynamic> tags) async {
    return OneSignal.shared.sendTags(tags);
  }

  static Future postNotification(BodyNotification body) async {
    body.appId = oneSignal_appId;
    return http
        .post(_urlRest, headers: _headers, body: jsonEncode(body.toJson()))
        .then((http.Response response) {
      print(response);
    }).catchError((error) {
      return null;
    });
  }
}
