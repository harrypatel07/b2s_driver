import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/pages/message/messageUser/message_user_page.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_appbar_widget.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  static const String routeName = "/message";
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return new TS24Scaffold(
      appBar: new TS24AppBar(
        title: new Text("Message"),
      ),
      body: ListView.builder(
        //padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        itemCount: ChatModel.dummyData.length,
        itemBuilder: (context, index) {
          ChatModel _model = ChatModel.dummyData[index];
          return Column(
            children: <Widget>[
              Divider(
                height: 12.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MessageDetailPage.routeName,
                    arguments: _model.userId,
                  );
                },
                leading: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MessageUserPage.routeName,
                      arguments: _model.userId,
                    );
                  },
                  child: Hero(
                    tag: _model.avatarUrl,
                    child: CachedNetworkImage(
                      imageUrl: _model.avatarUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 24.0,
                        backgroundImage: imageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: <Widget>[
                    Text(_model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      _model.datetime,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                subtitle: Text(
                  _model.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14.0,
                ),
              ),
            ],
          );

          // final userImage = InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(
          //       context,
          //       MessageUserPage.routeName,
          //     );
          //   },
          //   child: Container(
          //     padding: EdgeInsets.only(top: 18),
          //     child: Stack(
          //       children: <Widget>[
          //         Hero(
          //           tag: _model.avatarUrl,
          //           child: CachedNetworkImage(
          //             imageUrl: _model.avatarUrl,
          //             imageBuilder: (context, imageProvider) => Container(
          //               margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
          //               height: 70.0,
          //               width: 70.0,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: imageProvider,
          //                   fit: BoxFit.cover,
          //                 ),
          //                 shape: BoxShape.circle,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // );

          // final userNameMessage = Container(
          //   child: Expanded(
          //     child: InkWell(
          //       onTap: () {},
          //       child: Container(
          //         padding: EdgeInsets.only(
          //           left: 10.0,
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Hero(
          //               tag: _model.name,
          //               child: Text(
          //                 _model.name,
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20.0,
          //                 ),
          //               ),
          //             ),
          //             Text(
          //               _model.message,
          //               style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 18.0,
          //                 color: Colors.grey.withOpacity(0.6),
          //               ),
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             Text(
          //               _model.datetime,
          //               style: TextStyle(fontSize: 12.0),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // );
          // final trailing = Icon(
          //   Icons.arrow_forward_ios,
          //   size: 14.0,
          //   color: Colors.black38,
          // );
          // return Column(
          //   children: <Widget>[
          //     Divider(
          //       height: 5.0,
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(bottom: 8.0),
          //       child: Row(
          //         children: <Widget>[userImage, userNameMessage, trailing],
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}
