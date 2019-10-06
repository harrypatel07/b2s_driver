import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/home_page_viewmodel_bk.dart';
import 'package:b2s_driver/src/app/pages/home/widgets/content_time_line_bk.dart';
import 'package:flutter/material.dart';

class MyTimeLine extends StatefulWidget{
  HomePageViewModel viewModel;
  ChildDrenRoute childDrenRoute;
  List<ChildDrenStatus> listChilDrenStatus;
  MyTimeLine(this.childDrenRoute,this.listChilDrenStatus,this.viewModel);
  @override
  _TimeLineState createState() => _TimeLineState(this.childDrenRoute,this.listChilDrenStatus,this.viewModel);
}
class _TimeLineState extends State<MyTimeLine> {
  HomePageViewModel viewModel;
  ChildDrenRoute childDrenRoute;
  List<ChildDrenStatus> listChilDrenStatus;
  _TimeLineState(this.childDrenRoute, this.listChilDrenStatus,this.viewModel);
  final key = new GlobalKey<ContentWidgetState>();
  double h = 0;
  @override
  initState() {
    //calling the getHeight Function after the Layout is Rendered
    WidgetsBinding.instance.addPostFrameCallback((_) =>h = getHeight());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Padding(
        padding: new EdgeInsets.symmetric(horizontal: 10.0),
        child: new Column(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 0),
                  height:  h,
                  width: 30.0,
                  child: new Center(
                      child: new Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Stack(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.only(left: 11.0,top:10),
                              child: new Container(
                                  margin: new EdgeInsets.symmetric(vertical: 20.0,),
                                  height: h,
                                  width: 1.0,
                                  color: (RouteBus.list[childDrenRoute.routeBusID - 1].status==true)?Colors.green: Colors.black54
                              ),),
                            new Container(
                              child: new Icon(Icons.location_on, color: Colors.white),
                              decoration: new BoxDecoration(
                                  color: (RouteBus.list[childDrenRoute.routeBusID - 1].status==true)?Colors.green: Colors.black54,
                                  shape: BoxShape.circle),),
                          ],
                        ),
                      )
                  ),
                ),
                Container(
                  child: new ContentTimeLineWidget(key: key,childDrenRoute: childDrenRoute,listChildDrenStatus: listChilDrenStatus,viewModel: viewModel,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  double getHeight() {
    final State state = key.currentState;
    final RenderBox box = state.context.findRenderObject();
    setState(() {
    });
    return box.size.height;
  }
}