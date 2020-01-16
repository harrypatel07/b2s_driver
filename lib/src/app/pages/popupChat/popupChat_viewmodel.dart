import 'dart:async';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/helper/utils.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/profileMessageUser.dart';
import 'package:b2s_driver/src/app/pages/login/login_page.dart';
import 'package:b2s_driver/src/app/pages/message/ContactsPage/contacts_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/pages/message/message_page.dart';
import 'package:b2s_driver/src/app/pages/popupChat/contentPopupChat/content_popup_chat_page.dart';
import 'package:b2s_driver/src/app/service/play-sound-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_route.dart';

class PopupChatViewModel extends ViewModelBase {
  StreamSubscription streamCloud;
  StreamSubscription<String> streamSubscription;
  List<ModelChatPopup> listChat = List();
  ModelChatPopup modelChatPopupShow;
  List<ProfileMessageUserModel> listProfileMessageUser = List();
  PopupChatViewModel() {
    listenPageName();
    listenData();
  }
  Offset positionDraggable = Offset(0, 0);
  Offset positionItemShow = Offset(0, 0);
  Offset positionLocalTapDown = Offset(0, 0);
  bool showPopup = false;
  bool flowDrag = false;
  bool inTargetRemove = false;
  bool isRemoveCancel = true;
  bool showCircleRemove = false;
  bool showPopupBaseScreen = false;
  Offset positionPin(Offset offset) {
    if (offset.dx > MediaQuery.of(context).size.width * 0.5 - 37) {
      return Offset(
          MediaQuery.of(context).size.width - 65,
          (offset.dy + 130 > MediaQuery.of(context).size.height)
              ? MediaQuery.of(context).size.height - 130
              : (offset.dy < 25) ? 0 : offset.dy);
    } else
      return Offset(
          0,
          (offset.dy + 130.0 > MediaQuery.of(context).size.height)
              ? MediaQuery.of(context).size.height - 130
              : (offset.dy < 25) ? 0 : offset.dy);
  }

  @override
  void dispose() {
    if (streamCloud != null) streamCloud.cancel();
    if (streamSubscription != null) streamSubscription.cancel();
    super.dispose();
  }

  Future listenPageName() async {
    streamSubscription = handlerPushPageName.stream.listen((onData) {
      if (onData == MessagePage.routeName ||
          onData == MessageDetailPage.routeName.toString() ||
          onData == LoginPage.routeName ||
          onData == ContactsPage.routeName) {
        if (onData == LoginPage.routeName) showPopup = false;
        var posTerm = positionPin(positionItemShow);
        positionItemShow = Offset(
            (posTerm.dx == 0) ? positionItemShow.dx - 65 : posTerm.dx + 65,
            positionItemShow.dy);
        showPopupBaseScreen = false;
      } else
        showPopupBaseScreen = true;
      this.updateState();
    });
  }

  Future listenData() async {
    if (streamCloud != null) streamCloud.cancel();
    var _snap = handlerPushNotification.stream;
    streamCloud = _snap.listen((onData) {
      if (onData != null) {
        if (MyRouteObserver.routeCurrentName != MessagePage.routeName &&
            MyRouteObserver.routeCurrentName != MessageDetailPage.routeName &&
            MyRouteObserver.routeCurrentName != LoginPage.routeName &&
            MyRouteObserver.routeCurrentName != ContactsPage.routeName) {
          PlaySoundService.play("sound/sharp.mp3");
          if (!showPopup) {
            initPositionDataWhenShowPopup();
          }
        } else if (showPopup) {
          showPopup = false;
        }
        ModelChatPopup _chat = ModelChatPopup(onData, 1);
        if (listChat
                .where((chat) => chat.chatting.peerId == _chat.chatting.peerId)
                .toList()
                .length >
            0) {
          ModelChatPopup _itemOfListChat = listChat.firstWhere((chat) =>
              chat.chatting.peerId.toString() ==
              _chat.chatting.peerId.toString());
          modelChatPopupShow = _itemOfListChat;
          _itemOfListChat.chatting.message = _chat.chatting.message;
          _itemOfListChat.countMessage++;
        } else {
          modelChatPopupShow = _chat;
          listChat.insert(0, _chat);
          if (listChat.length > 5) listChat.removeLast();
        }
        this.updateState();
      }
    });
  }

  onPointerMove(PointerMoveEvent event) {
    positionDraggable = Offset(
        positionDraggable.dx +
            (event.position.dx -
                positionDraggable.dx -
                positionLocalTapDown.dx),
        positionDraggable.dy +
            (event.position.dy - positionDraggable.dy) -
            positionLocalTapDown.dy);
    inTargetRemove = getPointInCircle(
        center: Offset(MediaQuery.of(context).size.width * 0.5 - 40,
            MediaQuery.of(context).size.height - 100.0),
        positionCurrent: positionDraggable,
        r: 150.0);
    if (inTargetRemove) {
      flowDrag = false;
    } else {
      flowDrag = true;
    }
    this.updateState();
  }

  onDragStarted() {
    positionItemShow = positionDraggable;
    showCircleRemove = true;
    flowDrag = true;
    isRemoveCancel = false;
  }

  onDraggableCanceled() {
    if (inTargetRemove) {
      showPopup = false;
      showCircleRemove = false;
      this.updateState();
      return;
    }
    positionItemShow = Offset(positionDraggable.dx, positionDraggable.dy);
    positionDraggable = positionPin(positionDraggable);
    isRemoveCancel = true;
    flowDrag = false;
    showCircleRemove = false;
    this.updateState();
  }

  onPointerDown(PointerDownEvent event) {
    positionLocalTapDown = event.localPosition;
  }

  onTapFloatButton() async {
    streamCloud.cancel();
    showPopup = false;
    this.updateState();
    modelChatPopupShow.countMessage = 0;
    listChat
        .firstWhere((modelChatPopup) =>
            modelChatPopup.chatting.peerId ==
            this.modelChatPopupShow.chatting.peerId)
        .countMessage = 0;
    ContentPopupChatArgs data = await Get.to(ContentPopupChatPage(
        ContentPopupChatArgs(
            listChat: listChat, modelChatPopup: modelChatPopupShow)));
    if (data != null) {
      listChat = data.listChat;
      modelChatPopupShow = data.modelChatPopup;
      listenData();
      showPopup = true;
      this.updateState();
    }
  }

  initPositionDataWhenShowPopup() {
    showPopup = true;
    isRemoveCancel = true;
    positionItemShow = Offset(MediaQuery.of(context).size.width, 0);
    positionDraggable = Offset(MediaQuery.of(context).size.width - 65, 0);
    this.updateState();
  }
}

class ModelChatPopup {
  Chatting chatting;
  int countMessage;
  ModelChatPopup(this.chatting, this.countMessage);
}
