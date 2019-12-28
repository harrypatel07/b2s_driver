import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/models-traccar/position.dart';
import 'package:b2s_driver/src/app/models/routeBus.dart';
import 'package:b2s_driver/src/app/pages/historyTripDetailPage/historyTripDetailMaps/historyTrip_detail_map_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/ts24_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryTripDetailMap extends StatefulWidget {
  static const String routeName = '/maps';
  final HistoryTripDetailMapArgs args;

  const HistoryTripDetailMap({Key key, this.args}) : super(key: key);
  @override
  _HistoryTripDetailMapState createState() => _HistoryTripDetailMapState();
}

class HistoryTripDetailMapArgs {
  final List<Positions> listPositions;
  final List<RouteBus> listRouteBus;

  HistoryTripDetailMapArgs(this.listPositions, this.listRouteBus);
}

class _HistoryTripDetailMapState extends State<HistoryTripDetailMap> {
  HistoryTripDetailMapViewModel viewModel = HistoryTripDetailMapViewModel();

  @override
  void initState() {
    viewModel.listPosition = widget.args.listPositions;
    viewModel.listRouteBus = widget.args.listRouteBus;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
//          viewModel.onSend();
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget backButton() {
      return Positioned(
        top: 0,
        left: 0,
        child: SafeArea(
          bottom: false,
          top: true,
          child: TS24Button(
            onTap: () {
              viewModel.onTapBackButton();
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25)),
              color: Colors.black54,
            ),
            width: 70,
            height: 50,
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: viewModel.center, zoom: 8),
                    onMapCreated: viewModel.onCreated,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    markers: viewModel.markers,
                    polylines: viewModel.polyLines,
                  ),
                  backButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
