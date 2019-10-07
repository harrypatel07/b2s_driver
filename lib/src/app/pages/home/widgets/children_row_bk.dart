import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel_bk.dart';
import 'package:flutter/material.dart';

import '../../../models/children.dart';

class ChildrenRowState extends State<ChildrenRow> {
  HomePageViewModel viewModel;
  Children children;
  int statusID;
  ChildrenRowState(this.children, this.statusID, this.viewModel);
  bool isEnablePicked;
  int isChangeStatus;
  @override
  void initState() {
    setState(() {
      isChangeStatus = statusID;
      if (statusID == 0)
        isEnablePicked = true;
      else
        isEnablePicked = false;
      //viewModel.ad = 'cao1';
    });
    super.initState();
  }

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
          "12",
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
              color: Color(StatusBus.list[isChangeStatus].statusColor),
              shape: BoxShape.circle,
            ),
          ),
          new Text(StatusBus.list[isChangeStatus].statusName,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _avatar() {
    return new Container(
        width: 50.0,
        height: 60.0,
        decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  10.0, // horizontal, move right 10
                  10.0, // vertical, move down 10
                ),
              )
            ],
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(children.photo))));
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
                  children: <Widget>[
                    new Container(height: 4.0),
                    new Text(children.name, style: headerTextStyle),
                    new Container(height: 4.0),
                    new Text(children.gender == 'F' ? 'Female' : 'Male',
                        style: subHeaderTextStyle),
                  ],
                )),
                Spacer(),
                new InkWell(
                  onTap: () {
                    setState(() {
                      isChangeStatus = 1;
                      if (isEnablePicked == true) {
                        viewModel.setStatusByChildrenID(
                            children.id, 1, ChildDrenStatus.list);
                        isEnablePicked = false;
                      }
                      //viewModel.setup();
                      //viewModel.ad="hiep";
                    });
                    //viewModel.setup();
                    //print("pick children"+viewModel.ad);
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

    return new Container(
        height: 80.0,
        child: new Stack(
          children: <Widget>[
            childrenCard,
            childrenThumbnail,
            childrenAvatar,
            childrenStatus,
          ],
        ));
  }
}

class ChildrenRow extends StatefulWidget {
  final HomePageViewModel viewModel;
  final Children children;
  final int statusID;
  ChildrenRow(this.children, this.statusID, this.viewModel);
  @override
  State<StatefulWidget> createState() =>
      new ChildrenRowState(this.children, this.statusID, this.viewModel);
}
