import 'package:b2s_driver/src/app/core/baseViewModel.dart';
import 'package:b2s_driver/src/app/models/children.dart';
import 'package:b2s_driver/src/app/models/driverBusSession.dart';
import 'package:b2s_driver/src/app/pages/home/profile_children/profile_children.dart';
import 'package:flutter/material.dart';

class BottomSheetListChildrenEmergencyViewModel extends ViewModelBase{
  DriverBusSession driverBusSession;
  List<ChildrenWithSelect> listChildrenWithSelect;
  BottomSheetListChildrenEmergencyViewModel();
  onTapShowChildrenProfile(Children children, String heroTag) {
    Navigator.pushNamed(context, ProfileChildrenPage.routeName,
        arguments: ProfileChildrenArgs(children: children, heroTag: heroTag));
  }
  initListChildrenWithSelect(){
    listChildrenWithSelect = driverBusSession.listChildren.map((child)=>ChildrenWithSelect(child, false)).toList();
  }
  onChangeSelect(ChildrenWithSelect childrenWithSelect){
    childrenWithSelect.isSelect = !childrenWithSelect.isSelect;
    this.updateState();
  }
  onSendListChildrenSOS(){
    Navigator.pop(context);
  }
}

class ChildrenWithSelect{
  Children _children;

  Children get children => _children;

  set children(Children children) {
    _children = children;
  }
  bool _isSelect;

  bool get isSelect => _isSelect;

  set isSelect(bool isSelect) {
    _isSelect = isSelect;
  }
  ChildrenWithSelect(this._children, this._isSelect);
}