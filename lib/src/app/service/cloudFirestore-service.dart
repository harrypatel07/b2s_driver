import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/childrenBusSession.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/models/message.dart';
import 'package:b2s_driver/src/app/models/statusBus.dart';
import 'package:b2s_driver/src/app/service/encrypt-service.dart';
import 'package:b2s_driver/src/app/service/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFiresStoreService {
  //final Geoflutterfire _geo = Geoflutterfire();
  final CollectionChat chat = CollectionChat();
  final CollectionDriverBusSession busSession = CollectionDriverBusSession();
  static final CloudFiresStoreService _singleton =
      new CloudFiresStoreService._internal();

  factory CloudFiresStoreService() {
    return _singleton;
  }
  CloudFiresStoreService._internal();
}

class InterfaceFireStore {
  final Firestore _firestore = Firestore.instance;
  DocumentReference _docRef;
  final String fieldPathDocumentId = '__name__';
  final String split = "-";
}

class CollectionChat extends InterfaceFireStore {
  final _collectionName = "chat";

  Future sendMessage({String strId, String strPeerId, String content}) async {
    var id = EncrypteService.encryptHash(strId),
        peerId = EncrypteService.encryptHash(strPeerId),
        groupChatId = "";
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id$split$peerId';
    } else {
      groupChatId = '$peerId$split$id';
    }
    Messages message = Messages();
    message.senderId = strId;
    message.receiverId = strPeerId;
    message.content = content;
    message.timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    message.type = 0;
    var _jsonMessKey = Map<String, dynamic>.from(message.toJson());
    _jsonMessKey["keyword"] =
        Common.createKeyWordForChat(groupChatId, split: split);
    _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .setData(_jsonMessKey);
    var documentReference = _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
        .document();

    return await _firestore.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });
  }

  ///listen List Message by User Id
  Future<Stream<QuerySnapshot>> listenListMessageByUserId(String strId) async {
    final id = EncrypteService.encryptHash(strId);
    return _firestore
        .collection("chat")
        .where("keyword", arrayContains: id)
        .getDocuments()
        .asStream();
    // var id = EncrypteService.encrypt(strId).base64,
    //     peerId = EncrypteService.encrypt("User03").base64,
    //     groupChatId = "";
    // if (id.hashCode <= peerId.hashCode) {
    //   groupChatId = '$id-$peerId';
    // } else {
    //   groupChatId = '$peerId-$id';
    // }
    // return _firestore
    //     .collection('chat')
    //     .document(groupChatId)
    //     .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
    //     .snapshots();
  }

  ///listen List Message by id and peerID
  Future<Stream<QuerySnapshot>> listenListMessageByIdAndPeerId(
      String strId, String strPeerId) async {
    var id = EncrypteService.encryptHash(strId),
        peerId = EncrypteService.encryptHash(strPeerId),
        groupChatId = "";
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id$split$peerId';
    } else {
      groupChatId = '$peerId$split$id';
    }
    return _firestore
        .collection(_collectionName)
        .document(groupChatId)
        .collection(String.fromCharCodes(groupChatId.runes.toList().reversed))
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

class CollectionDriverBusSession extends InterfaceFireStore {
  final _collectionName = "DriverBusSession";
  syncColectionDriverBusSession() {
    if (_docRef == null)
      DriverBusSession.list.forEach((data) {
        _firestore
            .collection(_collectionName)
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
        .collection(_collectionName)
        .document(sessionID)
        .snapshots();
  }

  Stream<QuerySnapshot> listenAllDriverBusSession() {
    return _firestore.collection(_collectionName).snapshots();
  }

  updateDriverBusSession(DriverBusSession data) {
    _firestore
        .collection(_collectionName)
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
