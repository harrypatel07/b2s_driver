import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/models-traccar/devices.dart';
import 'package:b2s_driver/src/app/models/models-traccar/position.dart';
import 'package:b2s_driver/src/app/pages/attendant/attendant_page.dart';
import 'package:b2s_driver/src/app/pages/historyTrip/historyTrip_page.dart';
import 'package:b2s_driver/src/app/pages/login/login_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/user/edit_profile_driver/edit_profile_driver.dart';
import 'package:b2s_driver/src/app/service/traccar-service.dart';
import 'package:b2s_driver/src/app/widgets/popupConfirm.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserPageViewModel extends ViewModelBase {
  Driver driver = Driver();
  UserPageViewModel();
  onTapMessage() {
    Navigator.pushNamed(context, MessagePage.routeName);
  }

  onTapDriver() {
    print('HIEP');
    Navigator.pushNamed(context, EditProfileDriver.routeName, arguments: driver)
        .then((_) {
      this.updateState();
    });
  }

  onTapLogout() {
    popupConfirm(
        context: context,
        title: 'THÔNG BÁO',
        desc: 'Xác nhận đăng xuất ?',
        yes: 'Có',
        no: 'Không',
        onTap: () {
          Navigator.pop(context);
          driver.clearLocal();
          DriverBusSession driverBusSession = DriverBusSession();
          driverBusSession.clearLocal();
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
          // Location().getLocation().then((onValue) {
          //   Positions positions = Positions();
          //   positions.deviceId = "52S-12345";
          //   positions.latitude = onValue.latitude;
          //   positions.longitude = onValue.longitude;
          //   TracCarService.updatePosition(positions);
          // });
          // Device device = Device();
          // device.uniqueId = "11011";
          // device.name = "Xe merc 40 chỗ";
          // TracCarService.createDevice(device);
        });
  }

  onTapHistoryTrip() {
    Navigator.pushNamed(context, HistoryTripPage.routeName);
  }
}
