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
  static Future setup(String appId, {Function successCallBack}) async {
    print("/*---OneSignal.shared.init");
    return OneSignal.shared.init(appId, iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    }).then((_) {
      OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.none);
      if (successCallBack != null) successCallBack();
      // OneSignalService.notificationReceivedHandler((oSNotification) {
      //   print("onesignal setup");
      //   var addData = oSNotification.payload.additionalData;

      //   addData.forEach((key, value) {
      //     switch (key) {
      //       case "":
      //         break;
      //       default:
      //     }
      //   });
      // });
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
    print(tags);
    return OneSignal.shared.sendTags(tags);
  }

  static Future<bool> requestPermission() {
    return OneSignal.shared.promptUserForPushNotificationPermission();
  }

  static Future postNotification(BodyNotification body) async {
    body.appId = oneSignal_appId;
    _headers[HttpHeaders.authorizationHeader] = "Basic $oneSignal_restKey";
    return http
        .post(_urlRest, headers: _headers, body: jsonEncode(body.toJson()))
        .then((http.Response response) {
      print(response);
    }).catchError((error) {
      return null;
    });
  }

  static Future postNotificationSameApplication(BodyNotification body) async {
    body.appId = oneSignal_myAppId;
    _headers[HttpHeaders.authorizationHeader] = "Basic $oneSignal_myRestKey";
    return http
        .post(_urlRest, headers: _headers, body: jsonEncode(body.toJson()))
        .then((http.Response response) {
      print(response);
    }).catchError((error) {
      return null;
    });
  }
}
