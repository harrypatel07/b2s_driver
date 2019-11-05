import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/popup_card_timeline/popup_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';

class PopupCardTimeLineViewModel extends ViewModelBase {
  HomePageCardTimeLine homePageCardTimeLine;
  Children children;
  StatusBus status;
  Offset position;
  bool isEnablePicked;
  PopupCardTimeLineViewModel(ProfileChildrenDetailArgs arguments) {
    position = arguments.offset;
    children = arguments.homePageCardTimeLine.children;
    status = arguments.homePageCardTimeLine.status;
    isEnablePicked = arguments.homePageCardTimeLine.isEnablePicked;
  }
  onTapPicked() {
    switch (status.statusID) {
      case 0:
        //status.statusID = 1;
        status = StatusBus.list[1];
        break;
      case 1:
        //status.statusID = 0;
        status = StatusBus.list[0];
        break;
      default:
    }
    this.updateState();
  }

  onTapChangeStatus(int statusID) {
    status = StatusBus.list[statusID];
    this.updateState();
  }
}
