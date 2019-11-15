import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/pages/home/popup_card_timeline/popup_card_timeline.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';

class PopupCardTimeLineViewModel extends ViewModelBase {
  HomePageCardTimeLine homePageCardTimeLine;
  StatusBus status;
  Offset position;
  PopupCardTimeLineViewModel(ProfileChildrenDetailArgs arguments) {
    homePageCardTimeLine = arguments.homePageCardTimeLine;
    status = arguments.homePageCardTimeLine.status;
    position = arguments.offset;
  }
  onTapPicked() {
    if (homePageCardTimeLine.typePickDrop == 0 && status.statusID != 0) return;
    if (homePageCardTimeLine.typePickDrop == 1 && status.statusID != 1) return;
    if (status.statusID == 0)
      status = StatusBus.list[1];
    else if (status.statusID == 1) {
      if (homePageCardTimeLine.typePickDrop == 0)
        status = StatusBus.list[2];
      else
        status = StatusBus.list[4];
    }

//    switch (status.statusID) {
//      case 0:
//        //status.statusID = 1;
//        status = StatusBus.list[1];
//        break;
//      case 1:
//        //status.statusID = 0;
//        status = StatusBus.list[0];
//        break;
//      default:
//    }
    this.updateState();
  }

  onTapChangeStatus(int statusID) {
    status = StatusBus.list[statusID];
    this.updateState();
  }
}
