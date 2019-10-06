import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContentRowTimeLine extends StatefulWidget {
  final Function onTapPickUp;
  final Children children;
  final StatusBus status;
  final bool isEnablePicked;
  const ContentRowTimeLine({
    Key key,
    this.onTapPickUp,
    this.status,
    @required this.children,
    this.isEnablePicked,
  }) : super(key: key);
  @override
  _ContentRowTimeLineState createState() => _ContentRowTimeLineState(
        onTapPickUp: onTapPickUp,
        children: children,
        status: status,
        isEnablePicked: isEnablePicked,
      );
}

class _ContentRowTimeLineState extends State<ContentRowTimeLine> {
   Function onTapPickUp;
   Children children;
   StatusBus status;
   bool isEnablePicked;
  _ContentRowTimeLineState({
    this.onTapPickUp,
    this.status,
    @required this.children,
    this.isEnablePicked,
  });
  Widget _age() {
    return new Container(
      width: 15.0,
      height: 15.0,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          children.age.toString(),
          style: TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  Widget _status() {
    return new Container(
      width: 200.0,
      height: 50.0,
      child: Row(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left: 10, right: 5),
            width: 10.0,
            height: 10.0,
            decoration: new BoxDecoration(
              color: Color(status.statusColor),
              shape: BoxShape.circle,
            ),
          ),
          new Text(status.statusName,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _avatar() {
    // return new Container(
    //     width: 50.0,
    //     height: 60.0,
    // decoration: new BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black38,
    //         blurRadius: 20.0, // has the effect of softening the shadow
    //         spreadRadius: 5.0, // has the effect of extending the shadow
    //         offset: Offset(
    //           10.0, // horizontal, move right 10
    //           10.0, // vertical, move down 10
    //         ),
    //       )
    //     ],
    //     shape: BoxShape.circle,
    //     image: new DecorationImage(
    //         fit: BoxFit.cover, image: new NetworkImage(children.photo))));

    return Container(
      width: 50,
      height: 50,
      child: CachedNetworkImage(
        imageUrl: children.photo,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 35.0,
          backgroundImage: imageProvider,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final childrenThumbnail = new Container(
        margin: new EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: _avatar());

    final childrenAvatar = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment(-0.80, 0.9),
      child: _age(),
    );
    final childrenStatus = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment(0.6, 0.9),
      child: _status(),
    );
    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: Colors.grey.shade600,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.grey.shade600,
        fontSize: 18.0,
        fontWeight: FontWeight.w600);

    Widget _childrenValue({String value}) {
      return new Row(children: <Widget>[
//            new Image(image: new NetworkImage(image),height: 12.0,),
//            new Container(width: 8.0),
        new Text(value, style: regularTextStyle),
      ]);
    }

    final childrenCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(50.0, 5.0, 5.0, 5.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            //color: Colors.white70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                new Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(height: 4.0),
                    new Text(children.name, style: headerTextStyle),
                    new Container(height: 4.0),
                    new Text(children.gender == 'F' ? 'Girl' : 'Boy',
                        style: subHeaderTextStyle),
                  ],
                )),
                Spacer(),
                new InkWell(
                  onTap: () {
                    onTapPickUp();
                    // setState(() {
                    //   isEnablePicked = !isEnablePicked;
                    //   if(isEnablePicked)
                    //     status = StatusBus.getStatusByID(StatusBus.list, 0);
                    //     else    status = StatusBus.getStatusByID(StatusBus.list, 1);
                    // });
                  },
                  child: new Container(
                    width: 60.0,
                    height: 30.0,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
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
                      color: (isEnablePicked == true)
                          ? Colors.blueAccent
                          : Colors.grey,
                      //border: new Border.all(color: Colors.white, width: 2.0),
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    child: new Center(
                      child: new Text(
                        "Picked",
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: new Row(
              children: <Widget>[
                Container(child: _childrenValue(value: children.location)),
                Spacer(),
                Container(
                    child: Icon(
                  Icons.location_on,
                  color: Colors.grey.shade600,
                ))
//              new Expanded(
//                  child: _childrenValue(
//                      value: children.age.toString(), image: children.photo))
              ],
            ),
          ),
        ],
      ),
    );

    final childrenCard = new Container(
      child: childrenCardContent,
      height: 80.0,
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Container(
          height: 80.0,
          child: new Stack(
            children: <Widget>[
              childrenCard,
              childrenThumbnail,
              childrenAvatar,
              childrenStatus,
            ],
          )),
    );
  }
}
// class ContentRowTimeLine extends StatelessWidget {
//   final Function onTapPickUp;
//   final Children children;
//   final StatusBus status;
//   final bool isEnablePicked;
//   const ContentRowTimeLine({
//     Key key,
//     this.onTapPickUp,
//     this.status,
//      @required this.children,
//     this.isEnablePicked,
//   }) : super(key: key);

//   Widget _age() {
//     return new Container(
//       width: 15.0,
//       height: 15.0,
//       decoration: new BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black54,
//             blurRadius: 20.0, // has the effect of softening the shadow
//             spreadRadius: 5.0, // has the effect of extending the shadow
//             offset: Offset(
//               10.0, // horizontal, move right 10
//               10.0, // vertical, move down 10
//             ),
//           )
//         ],
//         color: Colors.white,
//         shape: BoxShape.circle,
//       ),
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           children.age.toString(),
//           style: TextStyle(fontSize: 10),
//         ),
//       ),
//     );
//   }

//   Widget _status() {
//     return new Container(
//       width: 200.0,
//       height: 50.0,
//       child: Row(
//         children: <Widget>[
//           new Container(
//             margin: EdgeInsets.only(left: 10, right: 5),
//             width: 10.0,
//             height: 10.0,
//             decoration: new BoxDecoration(
//               color: Color(status.statusColor),
//               shape: BoxShape.circle,
//             ),
//           ),
//           new Text(status.statusName,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey)),
//         ],
//       ),
//     );
//   }

//   Widget _avatar() {
//     // return new Container(
//     //     width: 50.0,
//     //     height: 60.0,
//     // decoration: new BoxDecoration(
//     //     boxShadow: [
//     //       BoxShadow(
//     //         color: Colors.black38,
//     //         blurRadius: 20.0, // has the effect of softening the shadow
//     //         spreadRadius: 5.0, // has the effect of extending the shadow
//     //         offset: Offset(
//     //           10.0, // horizontal, move right 10
//     //           10.0, // vertical, move down 10
//     //         ),
//     //       )
//     //     ],
//     //     shape: BoxShape.circle,
//     //     image: new DecorationImage(
//     //         fit: BoxFit.cover, image: new NetworkImage(children.photo))));

//     return Container(
//       width: 50,
//       height: 50,
//       child: CachedNetworkImage(
//         imageUrl: children.photo,
//         imageBuilder: (context, imageProvider) => CircleAvatar(
//           radius: 35.0,
//           backgroundImage: imageProvider,
//           backgroundColor: Colors.transparent,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final childrenThumbnail = new Container(
//         margin: new EdgeInsets.symmetric(vertical: 16.0),
//         alignment: FractionalOffset.centerLeft,
//         child: _avatar());

//     final childrenAvatar = new Container(
//       margin: new EdgeInsets.symmetric(vertical: 16.0),
//       alignment: Alignment(-0.80, 0.9),
//       child: _age(),
//     );
//     final childrenStatus = new Container(
//       margin: new EdgeInsets.symmetric(vertical: 16.0),
//       alignment: Alignment(0.6, 0.9),
//       child: _status(),
//     );
//     final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
//     final regularTextStyle = baseTextStyle.copyWith(
//         color: Colors.grey.shade600,
//         fontSize: 14.0,
//         fontWeight: FontWeight.w400);
//     final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
//     final headerTextStyle = baseTextStyle.copyWith(
//         color: Colors.grey.shade600,
//         fontSize: 18.0,
//         fontWeight: FontWeight.w600);

//     Widget _childrenValue({String value}) {
//       return new Row(children: <Widget>[
// //            new Image(image: new NetworkImage(image),height: 12.0,),
// //            new Container(width: 8.0),
//         new Text(value, style: regularTextStyle),
//       ]);
//     }

//     final childrenCardContent = new Container(
//       margin: new EdgeInsets.fromLTRB(50.0, 5.0, 5.0, 5.0),
//       constraints: new BoxConstraints.expand(),
//       child: new Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           new Container(
//             //color: Colors.white70,
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               children: <Widget>[
//                 new Container(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     new Container(height: 4.0),
//                     new Text(children.name, style: headerTextStyle),
//                     new Container(height: 4.0),
//                     new Text(children.gender == 'F' ? 'Girl' : 'Boy',
//                         style: subHeaderTextStyle),
//                   ],
//                 )),
//                 Spacer(),
//                 new InkWell(
//                   onTap: (){
//                     onTapPickUp();
//                     setState();
//                   },
//                   child: new Container(
//                     width: 60.0,
//                     height: 30.0,
//                     decoration: new BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black38,
//                           blurRadius:
//                               5.0, // has the effect of softening the shadow
//                           spreadRadius:
//                               1.0, // has the effect of extending the shadow
//                           offset: Offset(
//                             5.0, // horizontal, move right 10
//                             5.0, // vertical, move down 10
//                           ),
//                         )
//                       ],
//                       color: (isEnablePicked == true)
//                           ? Colors.blueAccent
//                           : Colors.grey,
//                       //border: new Border.all(color: Colors.white, width: 2.0),
//                       borderRadius: new BorderRadius.circular(15.0),
//                     ),
//                     child: new Center(
//                       child: new Text(
//                         "Picked",
//                         style:
//                             new TextStyle(fontSize: 14.0, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           new Container(
//             width: MediaQuery.of(context).size.width,
//             height: 20,
//             child: new Row(
//               children: <Widget>[
//                 Container(child: _childrenValue(value: children.location)),
//                 Spacer(),
//                 Container(
//                     child: Icon(
//                   Icons.location_on,
//                   color: Colors.grey.shade600,
//                 ))
// //              new Expanded(
// //                  child: _childrenValue(
// //                      value: children.age.toString(), image: children.photo))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     final childrenCard = new Container(
//       child: childrenCardContent,
//       height: 80.0,
//       margin: new EdgeInsets.only(left: 20.0),
//       decoration: new BoxDecoration(
//         color: Colors.white, //new Color(0xFF333366),
//         shape: BoxShape.rectangle,
//         borderRadius: new BorderRadius.circular(8.0),
//         boxShadow: <BoxShadow>[
//           new BoxShadow(
//             color: Colors.black12,
//             blurRadius: 10.0,
//             offset: new Offset(0.0, 10.0),
//           ),
//         ],
//       ),
//     );
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: new Container(
//           height: 80.0,
//           child: new Stack(
//             children: <Widget>[
//               childrenCard,
//               childrenThumbnail,
//               childrenAvatar,
//               childrenStatus,
//             ],
//           )),
//     );
//   }
// }
