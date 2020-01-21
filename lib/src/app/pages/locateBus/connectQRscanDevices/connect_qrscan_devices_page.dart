import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/pages/locateBus/connectQRscanDevices/connect_qrscan_devices_viewmodel.dart';
import 'package:b2s_driver/src/app/theme/theme_primary.dart';
import 'package:b2s_driver/src/app/widgets/index.dart';
import 'package:b2s_driver/src/app/widgets/scan_result_titlte_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectQRScanDevicesPage extends StatefulWidget {
  static const String routeName = "/ConnectQRScanDevices";
  @override
  _ConnectQRScanDevicesPageState createState() =>
      _ConnectQRScanDevicesPageState();
}

class _ConnectQRScanDevicesPageState extends State<ConnectQRScanDevicesPage> {
  ConnectQRScanDeviceViewModel viewModel = ConnectQRScanDeviceViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appbar() {
      return TS24AppBar(
        title: Text('Quản lý đầu đọc mã vạch'),
        actions: <Widget>[
          if(viewModel.isBluetoothOn)
          viewModel.isScanning?
          Container(
            alignment: Alignment.center,
            width: 50,
            padding: EdgeInsets.fromLTRB(12, 15, 13, 15),
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor:
              AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ):
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              viewModel.onTapRefresh();
            },
          )
        ],
      );
    }

    Widget _title(String titleText, {bool showCircleLoading = false}) {
      return Container(
        margin: EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        height: 50,
        child: Row(
          children: <Widget>[
            Text(titleText,
                style: TextStyle(
                    color: ThemePrimary.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left),
            SizedBox(
              width: 10,
            ),
            if (showCircleLoading)
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ThemePrimary.primaryColor),
                ),
              )
          ],
        ),
      );
    }

    Widget _itemListConnectedDevices(BluetoothDevice bluetoothDevice) {
      return ListTile(
        title: Text(bluetoothDevice.name),
        subtitle: Text(bluetoothDevice.id.toString()),
        trailing: StreamBuilder<BluetoothDeviceState>(
          stream: bluetoothDevice.state,
          initialData: BluetoothDeviceState.disconnected,
          builder: (c, snapshot) {
            if (snapshot.data == BluetoothDeviceState.connected) {
              return StreamBuilder<BluetoothDeviceState>(
                stream: bluetoothDevice.state,
                initialData: BluetoothDeviceState.connecting,
                builder: (c, snapshot) {
                  return viewModel.handleButtonConnectedDevices(
                      snapshot, bluetoothDevice);
                },
              );
            }
            return Text('');
          },
        ),
      );
    }

    List<dynamic> _listConnectedDevices(AsyncSnapshot snapshot) {
      return snapshot.data.map((d) => _itemListConnectedDevices(d)).toList();
    }

    List<dynamic> _listConnectDevicesAvailable(AsyncSnapshot snapshot) {
      return snapshot.data
          .map(
            (r) => (viewModel.barcodeService.checkTargetDeive(r)
                ? ScanResultTile(
                    result: r,
                    onTap: () => viewModel.onTapConnectDevice(r),
                  )
                : Container()),
          )
          .toList();
    }

    Widget _noticeBluetoothNotAvailable() {
      return Card(
          color: ThemePrimary.colorParentApp,
          margin: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 70,
                  child: Icon(
                    Icons.warning,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Bluetooth chưa bật hoặc thiết bị không có chức năng bluetooth.',
                    style: TextStyle(color: Colors.white,fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                )
              ],
            ),
          ));
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  if (!viewModel.isBluetoothOn) _noticeBluetoothNotAvailable(),
                  if(viewModel.isBluetoothOn)
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: Stream.periodic(Duration(milliseconds: 500))
                        .asyncMap((_) =>
                            viewModel.barcodeService.instance.connectedDevices),
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: <Widget>[
                        // if(snapshot.data.length > 0)
                        _title("Thiết bị đã lưu"),
                        ..._listConnectedDevices(snapshot),
                      ],
                    ),
                  ),
                  if(viewModel.isBluetoothOn)
                  StreamBuilder<List<ScanResult>>(
                    stream: viewModel.barcodeService.scanResult(),
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: <Widget>[
                        // if(snapshot.data.length > 0)
                        _title("Thiết bị mới"),
                        ..._listConnectDevicesAvailable(snapshot)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appbar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
