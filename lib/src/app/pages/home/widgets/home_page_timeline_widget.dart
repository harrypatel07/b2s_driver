
import 'package:b2s_driver/src/app/pages/home/widgets/content_row_timeline_widget.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/content_timeline_widget.dart';
import 'package:flutter/material.dart';

class HomePageTimeLine extends StatelessWidget {
  final List<EventTime> listTimeLine;
  HomePageTimeLine({this.listTimeLine});
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: listTimeLine.length,
        padding: const EdgeInsets.only(bottom: 40),
        itemBuilder: (context, index) {
        return _ContainerHomeTimeLine(index: index, listTimeLine: listTimeLine);
        });
  }
}

class _ContainerHomeTimeLine extends StatefulWidget {
    final List<EventTime> listTimeLine;
    final int index;
  const _ContainerHomeTimeLine({this.listTimeLine, this.index});
  @override
  _ContainerHomeTimeLineState createState() => _ContainerHomeTimeLineState(listTimeLine, index);
}

class _ContainerHomeTimeLineState extends State<_ContainerHomeTimeLine> {
    final List<EventTime> listTimeLine;
    final int index;
  _ContainerHomeTimeLineState(this.listTimeLine, this.index);
  double h = 0;
    final key = new GlobalKey<ContentTimeLineState>();
  @override
  void initState() {
    //calling the getHeight Function after the Layout is Rendered
    WidgetsBinding.instance.addPostFrameCallback(getHeight);
    super.initState();
  }

   getHeight(_) {
    final State state = key.currentState;
    final RenderBox box = state.context.findRenderObject();
    setState(() {
      final sizeHeight = box.size.height - 40;
      h =sizeHeight > 0 ? sizeHeight: 0;
    });
  }
  @override
  Widget build(BuildContext context) {
     return Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        width: 30.0,
                        child: Center(
                            child: Container(
           
                          margin: EdgeInsets.only(top: 10),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 11.0, top: 10),
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                    height: h,
                                    width: 1.0,
                                    color: (this.listTimeLine[index].isFinish)
                                        ? Colors.green
                                        : Colors.black54..withOpacity(0.4)),
                              ),
                              new Container(
                                width: 25,
                                height: 25,
                                child: new Icon(Icons.location_on,
                                size: 17,
                                    color: Colors.white),
                                decoration: new BoxDecoration(
                                    color: (this.listTimeLine[index].isFinish)
                                        ? Colors.green
                                        : Colors.black54,
                                    shape: BoxShape.circle),
                              ),
                            ],
                          ),
                        )),
                      ),
                      Container(
                        child: ContentTimeLine(index: index, listTimeLine: listTimeLine, key: key,),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
class EventTime {
   String time;
   String task;
   List<ContentRowTimeLine> content;
   bool isFinish;

   EventTime({this.time, this.task, this.content, this.isFinish});
}

