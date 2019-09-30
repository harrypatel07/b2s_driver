import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/menu.dart';
import 'package:b2s_driver/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:flutter/material.dart';

class SideMenuPageViewModel extends ViewModelBase {
  String mainProfilePicture =
      "https://cdn1.iconfinder.com/data/icons/children-avatar-flat/128/children_avatar-01-512.png";
  String otherProfilePicture =
      "https://cdn1.iconfinder.com/data/icons/children-avatar-flat/128/children_avatar-11-256.png";

  int currentIndex = 0;
  void switchUser() {
    String backupString = mainProfilePicture;
    mainProfilePicture = otherProfilePicture;
    otherProfilePicture = backupString;
    this.updateState();
  }

  TabsPageViewModel tabsPageViewModel;

  void listContentOnTap(Menu menu) {
    currentIndex = menu.index;
    this.updateState();
    Navigator.of(context).pop();
    tabsPageViewModel = ViewModelProvider.of(context);
    if (tabsPageViewModel != null)
      tabsPageViewModel.onSlideMenuTapped(menu.index);
  }
}
