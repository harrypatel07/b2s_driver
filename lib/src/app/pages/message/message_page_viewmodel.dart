import 'dart:async';
import 'package:b2s_driver/packages/loader_search_bar/src/SearchBarController.dart';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/profileMessageUser.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/pages/message/profileMessageUser/profile_message_user_page.dart';
import 'package:flutter/material.dart';

class MessagePageViewModel extends ViewModelBase {
  List<ProfileMessageUserModel> listProfileMessageUser = List();
  SearchBarController searchBarController;
  StreamSubscription streamCloud;
  List<Chatting> listChat = List();
  bool loadingDataMessage = true;
  bool loadingDataContacts = true;
  Driver driver = Driver();
  @override
  void dispose() {
    streamCloud.cancel();
    super.dispose();
  }

  MessagePageViewModel() {
    loadingDataMessage = true;
    loadingDataContacts = true;
    searchBarController = new SearchBarController();
  }
  Future listenData() async {
    int checkDone = 0;
    if (streamCloud != null) streamCloud.cancel();
    var _snap =
        await cloudService.chat.listenListMessageByUserId(driver.id.toString());
    streamCloud = _snap.listen((onData) {
      if (onData.documents.length > 0) {
        onData.documents.sort((a, b) {
          var timeStampA = double.parse(a.data["timestamp"].toString());
          var timeStampB = double.parse(b.data["timestamp"].toString());
          if (timeStampA > timeStampB) return 0;
          return 1;
        });

        listChat = onData.documents
            .map((item) =>
                Chatting.fromDocumentSnapShot(item, driver.id.toString()))
            .toList();
        listChat.removeWhere((item) => int.parse(item.peerId) == driver.id);
        //get image listChat
        listChat.forEach((item) {
          api.getCustomerInfo(item.peerId).then((onValue) {
            item.name = onValue.displayName;
            item.avatarUrl = onValue.image;
            listProfileMessageUser
                .add(ProfileMessageUserModel.fromDocumentSnapShot(onValue));
            if (checkDone++ == listChat.length - 1) {
              loadingDataMessage = false;
              this.updateState();
            }
          });
        });
      } else {
        loadingDataMessage = false;
        this.updateState();
      }
    });
  }

  onItemClick(Chatting chatting) {
    Navigator.pushNamed(
      context,
      MessageDetailPage.routeName,
      arguments: chatting,
    );
  }

  onTapProfileMessageUser(int peerId) {
    listProfileMessageUser.forEach((userModel) {
      if (userModel.peerId == peerId)
        Navigator.pushNamed(context, ProfileMessageUserPage.routeName,
            arguments: userModel);
    });
  }
}
