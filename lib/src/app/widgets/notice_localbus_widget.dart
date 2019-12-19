import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoticeLocalBus extends StatefulWidget {
  final Function onTap;
  final Widget content;
  const NoticeLocalBus({Key key, this.onTap, this.content}) : super(key: key);
  @override
  _NoticeLocalBusState createState() => _NoticeLocalBusState();
}

class _NoticeLocalBusState extends State<NoticeLocalBus> {
  int positionClick = -1;
  double a = 0.0;
  bool isShow = true;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          if (isShow)
            Positioned(
              right: 30,
//              top: 10,
//              bottom: 10,
              child: InkWell(
                onTap: widget.onTap,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(left: 15, right: 30, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0)),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: widget.content,
                ),
              ),
            ),
          Positioned(
              right: 10,
              top: 10,
              child: TS24Button(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ThemePrimary.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: isShow
                      ? Icon(
                          FontAwesomeIcons.angleDoubleRight,
                          size: 17,
                          color: Colors.white,
                        )
                      : Icon(
                          FontAwesomeIcons.angleDoubleLeft,
                          size: 17,
                          color: Colors.white,
                        )
                  // child: isShow
                  //     ?
                  //     Container(
                  //         margin: EdgeInsets.all(8),
                  //         child: Center(
                  //           child: Column(
                  //             children: <Widget>[
                  //               Row(
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     child: SizedBox(),
                  //                   ),
                  //                   Expanded(
                  //                     child: Transform.rotate(
                  //                       angle: 3.14 / 360 * 90,
                  //                       child: Icon(
                  //                         Icons.arrow_downward,
                  //                         size: 17,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     child: Transform.rotate(
                  //                       angle: 3.14 / 360 * 90,
                  //                       child: Icon(
                  //                         Icons.arrow_upward,
                  //                         size: 17,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     child: SizedBox(),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     : Container(
                  //         margin: EdgeInsets.all(8),
                  //         child: Center(
                  //           child: Column(
                  //             children: <Widget>[
                  //               Row(
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     child: SizedBox(),
                  //                   ),
                  //                   Expanded(
                  //                     child: Transform.rotate(
                  //                       angle: 3.14 / 360 * 90,
                  //                       child: Icon(
                  //                         Icons.arrow_upward,
                  //                         size: 17,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Row(
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     child: Transform.rotate(
                  //                       angle: 3.14 / 360 *90 ,
                  //                       child: Icon(
                  //                         Icons.arrow_downward,
                  //                         size: 17,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Expanded(
                  //                     child: SizedBox(),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  ))
        ],
      ),
    );
  }
}
