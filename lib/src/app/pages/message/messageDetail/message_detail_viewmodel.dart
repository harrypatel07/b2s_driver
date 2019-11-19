import 'dart:async';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/models/message.dart';
import 'package:flutter/material.dart';

class MessageDetailViewModel extends ViewModelBase {
  TextEditingController _textMessageController = new TextEditingController();
  get textMessageController => _textMessageController;
  ScrollController listScrollController = new ScrollController();
  Driver driver = Driver();
  Chatting chat;
  MessageDetailViewModel() {
    _textMessageController.addListener(() {
      this.updateState();
    });
  }
  StreamSubscription streamCloud;
  @override
  void dispose() {
    _textMessageController.dispose();
    if (streamCloud != null) streamCloud.cancel();
    super.dispose();
  }

  Future listenData() async {
    if (streamCloud != null) streamCloud.cancel();
    final _snap = await cloudService.chat.listenListMessageByIdAndPeerId(
        driver.id.toString(), chat.peerId.toString());
    streamCloud = _snap.listen((onData) {
      if (onData.documents.length > 0) {
        chat.listMessage = onData.documents
            .map((item) => Messages.fromDocumentSnapShot(item))
            .toList();
      }
      loading = false;
      this.updateState();
    });
  }

  onSendMessage() async {
    if (_textMessageController.text.trim() != '') {
      var _content = _textMessageController.text.trim();
      textMessageController.clear();
      await cloudService.chat.sendMessage(
          strId: driver.id.toString(),
          strPeerId: chat.peerId.toString(),
          content: _content);
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    //  else
    //   Fluttertoast.showToast(msg: 'Nothing to send');
  }
}
