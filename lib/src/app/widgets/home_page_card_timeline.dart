import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/picking-transport-info.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/pages/home/popup_card_timeline/popup_card_timeline.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePageCardTimeLine extends StatelessWidget {
  final Function onTapScan;
  final Function onTapPickUp;
  final Function onTapChangeStatusLeave;
  final Function onTapShowChildrenProfile;
  final String heroTag;
  final Children children;
  final StatusBus status;
  final bool isEnablePicked;
  final bool isEnableTapChildrenContentCard;
  final int typePickDrop;
  final String note;
  final int cardType;
  final bool selected;
  final Function onChangeSelect;
  final PopupCardTimeLinePage popupCardTimeLinePage;
  final bool isDriver;
  final bool isPickDrop;
  const HomePageCardTimeLine({
    Key key,
    this.onTapScan,
    this.onTapPickUp,
    this.onTapChangeStatusLeave,
    this.onTapShowChildrenProfile,
    this.heroTag,
    this.status,
    this.popupCardTimeLinePage,
    this.cardType = 0,
    this.typePickDrop = 0,
    this.note = "",
    this.selected,
    this.isDriver,
    this.isPickDrop,
    this.onChangeSelect,
    @required this.children,
    this.isEnablePicked,
    this.isEnableTapChildrenContentCard = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    Offset _position = Offset(0, 0);

    _getPosition() {
      final RenderBox renderBox = _key.currentContext.findRenderObject();
      _position = renderBox.localToGlobal(Offset.zero);
    }

    //WidgetsBinding.instance.addPostFrameCallback((_)=>_getPosition());

    Widget _status() {
      return new Container(
        //width: 200.0,
        child: Row(
          children: <Widget>[
            new Container(
              //margin: EdgeInsets.only(left: 10, right: 5),
              width: 10.0,
              height: 10.0,
              decoration: new BoxDecoration(
                color: Color(status.statusColor),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Container(
                //width: 100.0,
                child: new Text(
                    status.statusID == 3
                        ? "${status.statusName}(${note.toString()})"
                        : status.statusName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: ThemePrimary.primaryFontFamily,
                        color: Colors.black87)),
              ),
            ),
          ],
        ),
      );
    }

    Widget _avatar() {
      return SizedBox(
        width: 50,
        height: 50,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTapShowChildrenProfile,
            child: Hero(
              tag: heroTag != null
                  ? heroTag
                  : DateTime.now().millisecondsSinceEpoch.toString(),
              child: new CachedNetworkImage(
                imageUrl: children.photo,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 35.0,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.transparent,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/user-default.jpeg"),
              ),
            ),
          ),
        ),
      );
    }

    final childrenThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: _avatar(),
    );
    final iconBirthday = new Positioned(
      // margin: new EdgeInsets.symmetric(vertical: 16.0),
      // alignment: Alignment(-0.80, 0.9),
      top: 45,
      left: 35,
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemePrimary.primaryColor, shape: BoxShape.circle),
        child: Icon(
          Icons.cake,
          color: Colors.yellow,
          size: 15,
        ),
      ),
    );
    final baseTextStyle =
        const TextStyle(fontFamily: ThemePrimary.primaryFontFamily);
    final regularTextStyle = baseTextStyle.copyWith(
        color: Colors.grey.shade600,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.grey.shade600,
        fontSize: 18.0,
        fontWeight: FontWeight.w600);

