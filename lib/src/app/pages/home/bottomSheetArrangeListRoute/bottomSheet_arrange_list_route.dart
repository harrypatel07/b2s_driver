import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/home/bottomSheetArrangeListRoute/bottomSheet_arrange_list_route_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/listview_card_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetArrangeListRoute extends StatefulWidget {
  static const String routeName = '/bottomSheetArrangeListRoute';
  final DriverBusSession driverBusSession;

  const BottomSheetArrangeListRoute({Key key, this.driverBusSession})
      : super(key: key);
  @override
  _BottomSheetArrangeListRouteState createState() =>
      _BottomSheetArrangeListRouteState();
}

class _BottomSheetArrangeListRouteState
    extends State<BottomSheetArrangeListRoute> {
  BottomSheetArrangeListRouteViewModel viewModel =
      BottomSheetArrangeListRouteViewModel();
  @override
  void initState() {
    viewModel.driverBusSession = widget.driverBusSession;
    viewModel.onCreateListRouteBus();
//    viewModel.bottomSheetViewModelBase = widget.arguments.viewModel;
//    viewModel.listenData();
    super.initState();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final RouteBus item = viewModel.listRouteBus.removeAt(oldIndex);
        viewModel.listRouteBus.insert(newIndex, item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ThemePrimary.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(18.0),
                              topLeft: Radius.circular(18.0))),
//                      padding: EdgeInsets.only(top: 10),
                      margin: EdgeInsets.only(right: 1, left: 1),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            child: Text('SẮP XẾP LỊCH TRÌNH',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 2, right: 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(18.0),
                                      topLeft: Radius.circular(18.0))),
                              child: ReorderableListView(
                                onReorder: _onReorder,
                                scrollDirection: Axis.vertical,
//                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                children: List.generate(
                                  viewModel.listRouteBus.length,
                                      (index) {
                                    return ListViewCard(
                                      viewModel.listRouteBus,
                                      index,
                                      Key('$index'),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Positioned(
                  bottom: -5,
                  right: 2,
                  left: 2,
                  child: SafeArea(
                    bottom: true,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius:
                                2.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              2.0, // horizontal, move right 10
                              2.0, // vertical, move down 10
                            ),
                          )
                        ],
                        color: ThemePrimary.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0) //
                            ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          onTap: () {
                            viewModel.onTapSave();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            //color: Colors.orange[700],
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                      25.0) //         <--- border radius here
                                  ),
                            ),
                            child: Text(
                              'Lưu',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
