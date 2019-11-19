
import 'package:b2s_driver/src/app/core/app_setting.dart';
import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/chat.dart';
import 'package:b2s_driver/src/app/models/driver.dart';
import 'package:b2s_driver/src/app/pages/message/messageDetail/message_detail_page.dart';
import 'package:b2s_driver/src/app/service/common-service.dart';
import 'package:flutter/material.dart';

class ContactsPageViewModel extends ViewModelBase{
  Driver driver = new Driver();
  List<Contacts> listContacts = List();
  List<Contacts> listContactsSearchResult = List();
  bool contactsLoading = true;
  ContactsPageViewModel(){
    initListContacts();
  }

  initListContacts(){
    contactsLoading = true;
    api.getListContact().then((lst) {
      lst.forEach((resPartner) {
        if(resPartner.id != driver.id) {
          Contacts contacts = new Contacts.fromDocumentSnapShot(resPartner);
          listContacts.add(contacts);
        }
      });
      contactsLoading = false;
      listContactsSearchResult = listContacts;
      this.updateState();
    });
  }
  onQueryChanged(String query){
    if(query != '')
      listContactsSearchResult = listContacts.where((contacts)=>Common.sanitizing(contacts.name.toLowerCase()).contains(Common.sanitizing(query.toLowerCase()))).toList();
    this.updateState();
  }
  onQuerySubmitted(String query){
  }

  onItemContactsClick(Contacts contacts) {
    Chatting chatting = Chatting(
        peerId: contacts.peerId.toString(),
        name: contacts.name,
        message: 'Hi',
        listMessage: new List(),
        avatarUrl: contacts.avatarUrl,
        datetime: DateTime.now().toIso8601String()
    );
    Navigator.pushNamed(context, MessageDetailPage.routeName, arguments: chatting,).then((_){
      Navigator.pop(context);
    });
  }
}