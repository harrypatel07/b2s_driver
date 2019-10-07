import 'package:b2s_driver/src/app/widgets/home_page_cart_timeline.dart';
import 'package:flutter/material.dart';

class HomePageTimeLineV2 extends StatelessWidget {
  final List<TimeLineEventTime> listTimeLine;
  HomePageTimeLineV2({this.listTimeLine});
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return Container(
      child: ListView.builder(
        itemCount: listTimeLine.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return new LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            RenderBox box = context.findRenderObject();
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _lineStyle(context, iconSize, index, listTimeLine.length,
                      listTimeLine[index].isFinish, box),
                  // _displayTime(listTimeLine[index].time),
                  _displayContent(listTimeLine[index])
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget _displayContent(TimeLineEventTime event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
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
            children: event.content,
          ),
        ),
      ),
    );
  }

  Widget _displayTime(String time) {
    return Container(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(time),
        ));
  }

  Widget _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish, RenderBox box) {
    return Container(
        decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 1,
          firstData: index == 0 ?? true,
          lastData: index == listLength - 1 ?? true,
          isFinish: isFinish,
          renderBox: box,
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
          child: Icon(
              isFinish
                  ? Icons.fiber_manual_record
                  : Icons.radio_button_unchecked,
              size: iconSize,
              color: Theme.of(context).accentColor),
        ));
  }
}

class TimeLineEventTime {
  final String time;
  final String task;
  final List<HomePageCardTimeLine> content;
  final bool isFinish;

  TimeLineEventTime({this.time, this.task, this.content, this.isFinish});
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
        isFinish: isFinish);
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
    final leftOffset = Offset((iconSize / 2) + 10, 137);
    final double iconSpace = iconSize / 1.5;

    final Offset top = configuration.size.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy - iconSpace));

    final Offset centerBottom = configuration.size
        .centerLeft(Offset(leftOffset.dx, leftOffset.dy + iconSpace));
    final Offset end =
        configuration.size.bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
