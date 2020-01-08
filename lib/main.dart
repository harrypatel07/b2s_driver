import 'package:b2s_driver/src/app/app.dart';
import 'package:b2s_driver/src/app/app_localizations.dart';
import 'package:b2s_driver/src/app/app_route.dart';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/service/onesingal-service.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignalService.setup(oneSignal_myAppId,
      successCallBack: handlerPushNotification.init);
  await translation.init('vi');
  await Routes.navigateDefaultPage();
  runApp(MyApp());
}
