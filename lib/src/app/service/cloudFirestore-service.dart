import 'dart:convert';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/childrenBusSession.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class CloudFiresStoreService {
  final Geoflutterfire _geo = Geoflutterfire();
  final Firestore _firestore = Firestore.instance;
  DocumentReference _docRef;
  static final CloudFiresStoreService _singleton =
      new CloudFiresStoreService._internal();

  factory CloudFiresStoreService() {
    return _singleton;
  }

  CloudFiresStoreService._internal();

  // syncColectionChildrenBusSession() {
  //   if (_docRef == null)
  //     ChildrenBusSession.list.forEach((data) {
  //       _firestore
  //           .collection("childrenBusSession")
  //           .document(data.sessionID)
  //           .setData(data.toJson())
  //           .then((onValue) {
  //         _docRef = _firestore.document(data.sessionID);
  //       }).catchError((onError) {
  //         print("Error adding document: " + onError);
  //       });
  //     });
  // }

  // updateChildrenBusSession(ChildrenBusSession data) {
  //   _firestore
  //       .collection("childrenBusSession")
  //       .document(data.sessionID)
  //       .setData(data.toJson())
  //       .then((onValue) {
  //     _docRef = _firestore.document(data.sessionID);
  //   }).catchError((onError) {
  //     print("Error adding document: " + onError);
  //   });
  // }

  syncColectionDriverBusSession() {
    if (_docRef == null)
      DriverBusSession.list.forEach((data) {
        _firestore
            .collection("DriverBusSession")
            .document(data.sessionID)
            .setData(data.toJson())
            .then((onValue) {
          _docRef = _firestore.document(data.sessionID);
        }).catchError((onError) {
          print("Error adding document: " + onError);
        });
      });
  }

  Stream<DocumentSnapshot> listenDriverBusSession(sessionID) {
    return _firestore
        .collection("DriverBusSession")
        .document(sessionID)
        .snapshots();
  }

  Stream<QuerySnapshot> listenAllDriverBusSession() {
    return _firestore.collection("DriverBusSession").snapshots();
  }

  updateDriverBusSession(DriverBusSession data) {
    _firestore
        .collection("DriverBusSession")
        .document(data.sessionID)
        .setData(data.toJson())
        .then((onValue) {
      _docRef = _firestore.document(data.sessionID);
    }).catchError((onError) {
      print("Error adding document: " + onError);
    });
  }

  updateChildrenBusSession(ChildrenBusSession data) {
    _firestore
        .collection("childrenBusSession")
        .document(data.sessionID)
        .setData(data.toJson())
        .then((onValue) {
      _docRef = _firestore.document(data.sessionID);
    }).catchError((onError) {
      print("Error adding document: " + onError);
    });
  }

  updateStatusChildrenBus(Children children, ChildDrenStatus childrenStatus) {
    ChildrenBusSession childBusSession = ChildrenBusSession.list
        .singleWhere((item) => item.child.id == children.id);
    childBusSession.status = StatusBus.list[childrenStatus.statusID];
    updateChildrenBusSession(childBusSession);
  }

  Stream<DocumentSnapshot> listenChildrenBusSession(sessionID) {
    return _firestore
        .collection("childrenBusSession")
        .document(sessionID)
        .snapshots();
  }
}
