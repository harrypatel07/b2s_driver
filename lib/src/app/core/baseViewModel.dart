import 'dart:async';

import 'package:b2s_driver/src/app/service/cloudFirestore-service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

Type _typeOf<T>() => T;

abstract class ViewModelBase extends Model {
  void dispose() {
    streamController.close();
  }

  BuildContext context;
  StreamController streamController = StreamController();
  Stream get stream => streamController.stream;
  Sink get sink => streamController.sink;
  bool loading;
  CloudFiresStoreService cloudService = CloudFiresStoreService();
  ViewModelBase() {
    this.loading = false;
  }
  updateState() {
    this.sink.add(true);
  }

  showHideLoading(bool visible) {
    this.loading = visible;
    this.updateState();
  }
}

class ViewModelProvider<T extends ViewModelBase> extends StatefulWidget {
  ViewModelProvider({
    Key key,
    @required this.child,
    @required this.viewmodel,
  }) : super(key: key);

  final Widget child;
  final T viewmodel;

  @override
  _ViewModelProviderState<T> createState() => _ViewModelProviderState<T>();

  static T of<T extends ViewModelBase>(BuildContext context) {
    final type = _typeOf<_ViewModelProviderInherited<T>>();
    _ViewModelProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.viewmodel;
  }
}

class _ViewModelProviderState<T extends ViewModelBase>
    extends State<ViewModelProvider<T>> {
  @override
  void dispose() {
    widget.viewmodel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _ViewModelProviderInherited<T>(
      viewmodel: widget.viewmodel,
      child: widget.child,
    );
  }
}

class _ViewModelProviderInherited<T> extends InheritedWidget {
  _ViewModelProviderInherited({
    Key key,
    @required Widget child,
    @required this.viewmodel,
  }) : super(key: key, child: child);

  final T viewmodel;

  @override
  bool updateShouldNotify(_ViewModelProviderInherited oldWidget) => false;
}

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