//     Widget _childrenValue({String value}) {
//       return new Row(children: <Widget>[
// //            new Image(image: new NetworkImage(image),height: 12.0,),
// //            new Container(width: 8.0),
//         new Text(value, style: regularTextStyle),
//       ]);
//     }

    final childrenCardContent = InkWell(
      onTap: () {
        if (isEnableTapChildrenContentCard) {
          _getPosition();
          if (MediaQuery.of(context).size.height - _position.dy < 200)
            _position =
                Offset(_position.dx, MediaQuery.of(context).size.height - 200);
          showGeneralDialog(
              transitionBuilder: (context, a1, a2, widget) {
                return PopupCardTimeLinePage(ProfileChildrenDetailArgs(
                    offset: _position, homePageCardTimeLine: this));
              },
              transitionDuration: Duration(milliseconds: 200),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {
                return Container();
              });
        } else {
          if (selected != null) onChangeSelect();
        }
      },
      child:
          // Stack(
          //   children: <Widget>[
          Container(
//            color: Colors.blue,
        margin: new EdgeInsets.fromLTRB(50.0, 2.0, 5.0, 5.0),
        //constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
//                          color: Colors.green,
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (cardType == 1)
                            ? SizedBox()
                            : SizedBox(
                                height: 8,
                              ),
                        new Text(children.name,
                            overflow: TextOverflow.ellipsis,
                            style: headerTextStyle),
                        new Text(
                          children.schoolName.toString(),
                          style: subHeaderTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        new Text(children.gender.toString(),
                            style: subHeaderTextStyle),
                        (cardType == 1 && status != null)
                            ? _status()
                            : Container(
                                height: 11,
                              ),
                      ],
                    )),
                  ),
                  // Spacer(),
                  // Expanded(
                  //   child:
                  (status != null && status.statusID != 3)
                      ? cardType == 1
                          ? Column(
                              children: <Widget>[
                                if (isPickDrop)
                                  Container(
                                    width: 70.0,
                                    height: 30.0,
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius:
                                              5.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            5.0, // horizontal, move right 10
                                            5.0, // vertical, move down 10
                                          ),
                                        )
                                      ],
                                      color: (typePickDrop == 0)
                                          ? (status.statusID == 0)
                                              ? ThemePrimary.primaryColor
                                              : Colors.grey
                                          : (status.statusID == 1)
                                              ? ThemePrimary.primaryColor
                                              : Colors.grey,
//                                    : Colors.grey,
                                      //border: new Border.all(color: Colors.white, width: 2.0),
                                      borderRadius:
                                          new BorderRadius.circular(15.0),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: new InkWell(
                                          onTap: onTapPickUp,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: new Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.start,
                                            children: <Widget>[
                                              if (typePickDrop == 0 &&
                                                      status.statusID == 0 ||
                                                  typePickDrop == 1 &&
                                                      status.statusID == 1)
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
//                                              color: Colors.red,
                                                      alignment:
                                                          Alignment.center,
//                                                width: 20,
                                                      child: Icon(
                                                        Icons.arrow_drop_up,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )),
                                                ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  alignment: (typePickDrop ==
                                                                  0 &&
                                                              status.statusID ==
                                                                  0 ||
                                                          typePickDrop == 1 &&
                                                              status.statusID ==
                                                                  1)
                                                      ? Alignment.centerLeft
                                                      : Alignment.center,
                                                  child: Text(
                                                    setTextButtonStatus(),
                                                    style: new TextStyle(
                                                        fontFamily: ThemePrimary
                                                            .primaryFontFamily,
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              )
////                                          if(!setTextButtonStatus().contains('Đã đón'))
////                                            SizedBox(width: 4,),
//
                                            ],
                                          )),
                                    ),
                                  ),
                                if (isPickDrop)
                                  SizedBox(
                                    height: 5,
                                  ),
                                new Container(
                                  width: 70.0,
                                  height: 30.0,
                                  decoration: new BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius:
                                            5.0, // has the effect of softening the shadow
                                        spreadRadius:
                                            1.0, // has the effect of extending the shadow
                                        offset: Offset(
                                          5.0, // horizontal, move right 10
                                          5.0, // vertical, move down 10
                                        ),
                                      )
                                    ],
                                    color: (typePickDrop == 0)
                                        ? (status.statusID == 0)
                                            ? ThemePrimary.primaryColor
                                            : Colors.grey
                                        : (status.statusID == 1)
                                            ? ThemePrimary.primaryColor
                                            : Colors.grey,
