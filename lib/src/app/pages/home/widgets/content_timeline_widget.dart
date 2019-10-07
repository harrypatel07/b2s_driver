import 'package:b2s_driver/src/app/pages/home/widgets/home_page_timeline_widget.dart';
import 'package:flutter/material.dart';

class ContentTimeLine extends StatelessWidget {
  final EventTime evenTime;
  const ContentTimeLine({Key key, this.evenTime}) : super(key: key);

//   @override
//   ContentTimeLineState createState() => ContentTimeLineState(evenTime);
// }

// class ContentTimeLineState extends State<ContentTimeLine> {
//   final EventTime evenTime;
//   ContentTimeLineState(this.evenTime);
  @override
  Widget build(BuildContext context) {
    // return Column(
    //     //key: _containerKey,
    //     children: evenTime.content);
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
                  Expanded(
                    child: Container(
                      // width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        evenTime.task.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              (evenTime.isFinish) ? Colors.green : Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.grey,
                    ),
                  ),
                  Text(evenTime.time),
                ],
              ),
            ),
          ),
          new Column(
              //key: _containerKey,
              children: evenTime.content),
        ],
      ),
    );
  }
}
