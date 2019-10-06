import 'package:b2s_driver/src/app/pages/home/widgets/home_page_timeline_widget.dart';
import 'package:flutter/material.dart';

class ContentTimeLine extends StatefulWidget {
   final List<EventTime> listTimeLine;
    final int index;
  const ContentTimeLine({Key key, this.listTimeLine, this.index}) : super(key: key);

  @override
  ContentTimeLineState createState() => ContentTimeLineState(listTimeLine, index);
}

class ContentTimeLineState extends State<ContentTimeLine> {
   final List<EventTime> listTimeLine;
    final int index;
  ContentTimeLineState(this.listTimeLine, this.index);
  @override
  Widget build(BuildContext context) {
      return Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: 20.0, top: 10.0),
              child: new Container(
                margin: EdgeInsets.only(right: 10),
                //color: Colors.green,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Text(
                      listTimeLine[index].task.toUpperCase(),
                      style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        color: (listTimeLine[index].isFinish)
                            ? Colors.green
                            : Colors.black,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.access_time,
                        color: Colors.grey,
                      ),
                    ),
                    Text(listTimeLine[index].time),
                  ],
                ),
              ),
            ),
            new Column(
                //key: _containerKey,
                children: listTimeLine[index].content),
          ],
        ),
      );
  }
}