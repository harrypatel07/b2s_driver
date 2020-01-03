import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/models/message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final MessageBubble message;

  const ChatBubble({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final messageBody = message.body;
    final fromMe = message.fromMe;
    final timeStamp = message.timestamp;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp));
    DateTime now = DateTime.now();
    String dateShow = (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year)
        ? DateFormat('hh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp)))
        : DateFormat('dd/MM/yyyy \nhh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.timestamp)));
//    var date = DateFormat('dd MMM')
//        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp)));
//    final dateNow = DateFormat('dd MMM').format(DateTime.now());
//    if (date == dateNow) date = "";
//    final time = DateFormat('kk:mm')
//        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp)));
    Widget _content() => Container(
          padding: EdgeInsets.all(15.0),
          margin: fromMe
              ? EdgeInsets.only(
                  right: 20.0,
                  bottom: 20.0,
                )
              : EdgeInsets.only(
                  left: 20.0,
                  bottom: 20.0,
                ),
          decoration: BoxDecoration(
            gradient: fromMe
                ? ThemePrimary.chatBubbleGradient
                : ThemePrimary.chatBubbleGradient2,
            borderRadius: fromMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    topLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
          ),
          constraints: BoxConstraints(
            minHeight: 20.0,
            minWidth: 30.0,
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                messageBody,
                style: TextStyle(
                  // color: fromMe ? Colors.white70 : Colors.black,
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                child: Text(
                  '$dateShow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                    // fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        );
    return Align(
      alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: fromMe
          ? _content()
          : Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: message.avatarUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.only(left: 8.0, bottom: 10.0),
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
                _content(),
              ],
            ),
    );
  }

  // Widget __buildItem(int index, Messages message) {
  //     bool isLastMessageLeft(int index) {
  //       if ((index > 0 &&
  //               viewModel.chat.listMessage != null &&
  //               viewModel.chat.listMessage[index - 1].senderId !=
  //                   viewModel.chat.peerId) ||
  //           index == 0) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     }

  //     bool isLastMessageRight(int index) {
  //       if ((index > 0 &&
  //               viewModel.chat.listMessage != null &&
  //               viewModel.chat.listMessage[index - 1].senderId ==
  //                   viewModel.chat.peerId) ||
  //           index == 0) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     }

  //     if (message.senderId != viewModel.chat.peerId) {
  //       // Right (my message)
  //       return Row(
  //         children: <Widget>[
  //           message.type == 0
  //               // Text
  //               ? Container(
  //                   child: Text(
  //                     message.content,
  //                     style: TextStyle(color: ThemePrimary.primaryColor),
  //                   ),
  //                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
  //                   width: 200.0,
  //                   decoration: BoxDecoration(
  //                       color: Colors.grey,
  //                       borderRadius: BorderRadius.circular(8.0)),
  //                   margin: EdgeInsets.only(
  //                       bottom: isLastMessageRight(index) ? 20.0 : 10.0,
  //                       right: 10.0),
  //                 )
  //               : Container()
  //           // : message.type == 1
  //           //     // Image
  //           //     ? Container(
  //           //         child: FlatButton(
  //           //           child: Material(
  //           //             child: CachedNetworkImage(
  //           //               placeholder: (context, url) => Container(
  //           //                 child: CircularProgressIndicator(
  //           //                   valueColor:
  //           //                       AlwaysStoppedAnimation<Color>(ThemePrimary.primaryColor),
  //           //                 ),
  //           //                 width: 200.0,
  //           //                 height: 200.0,
  //           //                 padding: EdgeInsets.all(70.0),
  //           //                 decoration: BoxDecoration(
  //           //                   color: Colors.grey,
  //           //                   borderRadius: BorderRadius.all(
  //           //                     Radius.circular(8.0),
  //           //                   ),
  //           //                 ),
  //           //               ),
  //           //               errorWidget: (context, url, error) => Material(
  //           //                 child: Image.asset(
  //           //                   'images/img_not_available.jpeg',
  //           //                   width: 200.0,
  //           //                   height: 200.0,
  //           //                   fit: BoxFit.cover,
  //           //                 ),
  //           //                 borderRadius: BorderRadius.all(
  //           //                   Radius.circular(8.0),
  //           //                 ),
  //           //                 clipBehavior: Clip.hardEdge,
  //           //               ),
  //           //               imageUrl: message.content,
  //           //               width: 200.0,
  //           //               height: 200.0,
  //           //               fit: BoxFit.cover,
  //           //             ),
  //           //             borderRadius: BorderRadius.all(Radius.circular(8.0)),
  //           //             clipBehavior: Clip.hardEdge,
  //           //           ),
  //           //           onPressed: () {
  //           //             // Navigator.push(
  //           //             //     context,
  //           //             //     MaterialPageRoute(
  //           //             //         builder: (context) =>
  //           //             //             FullPhoto(url: message.content)));
  //           //           },
  //           //           padding: EdgeInsets.all(0),
  //           //         ),
  //           //         margin: EdgeInsets.only(
  //           //             bottom: isLastMessageRight(index) ? 20.0 : 10.0,
  //           //             right: 10.0),
  //           //       )
  //           //     // Sticker
  //           //     : Container(
  //           //         child: new Image.asset(
  //           //           'images/${message.content}.gif',
  //           //           width: 100.0,
  //           //           height: 100.0,
  //           //           fit: BoxFit.cover,
  //           //         ),
  //           //         margin: EdgeInsets.only(
  //           //             bottom: isLastMessageRight(index) ? 20.0 : 10.0,
  //           //             right: 10.0),
  //           //       ),
  //         ],
  //         mainAxisAlignment: MainAxisAlignment.end,
  //       );
  //     } else {
  //       // Left (peer message)
  //       return Container(
  //         child: Column(
  //           children: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 isLastMessageLeft(index)
  //                     ? Container(
  //                         margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
  //                         height: 50.0,
  //                         width: 50.0,
  //                         decoration: BoxDecoration(
  //                           image: DecorationImage(
  //                             image: MemoryImage(viewModel.chat.avatarUrl),
  //                             fit: BoxFit.cover,
  //                           ),
  //                           shape: BoxShape.circle,
  //                         ),
  //                       )
  //                     : Container(width: 35.0),
  //                 message.type == 0
  //                     ? Container(
  //                         child: Text(
  //                           message.content,
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         padding:
  //                             EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
  //                         width: 200.0,
  //                         decoration: BoxDecoration(
  //                             color: ThemePrimary.primaryColor,
  //                             borderRadius: BorderRadius.circular(8.0)),
  //                         margin: EdgeInsets.only(left: 10.0),
  //                       )
  //                     : message.type == 1
  //                         ? Container(
  //                             child: FlatButton(
  //                               child: Material(
  //                                 child: CachedNetworkImage(
  //                                   placeholder: (context, url) => Container(
  //                                     child: CircularProgressIndicator(
  //                                       valueColor:
  //                                           AlwaysStoppedAnimation<Color>(
  //                                               ThemePrimary.primaryColor),
  //                                     ),
  //                                     width: 200.0,
  //                                     height: 200.0,
  //                                     padding: EdgeInsets.all(70.0),
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.grey,
  //                                       borderRadius: BorderRadius.all(
  //                                         Radius.circular(8.0),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   errorWidget: (context, url, error) =>
  //                                       Material(
  //                                     child: Image.asset(
  //                                       'images/img_not_available.jpeg',
  //                                       width: 200.0,
  //                                       height: 200.0,
  //                                       fit: BoxFit.cover,
  //                                     ),
  //                                     borderRadius: BorderRadius.all(
  //                                       Radius.circular(8.0),
  //                                     ),
  //                                     clipBehavior: Clip.hardEdge,
  //                                   ),
  //                                   imageUrl: message.content,
  //                                   width: 200.0,
  //                                   height: 200.0,
  //                                   fit: BoxFit.cover,
  //                                 ),
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(8.0)),
  //                                 clipBehavior: Clip.hardEdge,
  //                               ),
  //                               onPressed: () {
  //                                 // Navigator.push(
  //                                 //     context,
  //                                 //     MaterialPageRoute(
  //                                 //         builder: (context) => FullPhoto(
  //                                 //             url: message.content)));
  //                               },
  //                               padding: EdgeInsets.all(0),
  //                             ),
  //                             margin: EdgeInsets.only(left: 10.0),
  //                           )
  //                         : Container(
  //                             child: new Image.asset(
  //                               'images/${message.content}.gif',
  //                               width: 100.0,
  //                               height: 100.0,
  //                               fit: BoxFit.cover,
  //                             ),
  //                             margin: EdgeInsets.only(
  //                                 bottom:
  //                                     isLastMessageRight(index) ? 20.0 : 10.0,
  //                                 right: 10.0),
  //                           ),
  //               ],
  //             ),

  //             // Time
  //             isLastMessageLeft(index)
  //                 ? Container(
  //                     child: Text(
  //                       DateFormat('dd MMM kk:mm').format(
  //                           DateTime.fromMillisecondsSinceEpoch(
  //                               int.parse(message.timestamp))),
  //                       style: TextStyle(
  //                           color: Colors.grey,
  //                           fontSize: 12.0,
  //                           fontStyle: FontStyle.italic),
  //                     ),
  //                     margin:
  //                         EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
  //                   )
  //                 : Container()
  //           ],
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //         ),
  //         margin: EdgeInsets.only(bottom: 10.0),
  //       );
  //     }
  //   }

}
