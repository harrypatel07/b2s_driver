import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble {
  bool fromMe;
  String body;
  dynamic avatarUrl;
  String timestamp;
  MessageBubble({this.body, this.fromMe, this.avatarUrl, this.timestamp});
}

class Messages {
  String senderId;
  String receiverId;
  String timestamp;
  String content;
  String receiverName;
  int type;
  Messages(
      {this.senderId,
      this.receiverId,
      this.timestamp,
      this.type,
      this.content,
      this.receiverName});
  Messages.fromJson(Map<dynamic, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    timestamp = json['timestamp'];
    type = json['type'];
    content = json['content'];
    receiverName = json['receiverName'];
  }

  Messages.fromJsonPushNotification(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    timestamp = json['timestamp'];
    type = json['type'];
    content = json['content'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["senderId"] = this.senderId;
    data["receiverId"] = this.receiverId;
    data["timestamp"] = this.timestamp;
    data["type"] = this.type;
    data["content"] = this.content;
    return data;
  }

  Map<String, dynamic> toJsonPushNotification() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["senderId"] = this.senderId;
    data["receiverId"] = this.receiverId;
    data["timestamp"] = this.timestamp;
    data["type"] = this.type;
    data["content"] = this.content;
    data["receiverName"] = this.receiverName;
    return data;
  }

  Messages.fromDocumentSnapShot(DocumentSnapshot document) {
    senderId = document['senderId'];
    receiverId = document['receiverId'];
    timestamp = document['timestamp'];
    type = document['type'];
    content = document['content'];
  }
}
