import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/sanitizers.dart';

class ProfileChildrenPage extends StatefulWidget {
  static const String routeName = "/profileChildren";
  final ProfileChildrenArgs args;
  const ProfileChildrenPage({Key key, this.args}) : super(key: key);
  @override
  _ProfileChildrenPageState createState() => _ProfileChildrenPageState();
}

class ProfileChildrenArgs {
  final Children children;
  final String heroTag;
  ProfileChildrenArgs({this.children, this.heroTag});
}

class _ProfileChildrenPageState extends State<ProfileChildrenPage> {
  Children children;
  String heroTag;
  @override
  void initState() {
    children = widget.args.children;
    heroTag = widget.args.heroTag;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final cancelBtn = Positioned(
      top: 50.0,
      left: 20.0,
      child: Container(
        height: 35.0,
        width: 35.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.5),
        ),
        child: IconButton(
          icon: Icon(LineIcons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          iconSize: 20.0,
        ),
      ),
    );
//    final qrCode = Positioned(
//      bottom: 0,
//      left: deviceWidth/2-80,
//      child: QrImage(
//        backgroundColor: Colors.white,
//        data: widget.children.photo,
//        version: QrVersions.auto,
//        size: 160.0,
//      ),
//    );
    final userImage = Stack(
      children: <Widget>[
        Hero(
            tag: heroTag,
            child: Container(
              height: 250,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl: children.photo,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 250.0,
                        width: deviceWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        cancelBtn,
//        qrCode
      ],
    );

    final userName = Container(
        width: deviceWidth,
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 9,
              child: Container(
                child: Text(
                  children.name,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                height: 30.0,
//                width: 100.0,
                decoration: BoxDecoration(
                    color: ThemePrimary.primaryColor,
                    //gradient: ThemePrimary.chatBubbleGradient,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    children.gender.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
    final hr = Container(
      height: 1,
      color: Colors.grey.shade300,
    );
    final userLocation = Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        children.location,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.withOpacity(0.8),
        ),
      ),
    );
    Widget rowTitle(String title) {
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: ThemePrimary.primaryColor,
        ),
        height: 40,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget row2(String title1, String content1, String title2, String content2,
        bool type) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 3, right: 3, bottom: 3),
                        child: Icon(
                          type ? Icons.home : Icons.school,
                          color: type ? Colors.orange : Colors.green,
                          size: 20,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title1,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content1,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 3, right: 3, bottom: 3),
                        child: Icon(
                          type ? Icons.school : Icons.home,
                          color: type ? Colors.green : Colors.orange,
                          size: 20,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title2,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      content2,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget row1(String title, String content) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget rowIcon(
        String title, String content, String phoneNumber, Function onTap) {
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex:
                        (phoneNumber != null && toBoolean(phoneNumber) != false)
                            ? 10
                            : 14,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        content,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (phoneNumber != null && toBoolean(phoneNumber) != false)
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          launch("tel://$phoneNumber");
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
//color: Colors.amber,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.call,
                              color: ThemePrimary.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (phoneNumber != null && toBoolean(phoneNumber) != false)
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          launch("sms://$phoneNumber");
                        },
                        child: Container(
// color: Colors.red,
                          margin: EdgeInsets.only(left: 2),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.message,
                              color: ThemePrimary.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
// color: Colors.red,
                        margin: EdgeInsets.only(left: 4),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            FontAwesomeIcons.facebookMessenger,
                            color: ThemePrimary.primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget childrenInfo() {
      onTapChatParent() {
        Chatting chatting = Chatting(
            peerId: children.parent.id.toString(),
            name: children.parent.name.toString(),
            message: 'Hi',
            listMessage: new List(),
            avatarUrl: children.parent.photo,
            datetime: DateTime.now().toIso8601String());
        Navigator.pushNamed(
          context,
          MessageDetailPage.routeName,
          arguments: chatting,
        );
      }

      return Padding(
        padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(12.0),
          shadowColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(0.0),
            width: deviceWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            constraints: BoxConstraints(minHeight: 100.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  rowTitle('THÔNG TIN HỌC SINH'),
                  row1('Họ và tên :', children.name.toString()),
                  hr,
                  row1('Lớp :', children.classes.toString()),
                  hr,
                  row1('Trường :', children.schoolName.toString()),
                  hr,
                  row1('Địa chỉ :', children.location.toString()),
                  hr,
                  rowIcon('Phụ huynh :', children.parent.name.toString(),
                      children.parent.phone.toString(), () {
                    onTapChatParent();
                  }),
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(bottom: 10),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

//    final busInfo = Padding(
//      padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
//      child: Material(
//        elevation: 5.0,
//        borderRadius: BorderRadius.circular(12.0),
//        shadowColor: Colors.white,
//        child: Container(
//          padding: EdgeInsets.all(0.0),
//          width: deviceWidth,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(12.0),
//            color: Colors.white,
//          ),
//          constraints: BoxConstraints(minHeight: 100.0),
//          child: Container(
//            child: Column(
//              children: <Widget>[
//                rowTitle('THÔNG TIN XE BUS'),
//                row1('Biển số xe :', busSession.sessionID),
//                hr,
//                rowIcon('Tài xế :',busSession.driver.name, busSession.driver.phone),
//                hr,
//                rowIcon('QL đưa đón :','Dương Tuyết Mai', '0983932940'),
//                hr,
//                rowIcon('QL tại trường :','Âu Dương Phong', '0983932940'),
//                hr,
//                row2('Giờ đón :','7h30','Đến trường :','8h',true),
//                hr,
//                row2('Giờ về :','17h30','Về nhà :','18h',false),
//                Container(height: 1, margin: EdgeInsets.only(bottom: 10),)
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userImage,
            userName,
            userLocation,
            childrenInfo(),
            //busInfo
          ],
        ),
      ),
    );
  }
}
