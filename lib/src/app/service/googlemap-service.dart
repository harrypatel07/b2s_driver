import 'dart:convert';
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapService {
  GoogleMapService();

  static Future<BitmapDescriptor> getMarkerIcon(String imageAsset) async {
    return BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(24, 24)), imageAsset);
  }

  static Future<List<LatLng>> directionGetListStep(
      LatLng from, LatLng to) async {
    var tripInfo = await directionGetTripInfo(from, to);
    List<LatLng> listLatLng = new List();
    for (var t in tripInfo.steps) {
      listLatLng
          .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
      listLatLng.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
    }
    return listLatLng;
  }

  static Future<TripInfoRes> directionGetTripInfo(
      LatLng from, LatLng to) async {
    String strOrigin =
        "origin=" + from.latitude.toString() + "," + from.longitude.toString();
    // Destination of route
    String strDest =
        "destination=" + to.latitude.toString() + "," + to.longitude.toString();
    // Sensor enabled
    String sensor = "sensor=false";
    String mode = "mode=driving";
    // Building the parameters to the web service
    String parameters = strOrigin + "&" + strDest + "&" + sensor + "&" + mode;
    // Output format
    String output = "json";
    // Building the url to the web service
    String url = "https://maps.googleapis.com/maps/api/directions/" +
        output +
        "?" +
        parameters +
        "&key=" +
        ggKey;

    print(url);
    final JsonDecoder _decoder = new JsonDecoder();
    return http.get(url).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
//      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" +
            statusCode.toString() +
            ",\"message\":\"error\",\"response\":" +
            res +
            "}";
        throw new Exception(res);
      }

      TripInfoRes tripInfoRes;
      try {
        var json = _decoder.convert(res);
        int distance = json["routes"][0]["legs"][0]["distance"]["value"];
        List<StepsRes> steps =
            _parseSteps(json["routes"][0]["legs"][0]["steps"]);

        tripInfoRes = new TripInfoRes(distance, steps);
      } catch (e) {
        throw new Exception(res);
      }

      return tripInfoRes;
    });
  }

  static List<StepsRes> _parseSteps(final responseBody) {
    var list = responseBody
        .map<StepsRes>((json) => new StepsRes.fromJson(json))
        .toList();

    return list;
  }
}

class TripInfoRes {
  final int distance; // met
  final List<StepsRes> steps;

  TripInfoRes(this.distance, this.steps);
}

class StepsRes {
  LatLng startLocation;
  LatLng endLocation;
  StepsRes({this.startLocation, this.endLocation});
//  Steps();
  factory StepsRes.fromJson(Map<String, dynamic> json) {
    return new StepsRes(
        startLocation: new LatLng(
            json["start_location"]["lat"], json["start_location"]["lng"]),
        endLocation: new LatLng(
            json["end_location"]["lat"], json["end_location"]["lng"]));
  }
}
