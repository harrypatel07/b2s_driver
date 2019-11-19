import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/locateBus/locateBus_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/user/user_page_viewmodel.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class TabsPageViewModel extends ViewModelBase {
  int currentTabIndex = 0;

  LocateBusPageViewModel locateBusPageViewModel;
  HomePageViewModel homePageViewModel;
  UserPageViewModel userPageViewModel;
  TabsPageViewModel() {
    // locateBusPageViewModel = LocateBusPageViewModel();
    // homePageViewModel = HomePageViewModel();
    // cloudService.busSession.syncColectionDriverBusSession();
  }
  onTapped(int index) {
    currentTabIndex = index;
    // if (currentTabIndex == 2) //LocateBus
    // {
    //   Future.delayed(const Duration(milliseconds: 300), () {
    //     locateBusPageViewModel.showGoolgeMap = true;
    //     locateBusPageViewModel.updateState();
    //   });
    // }
    this.updateState();
  }

  GlobalKey<FancyBottomNavigationState> fancyKey =
      GlobalKey<FancyBottomNavigationState>();

  GlobalKey<ScaffoldState> scaffoldTabbar = GlobalKey<ScaffoldState>();
  //Xử lý khi slide menu tap item
  onSlideMenuTapped(int index) {
    currentTabIndex = index;
    fancyKey.currentState.setPage(index);
  }
}
