import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/home_page_card_timeline.dart';
import 'package:flutter/material.dart';

class HomePageTimeLineV2 extends StatelessWidget {
  final List<TimeLineEvent> listTimeLine;
  HomePageTimeLineV2({this.listTimeLine});
  @override
  Widget build(BuildContext context) {
    double iconSize = 30;
    return Container(
      child: ListView.builder(
        itemCount: listTimeLine.length,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) {
          return new LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            RenderBox renderBox = context.findRenderObject();
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _lineStyle(context, iconSize, index, listTimeLine.length,
                      listTimeLine[index].isFinish, renderBox),
                  // _displayTime(listTimeLine[index].time),
                  _displayContent(listTimeLine[index], context)
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _displayContent(TimeLineEvent event, BuildContext context) {
    Widget __title() {
      return Padding(
        padding: new EdgeInsets.only(left: 20),
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
                    event.task,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      fontWeight: FontWeight.w700,
                      color: (event.isFinish) ? Colors.green : Colors.black,
                      fontSize: 16.0,
                      fontFamily: ThemePrimary.primaryFontFamily,
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
              Text(
                event.time,
                style: TextStyle(fontFamily: ThemePrimary.primaryFontFamily),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          // padding: const EdgeInsets.all(14.0),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(Radius.circular(12)),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Color(0x20000000),
          //           blurRadius: 5,
          //           offset: Offset(0, 3))
          //     ]),
          child: Column(
            //key: _containerKey,
            children: <Widget>[
              __title(),
              ...event.content,
            ],
          ),
        ),
      ),
    );
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish, RenderBox renderBox) {
    return Container(
        decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLength - 1 ?? true,
          isFinish: isFinish,
          renderBox: renderBox,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3),
                    color: Color(0x20000000),
                    blurRadius: 5)
              ]),
          child: Stack(
            children: <Widget>[
              Icon(
                  isFinish
                      ? Icons.fiber_manual_record
                      : Icons.radio_button_unchecked,
                  size: iconSize,
                  color: Theme.of(context).accentColor),
              Container(
                width: iconSize,
                height: iconSize,
                alignment: Alignment.center,
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}

class TimeLineEvent {
  final String time;
  final String task;
  final List<HomePageCardTimeLine> content;
  final bool isFinish;

  TimeLineEvent({this.time, this.task, this.content, this.isFinish});
}

class CustomIconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;
  final bool isFinish;
  final RenderBox renderBox;
  CustomIconDecoration({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
    this.isFinish,
    this.renderBox,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([onChanged]) {
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData,
        isFinish: isFinish,
        renderBox: renderBox);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstData;
  final bool lastData;
  final bool isFinish;
  final Paint paintLine;
  final RenderBox renderBox;
  IconLine({
    @required double iconSize,
    @required double lineWidth,
    @required bool firstData,
    @required bool lastData,
    this.isFinish,
    this.renderBox,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = isFinish != false ? Colors.blue : Colors.grey
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    print(renderBox);
    final leftOffset = Offset((iconSize / 2) + 10, renderBox.size.height);
    final double iconSpace = iconSize / 2;
    final Offset begin =
        configuration.size.topLeft(Offset(leftOffset.dx, leftOffset.dx + 5));
    final Offset end = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));
    if (!lastData) canvas.drawLine(begin, end, paintLine);
  }
}
