import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/content_timeline_widget.dart';
import 'package:b2s_driver/src/app/widgets/home_page_cart_timeline.dart';
import 'package:flutter/material.dart';

class HomePageTimeLine extends StatelessWidget {
  final List<EventTime> listTimeLine;
  HomePageTimeLine({this.listTimeLine});
  @override
  Widget build(BuildContext context) {
    HomePageViewModel viewModel = ViewModelProvider.of(context);
    // return Stepper(
    //   // controlsBuilder: (BuildContext context,
    //   //         {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
    //   //     Container(),

    //   steps: <Step>[
    //     ...listTimeLine.map((item) {
    //       return Step(
    //           title: Text(item.time),
    //           content: ContentTimeLine(
    //             evenTime: item,
    //           ));
    //     }).toList()
    //   ],
    // );
    return ListView.builder(
        itemCount: listTimeLine.length,
        padding: const EdgeInsets.only(bottom: 40),
        itemBuilder: (context, i) {
          double heightTimeLine = 0;
          if (viewModel.heightTimeline != null) if (viewModel
                  .heightTimeline.length >
              0) if (i < viewModel.heightTimeline.length)
            heightTimeLine = viewModel.heightTimeline[i];
          return _ContainerHomeTimeLine(
              evenTime: listTimeLine[i],
              heightTimeLine: heightTimeLine,
              index: i);
        });
  }
}

class _ContainerHomeTimeLine extends StatelessWidget {
  final EventTime evenTime;
  final double heightTimeLine;
  final int index;

  _ContainerHomeTimeLine(
      {Key key, this.evenTime, this.heightTimeLine, this.index})
      : super(key: key);

  final GlobalKey _contraintKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    HomePageViewModel viewModel = ViewModelProvider.of(context);
    getHeight(_) {
      final double _height = _contraintKey.currentContext.size.height - 40 > 0
          ? _contraintKey.currentContext.size.height - 40
          : 0;
      viewModel.heightTimeline.add(_height);
      viewModel.updateState();
    }

    void initState() {
      //calling the getHeight Function after the Layout is Rendered
      WidgetsBinding.instance.addPostFrameCallback(getHeight);
    }

    return StatefulWrapper(
      onInit: initState,
      child: Container(
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
                                height: heightTimeLine,
                                width: 1.0,
                                color: (evenTime.isFinish)
                                    ? Colors.green
                                    : Colors.black54
                                  ..withOpacity(0.4)),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                            child: Text(
                              "${index + 1}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            decoration: new BoxDecoration(
                                color: (evenTime.isFinish)
                                    ? Colors.green
                                    : Colors.black54,
                                shape: BoxShape.circle),
                          ),
                        ],
                      ),
                    )),
                  ),
                  Container(
                    child: ContentTimeLine(
                      evenTime: evenTime,
                      key: _contraintKey,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventTime {
  String time;
  String task;
  List<HomePageCardTimeLine> content;
  bool isFinish;

  EventTime({this.time, this.task, this.content, this.isFinish});
}
