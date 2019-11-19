import 'package:b2s_driver/src/app/models/res-partner.dart';

class ProfileMessageUserModel {
  dynamic peerId;
  dynamic avatarUrl;
  String address;
  String name;
  String phone;
  String email;
  ProfileMessageUserModel({this.peerId,this.avatarUrl,this.name,this.address,this.phone,this.email});
  ProfileMessageUserModel.fromDocumentSnapShot(ResPartner resPartner){
    peerId = resPartner.id;
    avatarUrl = resPartner.image;
    name = resPartner.displayName;
    address = resPartner.contactAddress;
    phone = resPartner.phone.toString();
    email = resPartner.email.toString();
  }
}