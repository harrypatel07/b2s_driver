import 'package:b2s_driver/src/app/pages/popupChat/contentPopupChat/content_popup_chat_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/baseViewModel.dart';
import '../../../models/message.dart';
import '../../../theme/theme_primary.dart';
import '../../../widgets/chat_bubble.dart';
import '../popupChat_viewmodel.dart';

class ContentPopupChatPage extends StatefulWidget {
  static const String routeName = "/contentPopupChat";
  final ContentPopupChatArgs arguments;
  ContentPopupChatPage(this.arguments);

  @override
  _ContentPopupChatPageState createState() => _ContentPopupChatPageState();
}

class ContentPopupChatArgs {
  final List<ModelChatPopup> listChat;
  final ModelChatPopup modelChatPopup;
  ContentPopupChatArgs({this.listChat, this.modelChatPopup});
}

class _ContentPopupChatPageState extends State<ContentPopupChatPage>
    with SingleTickerProviderStateMixin {
  ContentPopupChatViewModel viewModel = ContentPopupChatViewModel();

  @override
  void initState() {
    viewModel.modelChatPopup = widget.arguments.modelChatPopup;
    viewModel.initListChat(widget.arguments.listChat);
    viewModel.listenDataListMessage(widget.arguments.modelChatPopup);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _messageList() {
      return viewModel.modelChatPopup.chatting.listMessage.length > 0
          ? ListView.builder(
              controller: viewModel.listScrollController,
              padding: EdgeInsets.only(bottom: 60),
              scrollDirection: Axis.vertical,
              itemCount: viewModel.modelChatPopup.chatting.listMessage.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                var chat = viewModel.modelChatPopup.chatting.listMessage[index];
                // return __buildItem(index, viewModel.chat.listMessage[index]);
                return ChatBubble(
                  message: MessageBubble(
                      timestamp: chat.timestamp,
                      avatarUrl: viewModel.modelChatPopup.chatting.avatarUrl,
                      body: chat.content,
                      fromMe: chat.receiverId ==
                              viewModel.modelChatPopup.chatting.peerId
                          ? true
                          : false),
                );
              },
            )
          : Container();
    }

    Widget _textInput() => Material(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            height: 47.0,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: viewModel.textMessageController,
              onSubmitted: (_) {
                viewModel.onSendMessage();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
    Widget _inputBox() => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Material(
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  _textInput(),
                  IconButton(
                    onPressed: () {
                      viewModel.onSendMessage();
                      //hide keyboard
//                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    icon: Icon(
                      Icons.send,
                      color: viewModel.textMessageController.text.length == 0
                          ? Colors.grey
                          : ThemePrimary.primaryColor,
                    ),
                    iconSize: 32.0,
                  ),
                ],
              ),
            ),
          ),
        );
    Widget _circleAvatar(ModelChatPopup modelChatPopup) {
      return (modelChatPopup.chatting.avatarUrl != null)
          ? Container(
              color: Colors.transparent,
              width: 70,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            viewModel.onTapCircleAvatar(modelChatPopup);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  modelChatPopup.chatting.avatarUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 32.5,
                                        backgroundImage: imageProvider,
                                        backgroundColor: Colors.white,
                                      ),
                                ),
                                    ),
                              if (modelChatPopup.countMessage > 0 &&
                                  viewModel.modelChatPopup.chatting.peerId !=
                                      modelChatPopup.chatting.peerId)
                                Positioned(
                                  top: 5,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: Text(
                                      modelChatPopup.countMessage.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 15,
                          child: (modelChatPopup.chatting.peerId ==
                                  viewModel.modelChatPopup.chatting.peerId)
                              ? Icon(
                                  Icons.arrow_drop_up,
                                  size: 45,
                                  color: ThemePrimary.primaryColor,
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Container(
              color: Colors.transparent,
            );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              viewModel.onTapBack();
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                top: true,
                left: false,
                right: false,
                bottom: false,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black54,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  viewModel.onTapBack();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            ...viewModel.listChat
                                .map((chatting) => _circleAvatar(chatting)),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: ThemePrimary.primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x20000000),
                                            blurRadius: 5,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 45,
                                          height: 45,
                                          child: InkWell(
                                            onTap: () {
                                              viewModel.onTapProfileMessageUser(
                                                  int.parse(viewModel
                                                      .modelChatPopup
                                                      .chatting
                                                      .peerId));
                                            },
                                            child: Hero(
                                              tag: viewModel.modelChatPopup
                                                  .chatting.peerId
                                                  .toString(),
                                              child: CachedNetworkImage(
                                                imageUrl: viewModel
                                                    .modelChatPopup
                                                    .chatting
                                                    .avatarUrl,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  radius: 22.5,
                                                  backgroundImage:
                                                      imageProvider,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              flex: 2,
                                              child: Text(
                                                viewModel.modelChatPopup
                                                    .chatting.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
//                                            Flexible(
//                                              flex: 1,
//                                              child: Text('active now'),
//                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    color: Colors.white,
                                    child: _messageList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _inputBox()
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
