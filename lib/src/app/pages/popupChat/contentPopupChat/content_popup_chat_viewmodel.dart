import 'dart:async';
import 'package:b2s_driver/src/app/models/profileMessageUser.dart';
import 'package:b2s_driver/src/app/pages/message/profileMessageUser/profile_message_user_page.dart';
import 'package:b2s_driver/src/app/pages/popupChat/contentPopupChat/content_popup_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_setting.dart';
import '../../../core/baseViewModel.dart';
import '../../../models/message.dart';
import '../../../models/parent.dart';
import '../popupChat_viewmodel.dart';

class ContentPopupChatViewModel extends ViewModelBase {
  List<ModelChatPopup> listChat = List();
  TextEditingController _textMessageController = new TextEditingController();
  get textMessageController => _textMessageController;
  ScrollController listScrollController = new ScrollController();
  StreamSubscription streamCloud;
  StreamSubscription streamCloudMessageData;
  ModelChatPopup modelChatPopup;
  ContentPopupChatViewModel() {
    listenData();
    _textMessageController.addListener(
        () => {if (_textMessageController.text.length < 2) this.updateState()});
  }
  initListChat(List<ModelChatPopup> listChat) {
    this.listChat = listChat;
  }
  @override
  void dispose() {
    if (streamCloud != null) streamCloud.cancel();
    if (streamCloudMessageData != null) streamCloudMessageData.cancel();
    _textMessageController.dispose();
    listScrollController.dispose();
    super.dispose();
  }

  onSendMessage() async {
    if (_textMessageController.text.trim() != '') {
      var _content = _textMessageController.text.trim();
      textMessageController.clear();
      await cloudService.chat.sendMessage(
          strId: Parent().id.toString(),
          strPeerId: modelChatPopup.chatting.peerId.toString(),
          content: _content);
      this.updateState();
    }
  }

  Future listenDataListMessage(ModelChatPopup modelChatPopup) async {
    if (streamCloudMessageData != null) streamCloudMessageData.cancel();
    final _snap = await cloudService.chat.listenListMessageByIdAndPeerId(
        Parent().id.toString(), modelChatPopup.chatting.peerId.toString());
    streamCloudMessageData = _snap.listen((onData) {
      if (onData.documents.length > 0) {
        modelChatPopup.chatting.listMessage = onData.documents
            .map((item) => Messages.fromDocumentSnapShot(item))
            .toList();
      }
      this.updateState();
    });
  }

  Future listenData() async {
    if (streamCloud != null) streamCloud.cancel();
    var _snap = handlerPushNotification.streamController.stream;
    streamCloud = _snap.listen((onData) {
      if (onData != null) {
        ModelChatPopup _chat = ModelChatPopup(onData, 1);
        if (listChat
                .where((chat) => chat.chatting.peerId == _chat.chatting.peerId)
                .toList()
                .length >
            0) {
          ModelChatPopup _itemOfListChat = listChat.firstWhere((chat) =>
              chat.chatting.peerId.toString() ==
              _chat.chatting.peerId.toString());
          _itemOfListChat.chatting.message = _chat.chatting.message;
          if (_itemOfListChat.chatting.peerId ==
              this.modelChatPopup.chatting.peerId)
            _itemOfListChat.countMessage = 0;
          else
            _itemOfListChat.countMessage++;
        } else {
          listChat.insert(0, _chat);
          if (listChat.length > 5) {
            if (this.modelChatPopup.chatting.peerId !=
                listChat.last.chatting.peerId)
              listChat.removeLast();
            else
              listChat.removeAt(listChat.indexOf(this.modelChatPopup) - 1);
          }
        }
        this.updateState();
      }
    });
  }

  onTapCircleAvatar(ModelChatPopup modelChatPopup) {
    if (this.modelChatPopup.chatting.peerId == modelChatPopup.chatting.peerId) {
      onTapBack();
    } else {
      this.modelChatPopup = modelChatPopup;
      this.modelChatPopup.countMessage = 0;
      if (streamCloudMessageData != null) streamCloudMessageData.cancel();
      listenDataListMessage(modelChatPopup);
      this.updateState();
    }
  }

  onTapBack() {
    this.modelChatPopup.countMessage = 0;
    streamCloud.cancel();
    streamCloudMessageData.cancel();
    Get.back(
        result: ContentPopupChatArgs(
            listChat: listChat, modelChatPopup: modelChatPopup));
  }

  onTapProfileMessageUser(int peerId) {
    ProfileMessageUserModel userModel;
    api.getCustomerInfo(peerId.toString()).then((data) {
      userModel = ProfileMessageUserModel(
        name: data.name.toString(),
        address: (data.street is bool || data.street == null)
            ? ''
            : data.street.toString(),
        avatarUrl: data.image,
        email: (data.email is bool || data.email == null)
            ? ''
            : data.email.toString(),
        peerId: peerId,
        phone: (data.phone is bool || data.phone == null)
            ? ''
            : data.phone.toString(),
      );
      Get.to(ProfileMessageUserPage(
        userModel: userModel,
      ));
    });
  }
}
