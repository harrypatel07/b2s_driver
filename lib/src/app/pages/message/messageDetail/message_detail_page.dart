
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/message.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/chat_bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessageDetailPage extends StatefulWidget {
  final Chatting chatting;

  static const String routeName = "/messageDetail";
  MessageDetailPage({Key key, this.chatting}) : super(key: key);
  @override
  _MessageDetailPageState createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends State<MessageDetailPage> {
  MessageDetailViewModel viewModel = MessageDetailViewModel();
  @override
  void initState() {
    viewModel.chat = widget.chatting;
    viewModel.listenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget userImage() => Hero(
      tag: widget.chatting.peerId.toString(),
      child:
          // Container(
          //   margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
          //   height: 50.0,
          //   width: 50.0,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: MemoryImage(viewModel.chat.avatarUrl),
          //       fit: BoxFit.cover,
          //     ),
          //     shape: BoxShape.circle,
          //   ),
          // ),
          CachedNetworkImage(
        imageUrl: viewModel.chat.avatarUrl,
        imageBuilder: (context, imageProvider) => Container(
          margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
    final userName = Text(
      viewModel.chat.name,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );

    Widget _appBar() => Material(
          elevation: 5.0,
          shadowColor: Colors.grey,
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(child: userName),
                userImage()
              ],
            ),
          ),
        );

    Widget _textInput() => Container(
          padding: EdgeInsets.only(left: 10.0),
          height: 47.0,
          width: deviceWidth * 0.8,
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
                color: Colors.grey.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );

    Widget _messageList() {
      return viewModel.chat.listMessage.length > 0
          ? ListView.builder(
              controller: viewModel.listScrollController,
              padding: EdgeInsets.only(bottom: 60),
              scrollDirection: Axis.vertical,
              itemCount: viewModel.chat.listMessage.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                var chat = viewModel.chat.listMessage[index];
                // return __buildItem(index, viewModel.chat.listMessage[index]);
                return ChatBubble(
                  message: MessageBubble(
                      timestamp: chat.timestamp,
                      avatarUrl: viewModel.chat.avatarUrl,
                      body: chat.content,
                      fromMe: chat.receiverId == viewModel.chat.peerId
                          ? true
                          : false),
                );
              },
            )
          : Container();
    }

    Widget _inputBox() => Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60.0,
            width: deviceHeight,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
//                IconButton(
//                  onPressed: () {},
//                  icon: Icon(
//                    Icons.camera_alt,
//                    color: Colors.grey,
//                  ),
//                  iconSize: 32.0,
//                ),
                SizedBox(),
                _textInput(),
                IconButton(
                  onPressed: () {
                    viewModel.onSendMessage();
                    //hide keyboard
                    FocusScope.of(context).requestFocus(new FocusNode());
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
        );

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot) {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    height: deviceHeight,
                    width: deviceWidth,
                    child: Column(
                      children: <Widget>[
                        _appBar(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Flexible(
                          child: _messageList(),
                        ),
                      ],
                    ),
                  ),
                  _inputBox()
                ],
              ),
            );
          }),
    );
  }
}
