import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
class BusTimeLine {
  ui.Image image;
  double percent;
  int routBusIndex;
  BusTimeLine({this.image,this.routBusIndex,this.percent}){
   _initImage();
  }
  Future<Null> _initImage() async {
    final ByteData data = await rootBundle.load('assets/images/icon_bus.png');
    image = await _loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> _loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}