//                                    border: new Border.all(color: Colors.white, width: 2.0),
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: new InkWell(
                                        onTap: (typePickDrop == 0)
                                            ? (status.statusID == 0)
                                                ? onTapScan
                                                : () {}
                                            : (status.statusID == 1)
                                                ? onTapScan
                                                : () {},
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.center,
//                                                color: Colors.green,
                                                child: QrImage(
                                                  padding: EdgeInsets.only(
                                                      left: 1.0),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  data: "ts24Corp",
                                                  version: 1,
                                                  size: 10.0,
//                                            gapless: false,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
//                                                color: Colors.red,
                                                child: Text(
                                                  'Quét',
                                                  style: new TextStyle(
                                                      fontFamily: ThemePrimary
                                                          .primaryFontFamily,
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                )
                              ],
                            )
                          : Container(
//                            color: Colors.yellow,
                              padding: EdgeInsets.only(right: 20, top: 8),
                              alignment: Alignment.center,
                              child: selected != null
                                  ? Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ThemePrimary.primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: selected
                                            ? Icon(
                                                Icons.check,
                                                size: 20.0,
                                                color: Colors.white,
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white)),
                                      ),
                                    )
                                  : (status != null)
                                      ? Text(
                                          typePickDrop == 0 ? 'Đón' : 'Trả',
                                          style: new TextStyle(
                                              fontFamily: ThemePrimary
                                                  .primaryFontFamily,
                                              fontSize: 14.0,
                                              color: ThemePrimary.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox(),
                            )
                      : (cardType == 1)
                          ? Container()
                          : Container(
//                            color: Colors.yellow,
                              padding: EdgeInsets.only(right: 20, top: 8),
                              alignment: Alignment.center,
                              child: selected != null
                                  ? Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ThemePrimary.primaryColor),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: selected
                                            ? Icon(
                                                Icons.check,
                                                size: 20.0,
                                                color: Colors.white,
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white)),
                                      ),
                                    )
                                  : (status != null)
                                      ? Text(
                                          typePickDrop == 0 ? 'Đón' : 'Trả',
                                          style: new TextStyle(
                                              fontFamily: ThemePrimary
                                                  .primaryFontFamily,
                                              fontSize: 14.0,
                                              color: ThemePrimary.primaryColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox(),
                            ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
//          cardType==1?Positioned(
//            top: 51,
//            left: 100,
//            child: _status(),
//          ):Container()
      //   ],
      // ),
    );

    final childrenCard = new Container(
      key: _key,
      child: childrenCardContent,
      // height: 85.0,
      margin: new EdgeInsets.only(left: 20.0),
      decoration: new BoxDecoration(
        color: Colors.white, //new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    DateTime birth = (children.birthday is bool || children.birthday == null)
        ? null
        : DateTime.parse(children.birthday);
    DateTime now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Container(
          //height: 80.0,
          child: new Stack(
        children: <Widget>[
          childrenCard,
          childrenThumbnail,
          if (birth != null && birth.day == now.day && birth.month == now.month)
            iconBirthday,
//              childrenAvatar,
        ],
      )),
    );
  }

  String setTextButtonStatus() {
    String str = "";
    if (typePickDrop == 0) {
      if (status.statusID == 0)
        str = 'Đón';
//      else if (status.statusID == 1)
//        str = 'Đã đón';
      else
        str = 'Đã đón';
    } else {
      if (status.statusID == 1 || status.statusID == 0)
        str = 'Trả';
//      else if (status.statusID == 2 || status.statusID == 4)
//        str = 'Đã trả';
      else
        str = 'Đã trả';
    }
    return str;
//    new Container(
//      width: 70.0,
//      height: 30.0,
//      decoration: new BoxDecoration(
//        boxShadow: [
//          BoxShadow(
//            color: Colors.black12,
//            blurRadius:
//            5.0, // has the effect of softening the shadow
//            spreadRadius:
//            1.0, // has the effect of extending the shadow
//            offset: Offset(
//              5.0, // horizontal, move right 10
//              5.0, // vertical, move down 10
//            ),
//          )
//        ],
//        color: ThemePrimary.primaryColor,
//        //border: new Border.all(color: Colors.white, width: 2.0),
//        borderRadius: new BorderRadius.circular(15.0),
//      ),
//      child: Material(
//        color: Colors.transparent,
//        child: new InkWell(
//          onTap: onTapPickUp,
//          borderRadius: BorderRadius.circular(15.0),
//          child: new Center(
//              child: Icon(FontAwesomeIcons.qrcode, color: Colors.white,)
//          ),
//        ),
//      ),
//    )
  }
}
