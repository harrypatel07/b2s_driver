import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/profileMessageUser.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/sanitizers.dart';

class ProfileMessageUserPage extends StatefulWidget {
  static const String routeName = "/profileMessageUser";
  final ProfileMessageUserModel userModel;
  const ProfileMessageUserPage({Key key, this.userModel}) : super(key: key);
  @override
  _ProfileMessageUserPageState createState() => _ProfileMessageUserPageState();
}

class _ProfileMessageUserPageState extends State<ProfileMessageUserPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    Widget backButton() {
      return Positioned(
        top: 0,
        left: 0,
        child: SafeArea(
          bottom: false,
          top: true,
          child: TS24Button(
            onTap: () {
              Navigator.of(context).pop();
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25)),
              color: Colors.black38,
            ),
            width: 70,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
//    final cancelBtn = Positioned(
//      top: 50.0,
//      left: 20.0,
//      child: Container(
//        height: 35.0,
//        width: 35.0,
//        decoration: BoxDecoration(
//          shape: BoxShape.circle,
//          color: Colors.grey.withOpacity(0.5),
//        ),
//        child: IconButton(
//          icon: Icon(LineIcons.close, color: Colors.white),
//          onPressed: () => Navigator.pop(context),
//          iconSize: 20.0,
//        ),
//      ),
//    );
    final userImage = Stack(
      children: <Widget>[
        Hero(
            tag: widget.userModel.peerId.toString(),
            child: Container(
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: widget.userModel.avatarUrl,
                  imageBuilder: (context, imageProvider) => Image(
                    fit: BoxFit.cover,
                    width: deviceWidth,
                    image: imageProvider,
                  ),
                )
                // Image(
                //   fit: BoxFit.cover,
                //   width: deviceWidth,
                //   image: MemoryImage(widget.userModel.avatarUrl),
                // ),
                )),
        backButton(),
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
                  widget.userModel.name,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ));
    final hr = Container(
      height: 1,
      color: Colors.grey.shade300,
    );
//    final userLocation = Container(
//      padding: EdgeInsets.only(left: 20.0, right: 20.0),
//      child: Text(
//        widget.userModel.address,
//        style: TextStyle(
//          fontSize: 18.0,
//          fontWeight: FontWeight.bold,
//          color: Colors.grey.withOpacity(0.8),
//        ),
//      ),
//    );
    Widget rowTitle(String title) {
      return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 15.0, right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: Colors.amber,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
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
                    flex: (phoneNumber != null && !(phoneNumber is bool))
                        ? 10
                        : 14,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        toBoolean(phoneNumber) != false ? content : '',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (phoneNumber != null && !(phoneNumber is bool))
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
                  if (phoneNumber != null && !(phoneNumber is bool))
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

    childrenInfo(ProfileMessageUserModel userModel) {
      onTapChatUser() {
        Chatting chatting = Chatting(
            peerId: userModel.peerId.toString(),
            name: userModel.name,
            message: 'Hi',
            listMessage: new List(),
            avatarUrl: userModel.avatarUrl,
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
                  rowTitle('THÔNG TIN NGƯỜI DÙNG'),
                  row1('Họ và tên :', userModel.name),
                  hr,
                  row1(
                      'Địa chỉ :',
                      (userModel.address is bool || userModel.address == null)
                          ? ''
                          : userModel.address.toString()),
                  hr,
                  rowIcon(
                      'Số điện thoại :',
                      (userModel.phone is bool || userModel.phone == null)
                          ? ''
                          : userModel.phone.toString(),
                      userModel.phone,
                      () => onTapChatUser()),
                  hr,
                  row1(
                      'Email :',
                      (userModel.email is bool || userModel.email == null)
                          ? ''
                          : userModel.email.toString()),
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userImage,
            userName,
            SizedBox(height: 15,),
//            userLocation,
            childrenInfo(widget.userModel),
          ],
        ),
      ),
    );
  }
}
