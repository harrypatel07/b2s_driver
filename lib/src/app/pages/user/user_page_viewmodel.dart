import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/user/edit_profile_driver/edit_profile_driver.dart';
import 'package:flutter/material.dart';

class UserPageViewModel extends ViewModelBase {
  Driver driver = Driver();
  UserPageViewModel() {}
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
}
